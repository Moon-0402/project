package com.springmvc.dto.restaurant;

public class RestaurantMapDTO {
    private Long restaurantId;
    private String name;
    private String categoryName;
    private String address;
    private Double latitude;
    private Double longitude;
    private Double rating;
	public RestaurantMapDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RestaurantMapDTO(Long restaurantId, String name, String categoryName, String address, Double latitude,
			Double longitude, Double rating) {
		super();
		this.restaurantId = restaurantId;
		this.name = name;
		this.categoryName = categoryName;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.rating = rating;
	}
	public Long getRestaurantId() {
		return restaurantId;
	}
	public void setRestaurantId(Long restaurantId) {
		this.restaurantId = restaurantId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
	public Double getRating() {
		return rating;
	}
	public void setRating(Double rating) {
		this.rating = rating;
	}
}