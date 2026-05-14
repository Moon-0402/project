package com.springmvc.dto.restaurant;

import java.time.LocalDateTime;

public class RestaurantImage {
    private Long imageId;
    private Long restaurantId;
    private String imageUrl;
    private LocalDateTime createdAt;
	public RestaurantImage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RestaurantImage(Long imageId, Long restaurantId, String imageUrl, LocalDateTime createdAt) {
		super();
		this.imageId = imageId;
		this.restaurantId = restaurantId;
		this.imageUrl = imageUrl;
		this.createdAt = createdAt;
	}
	public Long getImageId() {
		return imageId;
	}
	public void setImageId(Long imageId) {
		this.imageId = imageId;
	}
	public Long getRestaurantId() {
		return restaurantId;
	}
	public void setRestaurantId(Long restaurantId) {
		this.restaurantId = restaurantId;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
}