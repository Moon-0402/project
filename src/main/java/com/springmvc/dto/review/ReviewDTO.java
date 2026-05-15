package com.springmvc.dto.review;

import java.time.LocalDateTime;

public class ReviewDTO {
    private Long reviewId;
    private Long memberId;
    private Long restaurantId;
    private int rating;
    private String content;
    private String image;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String memberName;
    private String restaurantName;
	public ReviewDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReviewDTO(Long reviewId, Long memberId, Long restaurantId, int rating, String content, String image,
			String status, LocalDateTime createdAt, LocalDateTime updatedAt, String memberName, String restaurantName) {
		super();
		this.reviewId = reviewId;
		this.memberId = memberId;
		this.restaurantId = restaurantId;
		this.rating = rating;
		this.content = content;
		this.image = image;
		this.status = status;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.memberName = memberName;
		this.restaurantName = restaurantName;
	}
	public Long getReviewId() {
		return reviewId;
	}
	public void setReviewId(Long reviewId) {
		this.reviewId = reviewId;
	}
	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	public Long getRestaurantId() {
		return restaurantId;
	}
	public void setRestaurantId(Long restaurantId) {
		this.restaurantId = restaurantId;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
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
}