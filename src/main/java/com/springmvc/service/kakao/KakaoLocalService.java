package com.springmvc.service.kakao;

import java.net.URI;
import java.util.LinkedHashSet;
import java.util.Set;

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
import com.springmvc.dto.restaurant.Restaurant;
import com.springmvc.repository.restaurant.RestaurantRepository;

@Service
public class KakaoLocalService {

    // 여기는 JavaScript 키가 아니라 REST API 키 넣어야 함
    private final String REST_API_KEY = "bb90d370055218fddaec7cd1d7044494";

    private final String KAKAO_LOCAL_URL =
            "https://dapi.kakao.com/v2/local/search/keyword.json";

    @Autowired
    private RestaurantRepository restaurantRepository;

    /**
     * 맛집 리스트 검색에서 DB 결과가 없을 때 호출하는 기본 import.
     *
     * 기존 문제점:
     * - 지역만 검색하면 query가 "대구", "전주"처럼 들어가서 카카오가 음식점 키워드로 보기 어려웠음.
     * - category_group_code를 FD6, CE7 두 번 붙여서 요청했음.
     * - 카카오 Local API는 category_group_code를 한 번에 하나만 명확히 주는 방식이 안전함.
     *
     * 수정:
     * - 컨트롤러에서 "지역 + 맛집" 또는 "지역 + 음식" 형태로 query를 만들어 넘김.
     * - 여기서는 FD6(음식점), CE7(카페)을 각각 따로 요청함.
     * - page 1~3까지 가져와서 지역 검색 결과가 부족한 문제를 줄임.
     */
    public int importRestaurants(String query) {
        int savedCount = 0;

        if (query == null || query.trim().isEmpty()) {
            return 0;
        }

        String cleanQuery = query.trim();

        // 같은 카카오 place id가 같은 import 안에서 중복 처리되지 않도록 방지
        Set<String> importedPlaceIds = new LinkedHashSet<>();

        String[] categoryGroupCodes = getCategoryGroupCodes(cleanQuery);

        for (String categoryGroupCode : categoryGroupCodes) {
            for (int page = 1; page <= 3; page++) {
                savedCount += importRestaurantsByPage(
                        cleanQuery,
                        categoryGroupCode,
                        page,
                        null,
                        null,
                        importedPlaceIds
                );
            }
        }

        System.out.println("카카오 전체 저장 시도 개수 = " + savedCount);
        return savedCount;
    }

    public int importRestaurants(String query, Double lat, Double lng) {
        int savedCount = 0;

        if (query == null || query.trim().isEmpty()) {
            return 0;
        }

        String cleanQuery = query.trim();
        Set<String> importedPlaceIds = new LinkedHashSet<>();
        String[] categoryGroupCodes = getCategoryGroupCodes(cleanQuery);

        for (String categoryGroupCode : categoryGroupCodes) {
            for (int page = 1; page <= 3; page++) {
                savedCount += importRestaurantsByPage(
                        cleanQuery,
                        categoryGroupCode,
                        page,
                        lat,
                        lng,
                        importedPlaceIds
                );
            }
        }

        System.out.println("카카오 위치 기반 전체 저장 시도 개수 = " + savedCount);
        return savedCount;
    }

    private int importRestaurantsByPage(
            String query,
            String categoryGroupCode,
            int page,
            Double lat,
            Double lng,
            Set<String> importedPlaceIds) {

        int savedCount = 0;

        try {
            System.out.println("카카오 검색 시작: query=" + query
                    + ", category=" + categoryGroupCode
                    + ", page=" + page);

            UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(KAKAO_LOCAL_URL)
                    .queryParam("query", query)
                    .queryParam("category_group_code", categoryGroupCode)
                    .queryParam("size", 15)
                    .queryParam("page", page);

            if (lat != null && lng != null) {
                builder.queryParam("x", lng)
                        .queryParam("y", lat)
                        .queryParam("radius", 3000)
                        .queryParam("sort", "distance");
            }

            URI uri = builder.build()
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

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(response.getBody());
            JsonNode documents = root.path("documents");

            System.out.println("검색 결과 개수 = " + documents.size());

            if (documents.isEmpty()) {
                return 0;
            }

            for (JsonNode item : documents) {
                String apiPlaceId = item.path("id").asText();

                if (apiPlaceId == null || apiPlaceId.isEmpty()) {
                    continue;
                }

                if (importedPlaceIds.contains(apiPlaceId)) {
                    continue;
                }

                importedPlaceIds.add(apiPlaceId);

                Restaurant restaurant = new Restaurant();
                restaurant.setApiPlaceId(apiPlaceId);
                restaurant.setPlaceUrl(item.path("place_url").asText());

                String kakaoCategoryName = item.path("category_name").asText();
                String placeName = item.path("place_name").asText();
                String foodKeyword = extractFoodKeyword(query);

                // 카카오 API는 검색어와 조금 다른 업종도 섞어서 내려줄 수 있음.
                // 예: "구미대 피자" 검색 시 카페/치킨이 같이 오는 경우.
                // 저장 전에 한 번 더 음식 키워드 기준으로 걸러야 화면에도 엉뚱한 결과가 안 남는다.
                if (!isMatchedFoodKeyword(foodKeyword, placeName, kakaoCategoryName)) {
                    System.out.println("검색어와 맞지 않아 제외: " + placeName
                            + " / " + kakaoCategoryName);
                    continue;
                }

                restaurant.setCategoryId(mapCategoryId(kakaoCategoryName));
                restaurant.setKakaoCategoryName(kakaoCategoryName);
                restaurant.setName(placeName);

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
                restaurant.setDescription(makeDescription(kakaoCategoryName));
                restaurant.setStatus("ACTIVE");

                System.out.println("저장 시도: " + restaurant.getName()
                        + " / " + restaurant.getAddress());

                restaurantRepository.insertRestaurant(restaurant);
                savedCount++;
            }

        } catch (Exception e) {
            System.out.println("카카오 맛집 저장 중 오류 발생");
            System.out.println("오류 메시지 = " + e.getMessage());
            e.printStackTrace();
        }

        return savedCount;
    }


    /**
     * 검색어에서 실제 음식 키워드만 뽑는다.
     * "구미대 피자"처럼 지역 + 음식으로 들어온 경우에도 피자만 기준으로 필터링하기 위함.
     */
    private String extractFoodKeyword(String query) {
        if (query == null) {
            return "";
        }

        String q = query.trim().toLowerCase();

        if (containsAny(q, "피자", "pizza", "도미노", "피자헛", "알볼로", "파파존스")) {
            return "피자";
        }
        if (containsAny(q, "치킨", "통닭", "닭강정", "찜닭", "교촌", "굽네", "페리카나", "bbq", "bhc", "푸라닭", "처갓집")) {
            return "치킨";
        }
        if (containsAny(q, "카페", "커피", "디저트", "베이커리")) {
            return "카페";
        }
        if (containsAny(q, "중식", "중국집", "짜장", "짬뽕", "탕수육", "마라")) {
            return "중식";
        }
        if (containsAny(q, "한식", "백반", "국밥", "찌개", "갈비", "삼겹살", "고기", "불고기")) {
            return "한식";
        }
        if (containsAny(q, "일식", "초밥", "스시", "라멘", "돈까스", "돈카츠", "우동")) {
            return "일식";
        }
        if (containsAny(q, "분식", "떡볶이", "김밥", "순대", "튀김")) {
            return "분식";
        }
        if (containsAny(q, "양식", "파스타", "스테이크", "샐러드", "햄버거", "버거")) {
            return "양식";
        }

        return "";
    }

    private boolean isMatchedFoodKeyword(String foodKeyword, String placeName, String categoryName) {
        if (foodKeyword == null || foodKeyword.trim().isEmpty()) {
            return true;
        }

        String target = ((placeName == null ? "" : placeName) + " "
                + (categoryName == null ? "" : categoryName)).toLowerCase();

        if ("피자".equals(foodKeyword)) {
            return containsAny(target, "피자", "pizza", "도미노", "피자헛", "알볼로", "파파존스", "피나치공");
        }
        if ("치킨".equals(foodKeyword)) {
            return containsAny(target, "치킨", "닭", "통닭", "닭강정", "찜닭", "후라이드", "양념", "오븐",
                    "교촌", "굽네", "노랑통닭", "페리카나", "bbq", "bhc", "푸라닭", "처갓집", "땅땅");
        }
        if ("카페".equals(foodKeyword)) {
            return containsAny(target, "카페", "커피", "디저트", "베이커리", "제과", "빵");
        }
        if ("중식".equals(foodKeyword)) {
            return containsAny(target, "중식", "중국", "짜장", "짬뽕", "탕수육", "마라");
        }
        if ("한식".equals(foodKeyword)) {
            return containsAny(target, "한식", "백반", "국밥", "찌개", "갈비", "삼겹살", "고기", "불고기");
        }
        if ("일식".equals(foodKeyword)) {
            return containsAny(target, "일식", "초밥", "스시", "라멘", "돈까스", "돈카츠", "우동");
        }
        if ("분식".equals(foodKeyword)) {
            return containsAny(target, "분식", "떡볶이", "김밥", "순대", "튀김");
        }
        if ("양식".equals(foodKeyword)) {
            return containsAny(target, "양식", "파스타", "스테이크", "샐러드", "햄버거", "버거");
        }

        return true;
    }

    private boolean containsAny(String text, String... keywords) {
        if (text == null) {
            return false;
        }
        for (String keyword : keywords) {
            if (keyword != null && !keyword.isEmpty() && text.contains(keyword.toLowerCase())) {
                return true;
            }
        }
        return false;
    }

    private String makeDescription(String kakaoCategoryName) {
        if (kakaoCategoryName == null) {
            return "카카오맵 기반 맛집 정보";
        }

        if (kakaoCategoryName.contains("카페") || kakaoCategoryName.contains("커피") || kakaoCategoryName.contains("디저트")) {
            return "카페 · 디저트";
        }
        if (kakaoCategoryName.contains("치킨")) {
            return "치킨 맛집";
        }
        if (kakaoCategoryName.contains("피자")) {
            return "피자 맛집";
        }
        if (kakaoCategoryName.contains("한식")) {
            return "한식 맛집";
        }
        if (kakaoCategoryName.contains("중식")) {
            return "중식 맛집";
        }
        if (kakaoCategoryName.contains("일식")) {
            return "일식 맛집";
        }
        if (kakaoCategoryName.contains("분식")) {
            return "분식 맛집";
        }
        return "카카오맵 기반 맛집 정보";
    }

    /**
     * 검색어가 치킨/한식/피자 같은 음식이면 음식점(FD6)만 조회한다.
     * 기존처럼 모든 검색에서 카페(CE7)까지 같이 조회하면
     * '구미대학교 치킨' 검색 때 감성커피 같은 결과가 섞일 수 있다.
     */
    private String[] getCategoryGroupCodes(String query) {

        if (query == null) {
            return new String[] {"FD6"};
        }

        String q = query.trim();

        if (q.contains("카페")
                || q.contains("커피")
                || q.contains("디저트")
                || q.contains("베이커리")) {
            return new String[] {"CE7"};
        }

        return new String[] {"FD6"};
    }

    private Long mapCategoryId(String kakaoCategoryName) {

        if (kakaoCategoryName == null) {
            return null;
        }

        if (kakaoCategoryName.contains("한식")) return 1L;
        if (kakaoCategoryName.contains("중식")) return 2L;
        if (kakaoCategoryName.contains("일식")) return 3L;
        if (kakaoCategoryName.contains("양식")
                || kakaoCategoryName.contains("샐러드")
                || kakaoCategoryName.contains("패스트푸드")) return 4L;
        if (kakaoCategoryName.contains("치킨")) return 5L;
        if (kakaoCategoryName.contains("분식")) return 6L;

        if (kakaoCategoryName.contains("카페")
                || kakaoCategoryName.contains("디저트")
                || kakaoCategoryName.contains("커피")) {
            return 7L;
        }

        if (kakaoCategoryName.contains("술집")
                || kakaoCategoryName.contains("호프")
                || kakaoCategoryName.contains("주점")
                || kakaoCategoryName.contains("이자카야")) {
            return 8L;
        }

        return null;
    }
}
