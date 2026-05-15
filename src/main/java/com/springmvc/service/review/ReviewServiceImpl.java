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
	public List<ReviewDTO> getReviewListByRestaurantId(Long restaurantId, int offset, int size) {
		// TODO Auto-generated method stub
		return reviewRepository.getReviewListByRestaurantId(restaurantId, offset, size);
	}


	@Override
	public int countReviewByRestaurantId(Long restaurantId) {
		// TODO Auto-generated method stub
		return reviewRepository.countReviewByRestaurantId(restaurantId);
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
	public List<ReviewDTO> getReviewListByMemberId(Long memberId, int offset, int size) {
		// TODO Auto-generated method stub
		return reviewRepository.getReviewListByMemberId(memberId, offset, size);
	}

	@Override
	public int countReviewByMemberId(Long memberId) {
		// TODO Auto-generated method stub
		return reviewRepository.countReviewByMemberId(memberId);
	}

	@Override
	public int countReviewByMemberAndRestaurant(Long memberId, Long restaurantId) {
		// TODO Auto-generated method stub
		return reviewRepository.countReviewByMemberAndRestaurant(memberId, restaurantId);
	}

	@Override
	public List<ReviewDTO> getLatestReviewList(int limit) {
		// TODO Auto-generated method stub
		return reviewRepository.getLatestReviewList(limit);
	}

	@Override
	public List<ReviewDTO> getReviewList(int offset, int size) {
		// TODO Auto-generated method stub
		return reviewRepository.getReviewList(offset, size);
	}

	@Override
	public int countReview() {
		// TODO Auto-generated method stub
		return reviewRepository.countReview();
	}

	@Override
	public List<ReviewDTO> searchReviewList(String regionKeyword, String foodKeyword, int offset, int size) {
		// TODO Auto-generated method stub
		return reviewRepository.searchReviewList(regionKeyword, foodKeyword, offset, size);
	}

	@Override
	public int countSearchReviewList(String regionKeyword, String foodKeyword) {
		// TODO Auto-generated method stub
		return reviewRepository.countSearchReviewList(regionKeyword, foodKeyword);
	}

}
