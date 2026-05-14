package com.springmvc.service.kakao;

import java.net.URI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.springmvc.controller.bookmark.BookmarkController;
import com.springmvc.dto.restaurant.Restaurant;
import com.springmvc.repository.restaurant.RestaurantRepository;

@Service
public class KakaoLocalService {

    private final BookmarkController bookmarkController;

    // 여기는 JavaScript 키가 아니라 REST API 키 넣어야 함
    private final String REST_API_KEY = "bb90d370055218fddaec7cd1d7044494";

    private final String KAKAO_LOCAL_URL =
            "https://dapi.kakao.com/v2/local/search/keyword.json";

    @Autowired
    private RestaurantRepository restaurantRepository;

    KakaoLocalService(BookmarkController bookmarkController) {
        this.bookmarkController = bookmarkController;
    }

    public int importRestaurants(String query) {
        int savedCount = 0;

        //                    .queryParam("category_group_code", "FD6")
        try {
            System.out.println("카카오 검색 시작: " + query);

            URI uri = UriComponentsBuilder.fromHttpUrl(KAKAO_LOCAL_URL)
                    .queryParam("query", query)
                    .queryParam("size", 15)
                    .queryParam("page", 1)
                    .build()
                    .encode()
                    .toUri();

            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "KakaoAK " + REST_API_KEY);

            HttpEntity<String> entity = new HttpEntity<>(headers);

            RestTemplate restTemplate = new RestTemplate();

            ResponseEntity<String> response = restTemplate.exchange(
                    uri,
                    HttpMethod.GET,
                    entity,
                    String.class
            );

            System.out.println("카카오 응답: " + response.getBody());

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(response.getBody());
            JsonNode documents = root.path("documents");

            System.out.println("검색 결과 개수: " + documents.size());

            for (JsonNode item : documents) {
                Restaurant restaurant = new Restaurant();

                restaurant.setApiPlaceId(item.path("id").asText());
                
                restaurant.setPlaceUrl(item.path("place_url").asText());

                String kakaoCategoryName = item.path("category_name").asText();
                
                restaurant.setCategoryId(mapCategoryId(kakaoCategoryName));
                restaurant.setKakaoCategoryName(kakaoCategoryName);

                restaurant.setName(item.path("place_name").asText());

                
                String roadAddress = item.path("road_address_name").asText();
                String address = item.path("address_name").asText();

                if (roadAddress != null && !roadAddress.isEmpty()) {
                    restaurant.setAddress(roadAddress);
                } else {
                    restaurant.setAddress(address);
                }

                restaurant.setLatitude(item.path("y").asDouble());
                restaurant.setLongitude(item.path("x").asDouble());

                String phone = item.path("phone").asText();
                if (phone != null && phone.length() > 20) {
                    phone = phone.substring(0, 20);
                }
                restaurant.setPhone(phone);

                restaurant.setOpeningHours("정보 없음");
                restaurant.setPriceRange("보통");
                restaurant.setDescription(query + " 관련 맛집");
                restaurant.setStatus("ACTIVE");

                System.out.println("저장 시도: " + restaurant.getName());

                restaurantRepository.insertRestaurant(restaurant);

                System.out.println("저장 성공: " + restaurant.getName());

                savedCount++;
            }

            System.out.println("총 저장 개수: " + savedCount);

        } catch (Exception e) {
            System.out.println("카카오 맛집 저장 중 오류 발생");
            System.out.println("오류 메시지 = " + e.getMessage());
            e.printStackTrace();
        }

        return savedCount;
    }
    private Long mapCategoryId(String kakaoCategoryName) {

        if (kakaoCategoryName.contains("한식")) return 1L;
        if (kakaoCategoryName.contains("중식")) return 2L;
        if (kakaoCategoryName.contains("일식")) return 3L;
        if (kakaoCategoryName.contains("양식") || kakaoCategoryName.contains("샐러드")) return 4L;
        if (kakaoCategoryName.contains("치킨")) return 5L;
        if (kakaoCategoryName.contains("분식")) return 6L;

        if (kakaoCategoryName.contains("카페")
                || kakaoCategoryName.contains("디저트")|| kakaoCategoryName.contains("커피")) {
            return 7L;
        }

        if (kakaoCategoryName.contains("술집")
                || kakaoCategoryName.contains("호프")
                || kakaoCategoryName.contains("주점")
                || kakaoCategoryName.contains("이자카야")) {
            return 8L;
        }

        return 1L;
    }
    
    public int importRestaurants(String query, Double lat, Double lng) {
        int savedCount = 0;

        try {
            System.out.println("카카오 위치기반 검색 시작: " + query);
            System.out.println("lat = " + lat);
            System.out.println("lng = " + lng);

            URI uri = UriComponentsBuilder.fromHttpUrl(KAKAO_LOCAL_URL)
                    .queryParam("query", query)
                    .queryParam("category_group_code", "FD6")
                    .queryParam("x", lng)
                    .queryParam("y", lat)
                    .queryParam("radius", 3000)
                    .queryParam("sort", "distance")
                    .queryParam("size", 15)
                    .queryParam("page", 1)
                    .build()
                    .encode()
                    .toUri();

            System.out.println("카카오 요청 URI = " + uri);

            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "KakaoAK " + REST_API_KEY);

            HttpEntity<String> entity = new HttpEntity<>(headers);

            RestTemplate restTemplate = new RestTemplate();

            ResponseEntity<String> response = restTemplate.exchange(
                    uri,
                    HttpMethod.GET,
                    entity,
                    String.class
            );

            System.out.println("카카오 응답: " + response.getBody());

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(response.getBody());
            JsonNode documents = root.path("documents");

            System.out.println("검색 결과 개수: " + documents.size());

            for (JsonNode item : documents) {
                Restaurant restaurant = new Restaurant();

                restaurant.setApiPlaceId(item.path("id").asText());
                restaurant.setPlaceUrl(item.path("place_url").asText());

                String kakaoCategoryName = item.path("category_name").asText();

                restaurant.setCategoryId(mapCategoryId(kakaoCategoryName));
                restaurant.setKakaoCategoryName(kakaoCategoryName);

                restaurant.setName(item.path("place_name").asText());

                String roadAddress = item.path("road_address_name").asText();
                String address = item.path("address_name").asText();

                if (roadAddress != null && !roadAddress.isEmpty()) {
                    restaurant.setAddress(roadAddress);
                } else {
                    restaurant.setAddress(address);
                }

                restaurant.setLatitude(item.path("y").asDouble());
                restaurant.setLongitude(item.path("x").asDouble());

                String phone = item.path("phone").asText();

                if (phone != null && phone.length() > 20) {
                    phone = phone.substring(0, 20);
                }

                restaurant.setPhone(phone);
                restaurant.setOpeningHours("정보 없음");
                restaurant.setPriceRange("보통");
                restaurant.setDescription(query + " 관련 맛집");
                restaurant.setStatus("ACTIVE");

                System.out.println("저장 시도: " + restaurant.getName());

                restaurantRepository.insertRestaurant(restaurant);

                System.out.println("저장 성공: " + restaurant.getName());

                savedCount++;
            }

            System.out.println("총 저장 개수: " + savedCount);

        } catch (Exception e) {
            System.out.println("카카오 위치기반 맛집 저장 중 오류 발생");
            System.out.println("오류 메시지 = " + e.getMessage());
            e.printStackTrace();
        }

        return savedCount;
    }
}