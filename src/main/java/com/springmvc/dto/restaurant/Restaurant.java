package com.springmvc.dto.restaurant;

import java.time.LocalDateTime;

public class Restaurant {
    private Long restaurantId;
    private String apiPlaceId;
    private Long categoryId;
    private String name;
    private String address;
    private Double latitude;
    private Double longitude;
    private String phone;
    private String openingHours;
    private String priceRange;
    private String description;
    private String status;
    private LocalDateTime createdAt;
    private String placeUrl;
    private String kakaoCategoryName;
	public Restaurant() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Restaurant(Long restaurantId, String apiPlaceId, Long categoryId, String name, String address,
			Double latitude, Double longitude, String phone, String openingHours, String priceRange, String description,
			String status, LocalDateTime createdAt, String placeUrl, String kakaoCategoryName) {
		super();
		this.restaurantId = restaurantId;
		this.apiPlaceId = apiPlaceId;
		this.categoryId = categoryId;
		this.name = name;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.phone = phone;
		this.openingHours = openingHours;
		this.priceRange = priceRange;
		this.description = description;
		this.status = status;
		this.createdAt = createdAt;
		this.placeUrl = placeUrl;
		this.kakaoCategoryName = kakaoCategoryName;
	}
	public Long getRestaurantId() {
		return restaurantId;
	}
	public void setRestaurantId(Long restaurantId) {
		this.restaurantId = restaurantId;
	}
	public String getApiPlaceId() {
		return apiPlaceId;
	}
	public void setApiPlaceId(String apiPlaceId) {
		this.apiPlaceId = apiPlaceId;
	}
	public Long getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getOpeningHours() {
		return openingHours;
	}
	public void setOpeningHours(String openingHours) {
		this.openingHours = openingHours;
	}
	public String getPriceRange() {
		return priceRange;
	}
	public void setPriceRange(String priceRange) {
		this.priceRange = priceRange;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public String getPlaceUrl() {
		return placeUrl;
	}
	public void setPlaceUrl(String placeUrl) {
		this.placeUrl = placeUrl;
	}
	public String getKakaoCategoryName() {
		return kakaoCategoryName;
	}
	public void setKakaoCategoryName(String kakaoCategoryName) {
		this.kakaoCategoryName = kakaoCategoryName;
	}
}