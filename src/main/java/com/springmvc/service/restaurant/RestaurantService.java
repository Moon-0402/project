package com.springmvc.service.restaurant;

import java.util.List;

import com.springmvc.dto.restaurant.Restaurant;
import com.springmvc.dto.restaurant.RestaurantDTO;
import com.springmvc.dto.restaurant.RestaurantMapDTO;

public interface RestaurantService {

    List<RestaurantDTO> getRestaurantList();

    Restaurant getRestaurantById(Long restaurantId);

    List<RestaurantMapDTO> getRestaurantMapList();

    void insertRestaurant(Restaurant restaurant);

    void updateRestaurant(Restaurant restaurant);

    void deleteRestaurant(Long restaurantId);
    
    // 관리자 맛집 관리 페이지 - 페이징 조회
    List<RestaurantDTO> getAdminRestaurantList(int offset, int size);

    // 관리자 맛집 관리 페이지 - 전체 개수
    int countAdminRestaurantList();
    
    // 관리자 맛집 관리 페이지 - 맛집명 검색 + 페이징
    List<RestaurantDTO> searchAdminRestaurantList(String keyword, int offset, int size);
    
    // 관리자 맛집 관리 페이지 - 검색 결과 개수
    int countSearchAdminRestaurantList(String keyword);
    
    // 최근 본 맛집 저장
    void insertRecentlyRestaurant(Long memberId, Long restaurantId);
    
    // 최근 본 맛집 조회
    List<RestaurantDTO> getRecentlyRestaurantList(Long memberId);
    
    List<RestaurantDTO> getRestaurantList(int offset, int size);

    List<RestaurantDTO> searchRestaurantList(String regionKeyword, String foodKeyword, int offset, int size);

    int countRestaurantList();

    int countSearchRestaurantList(String resionKeyword, String foodKeyword);
    
    List<RestaurantMapDTO> getSearchRestaurantMapList(String resionKeyword, String foodKeyword);
    
    List<RestaurantDTO> getNearRestaurants(String keyword, Double lat, Double lng, int limit);
    
}