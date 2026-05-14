package com.springmvc.service.restaurant;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.dto.restaurant.Restaurant;
import com.springmvc.dto.restaurant.RestaurantDTO;
import com.springmvc.dto.restaurant.RestaurantMapDTO;
import com.springmvc.repository.restaurant.RestaurantRepository;

@Service
public class RestaurantServiceImpl implements RestaurantService {

    @Autowired
    private RestaurantRepository restaurantRepository;

    // 사용자 맛집 전체 조회
    @Override
    public List<RestaurantDTO> getRestaurantList() {
        return restaurantRepository.getRestaurantList();
    }

    // 맛집 상세 조회
    @Override
    public Restaurant getRestaurantById(Long restaurantId) {
        return restaurantRepository.getRestaurantById(restaurantId);
    }

    // 지도 전체보기 조회
    @Override
    public List<RestaurantMapDTO> getRestaurantMapList() {
        return restaurantRepository.getRestaurantMapList();
    }

    // 맛집 등록
    @Override
    public void insertRestaurant(Restaurant restaurant) {
        restaurantRepository.insertRestaurant(restaurant);
    }

    // 맛집 수정
    @Override
    public void updateRestaurant(Restaurant restaurant) {
        restaurantRepository.updateRestaurant(restaurant);
    }

    // 맛집 삭제
    @Override
    public void deleteRestaurant(Long restaurantId) {
        restaurantRepository.deleteRestaurant(restaurantId);
    }

    // 관리자 맛집 관리 페이지 - 페이징 조회
    @Override
    public List<RestaurantDTO> getAdminRestaurantList(
            int offset,
            int size) {

        return restaurantRepository.getAdminRestaurantList(
                offset,
                size
        );
    }

    // 관리자 맛집 관리 페이지 - 전체 개수 조회
    @Override
    public int countAdminRestaurantList() {

        return restaurantRepository.countAdminRestaurantList();
    }

    // 관리자 맛집 관리 페이지 - 맛집명 검색 + 페이징
    @Override
    public List<RestaurantDTO> searchAdminRestaurantList(
            String keyword,
            int offset,
            int size) {

        return restaurantRepository.searchAdminRestaurantList(
                keyword,
                offset,
                size
        );
    }

    // 관리자 맛집 관리 페이지 - 검색 결과 개수 조회
    @Override
    public int countSearchAdminRestaurantList(String keyword) {

        return restaurantRepository.countSearchAdminRestaurantList(
                keyword
        );
    }

    // 최근 본 맛집 저장
    @Override
    public void insertRecentlyRestaurant(
            Long memberId,
            Long restaurantId) {

        restaurantRepository.insertRecentlyRestaurant(
                memberId,
                restaurantId
        );
    }

    // 최근 본 맛집 조회
    @Override
    public List<RestaurantDTO> getRecentlyRestaurantList(Long memberId) {

        return restaurantRepository.getRecentlyRestaurantList(
                memberId
        );
    }

    // 사용자 맛집 리스트 - 페이징 조회
    @Override
    public List<RestaurantDTO> getRestaurantList(
            int offset,
            int size) {

        return restaurantRepository.getRestaurantList(
                offset,
                size
        );
    }

    // 지도 검색용 맛집 조회
    @Override
    public List<RestaurantMapDTO> getSearchRestaurantMapList(
            String regionKeyword,
            String foodKeyword) {

        return restaurantRepository.getSearchRestaurantMapList(
                regionKeyword,
                foodKeyword
        );
    }

    // 사용자 맛집 검색 + 페이징
    @Override
    public List<RestaurantDTO> searchRestaurantList(
            String regionKeyword,
            String foodKeyword,
            int offset,
            int size) {

        return restaurantRepository.searchRestaurantList(
                regionKeyword,
                foodKeyword,
                offset,
                size
        );
    }

    // 사용자 맛집 전체 개수 조회
    @Override
    public int countRestaurantList() {

        return restaurantRepository.countRestaurantList();
    }

    // 사용자 맛집 검색 결과 개수 조회
    @Override
    public int countSearchRestaurantList(
            String regionKeyword,
            String foodKeyword) {

        return restaurantRepository.countSearchRestaurantList(
                regionKeyword,
                foodKeyword
        );
    }

    // 사용자 위치 기반 근처 맛집 조회
    @Override
    public List<RestaurantDTO> getNearRestaurants(
            String keyword,
            Double lat,
            Double lng,
            int limit) {

        return restaurantRepository.getNearRestaurants(
                keyword,
                lat,
                lng,
                limit
        );
    }
}