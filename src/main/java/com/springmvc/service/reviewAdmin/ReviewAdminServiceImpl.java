package com.springmvc.service.reviewAdmin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.dto.review.ReviewDTO;
import com.springmvc.repository.reviewAdmin.ReviewAdminRepository;

@Service
public class ReviewAdminServiceImpl implements ReviewAdminService {

	private final ReviewAdminRepository reviewAdminRepository;

	@Autowired
	public ReviewAdminServiceImpl(ReviewAdminRepository reviewAdminRepository) {
		this.reviewAdminRepository = reviewAdminRepository;
	}

	@Override
	public List<ReviewDTO> reviewManagement(int offset, int size) {
		return reviewAdminRepository.reviewManagement(offset, size);
	}

	@Override
	public int countReviewManagement() {
		return reviewAdminRepository.countReviewManagement();
	}

	@Override
	public void updateReviewStatus(Long reviewId, String status) {

		if (!"ACTIVE".equals(status) && !"BLOCKED".equals(status)) {
			throw new IllegalArgumentException("잘못된 리뷰 상태입니다.");
		}

		reviewAdminRepository.updateReviewStatus(reviewId, status);
	}

	@Override
	public List<ReviewDTO> findReviewByRestaurantName(String restaurantName, int offset, int size) {
		return reviewAdminRepository.findReviewByRestaurantName(restaurantName, offset, size);
	}

	@Override
	public int countReviewByRestaurantName(String restaurantName) {
		return reviewAdminRepository.countReviewByRestaurantName(restaurantName);
	}
}