package com.springmvc.repository.restaurant;

import java.util.List;

import com.springmvc.dto.restaurant.Restaurant;
import com.springmvc.dto.restaurant.RestaurantDTO;
import com.springmvc.dto.restaurant.RestaurantMapDTO;

public interface RestaurantRepository {

    // 맛집 리스트 페이지
    List<RestaurantDTO> getRestaurantList();

    // 맛집 상세 페이지
    Restaurant getRestaurantById(Long restaurantId);

    // 지도 전체보기 페이지
    List<RestaurantMapDTO> getRestaurantMapList();

    // 맛집 관리 - 등록
    void insertRestaurant(Restaurant restaurant);

    // 맛집 관리 - 수정
    void updateRestaurant(Restaurant restaurant);

    // 맛집 관리 - 삭제
    void deleteRestaurant(Long restaurantId);

    // 관리자 맛집 관리 페이지 - 페이징 조회
    List<RestaurantDTO> getAdminRestaurantList(int offset, int size);

    // 관리자 맛집 관리 페이지 - 전체 개수
    int countAdminRestaurantList();

    // 관리자 맛집 관리 페이지 - 맛집명 검색 + 페이징 조회
    List<RestaurantDTO> searchAdminRestaurantList(String keyword, int offset, int size);

    // 관리자 맛집 관리 페이지 - 맛집명 검색 결과 개수
    int countSearchAdminRestaurantList(String keyword);

    // 최근 본 맛집 저장
    void insertRecentlyRestaurant(Long memberId, Long restaurantId);

    // 최근 본 맛집 조회
    List<RestaurantDTO> getRecentlyRestaurantList(Long memberId);

    // 사용자 맛집 리스트 페이징
    List<RestaurantDTO> getRestaurantList(int offset, int size);

    // 사용자 맛집 검색 + 페이징
    List<RestaurantDTO> searchRestaurantList(String regionKeyword, String foodKeyword, int offset, int size);

    // 사용자 맛집 전체 개수
    int countRestaurantList();

    // 사용자 맛집 검색 결과 개수
    int countSearchRestaurantList(String regionKeyword, String foodKeyword);

    // 지도 검색용
    List<RestaurantMapDTO> getSearchRestaurantMapList(String regionKeyword, String foodKeyword);

    // 근처 맛집
    List<RestaurantDTO> getNearRestaurants(String keyword, Double lat, Double lng, int limit);
}