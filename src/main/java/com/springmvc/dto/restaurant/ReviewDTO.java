package com.springmvc.dto.restaurant;

import java.time.LocalDateTime;

public class ReviewDTO {
    private Long reviewId;
    private String memberName;
    private String restaurantName;
    private Double rating;
    private String content;
    private String createdAt;
	public ReviewDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReviewDTO(Long reviewId, String memberName, String restaurantName, Double rating, String content,
			String createdAt) {
		super();
		this.reviewId = reviewId;
		this.memberName = memberName;
		this.restaurantName = restaurantName;
		this.rating = rating;
		this.content = content;
		this.createdAt = createdAt;
	}
	public Long getReviewId() {
		return reviewId;
	}
	public void setReviewId(Long reviewId) {
		this.reviewId = reviewId;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getRestaurantName() {
		return restaurantName;
	}
	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}
	public Double getRating() {
		return rating;
	}
	public void setRating(Double rating) {
		this.rating = rating;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
}