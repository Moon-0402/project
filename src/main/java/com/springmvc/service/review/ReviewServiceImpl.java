package com.springmvc.service.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.dto.review.ReviewDTO;
import com.springmvc.repository.review.ReviewRepository;

@Service
public class ReviewServiceImpl implements ReviewService{

	@Autowired
	private ReviewRepository reviewRepository;

	@Override
	public List<ReviewDTO> getReviewListByRestaurantId(Long restaurantId) {
		// TODO Auto-generated method stub
		return reviewRepository.getReviewListByRestaurantId(restaurantId);
	}

	@Override
	public void insertReview(ReviewDTO review) {
		// TODO Auto-generated method stub
		reviewRepository.insertReview(review);
	}

	@Override
	public void updateReview(ReviewDTO review) {
		// TODO Auto-generated method stub
		reviewRepository.updateReview(review);
	}

	@Override
	public ReviewDTO getReviewById(Long reviewId) {
		// TODO Auto-generated method stub
		return reviewRepository.getReviewById(reviewId);
	}

	@Override
	public List<ReviewDTO> getReviewListByMemberId(Long memberId) {
		// TODO Auto-generated method stub
		return reviewRepository.getReviewListByMemberId(memberId);
	}

	@Override
	public int countReviewByMemberAndRestaurant(Long memberId, Long restaurantId) {
		// TODO Auto-generated method stub
		return reviewRepository.countReviewByMemberAndRestaurant(memberId, restaurantId);
	}
}
