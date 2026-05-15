package com.springmvc.service.reviewAdmin;

import java.util.List;

import com.springmvc.dto.review.ReviewDTO;

public interface ReviewAdminService {
	// 리뷰 관리 페이지
	List<ReviewDTO> reviewManagement(int offset, int size);

	// 전체 리뷰 개수
	int countReviewManagement();

	// 리뷰 상태 수정 페이지
	void updateReviewStatus(Long reviewId, String status);

	// 관리자 리뷰 조건 검색 페이지
	List<ReviewDTO> findReviewByRestaurantName(String restaurantName, int offset, int size);

	// 음식점 이름 검색 결과 개수
	int countReviewByRestaurantName(String restaurantName);
}
