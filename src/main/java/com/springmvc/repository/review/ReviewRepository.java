package com.springmvc.repository.review;

import java.util.List;

import com.springmvc.dto.review.ReviewDTO;

public interface ReviewRepository {
	
	// 맛집 상세 페이지에서 해당 맛집 리뷰 목록 보기
	List<ReviewDTO> getReviewListByRestaurantId(Long restaurantId);
	
	// 리뷰 작성
	void insertReview(ReviewDTO review);
	
	// 리뷰 수정
	void updateReview(ReviewDTO review);
	
	// 리뷰 수정 화면/권한 확인용 단건 조회
	ReviewDTO getReviewById(Long reviewId);
	
	// 내가 쓴 리뷰 목록 보기
	List<ReviewDTO> getReviewListByMemberId(Long memberId);
	
	// 같은 회원이 같은 맛집에 이미 리뷰 썼는지 확인
	int countReviewByMemberAndRestaurant(Long memberId, Long restaurantId);
}
