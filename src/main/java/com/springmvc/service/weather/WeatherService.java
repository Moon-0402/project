package com.springmvc.service.weather;

import java.net.URI;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.springmvc.dto.weather.WeatherDTO;

@Service
public class WeatherService {

    private final String SERVICE_KEY = "fdc2d2a8804c2847f4872116a1532c2f0ad7c8ddd1dc4f0039a21d42857aa7c8";
    private final String API_URL =
            "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst";

    public WeatherDTO getWeather(double lat, double lng) {
        try {
            String baseDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
            String baseTime = getUltraSrtBaseTime();

            int[] grid = convertToGrid(lat, lng);
            int nx = grid[0];
            int ny = grid[1];

            URI uri = UriComponentsBuilder.fromHttpUrl(API_URL)
                    .queryParam("serviceKey", SERVICE_KEY)
                    .queryParam("numOfRows", 60)
                    .queryParam("pageNo", 1)
                    .queryParam("dataType", "JSON")
                    .queryParam("base_date", baseDate)
                    .queryParam("base_time", baseTime)
                    .queryParam("nx", nx)
                    .queryParam("ny", ny)
                    .build()
                    .encode()
                    .toUri();

            RestTemplate restTemplate = new RestTemplate();
            String response = restTemplate.getForObject(uri, String.class);

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(response);

            JsonNode items = root.path("response")
                    .path("body")
                    .path("items")
                    .path("item");

            WeatherDTO dto = new WeatherDTO();

            for (JsonNode item : items) {
                String category = item.path("category").asText();
                String value = item.path("fcstValue").asText();

                if ("SKY".equals(category)) {
                    dto.setSky(convertSky(value));
                } else if ("PTY".equals(category)) {
                    dto.setPty(convertPty(value));
                } else if ("T1H".equals(category)) {
                    dto.setTemp(value);
                }
            }

            dto.setWeatherText(makeWeatherText(dto));
            return dto;

        } catch (Exception e) {
            WeatherDTO dto = new WeatherDTO();
            dto.setWeatherText("날씨 정보를 불러올 수 없음");
            return dto;
        }
    }

    private String getUltraSrtBaseTime() {
        LocalTime now = LocalTime.now();

        int hour = now.getHour();
        int minute = now.getMinute();

        if (minute < 45) {
            hour -= 1;
        }

        if (hour < 0) {
            hour = 23;
        }

        return String.format("%02d30", hour);
    }

    // 위도/경도 → 기상청 격자 좌표(nx, ny) 변환
    private int[] convertToGrid(double lat, double lng) {
        double RE = 6371.00877; // 지구 반경(km)
        double GRID = 5.0;      // 격자 간격(km)
        double SLAT1 = 30.0;    // 표준위도 1
        double SLAT2 = 60.0;    // 표준위도 2
        double OLON = 126.0;    // 기준점 경도
        double OLAT = 38.0;     // 기준점 위도
        double XO = 43;         // 기준점 X좌표
        double YO = 136;        // 기준점 Y좌표

        double DEGRAD = Math.PI / 180.0;

        double re = RE / GRID;
        double slat1 = SLAT1 * DEGRAD;
        double slat2 = SLAT2 * DEGRAD;
        double olon = OLON * DEGRAD;
        double olat = OLAT * DEGRAD;

        double sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5)
                / Math.tan(Math.PI * 0.25 + slat1 * 0.5);
        sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);

        double sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
        sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;

        double ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
        ro = re * sf / Math.pow(ro, sn);

        double ra = Math.tan(Math.PI * 0.25 + lat * DEGRAD * 0.5);
        ra = re * sf / Math.pow(ra, sn);

        double theta = lng * DEGRAD - olon;

        if (theta > Math.PI) {
            theta -= 2.0 * Math.PI;
        }

        if (theta < -Math.PI) {
            theta += 2.0 * Math.PI;
        }

        theta *= sn;

        int nx = (int) Math.floor(ra * Math.sin(theta) + XO + 0.5);
        int ny = (int) Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);

        return new int[] { nx, ny };
    }

    private String convertSky(String value) {
        switch (value) {
            case "1":
                return "맑음";
            case "3":
                return "구름많음";
            case "4":
                return "흐림";
            default:
                return "알 수 없음";
        }
    }

    private String convertPty(String value) {
        switch (value) {
            case "0":
                return "없음";
            case "1":
                return "비";
            case "2":
                return "비/눈";
            case "3":
                return "눈";
            case "5":
                return "빗방울";
            case "6":
                return "빗방울/눈날림";
            case "7":
                return "눈날림";
            default:
                return "알 수 없음";
        }
    }

    private String makeWeatherText(WeatherDTO dto) {
        if (dto.getPty() != null && !"없음".equals(dto.getPty())) {
            return dto.getPty();
        }

        if (dto.getSky() != null) {
            return dto.getSky();
        }

        return "날씨 정보 없음";
    }
}