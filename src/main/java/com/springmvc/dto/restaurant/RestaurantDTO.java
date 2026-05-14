package com.springmvc.dto.restaurant;

public class RestaurantDTO {
    private Long restaurantId;
    private String name;
    private String categoryName;
    private Double rating;
    private String imageUrl;
    private Double distance;
    private Double latitude;
    private Double longitude;
	public RestaurantDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RestaurantDTO(Long restaurantId, String name, String categoryName, Double rating, String imageUrl,
			Double distance, Double latitude, Double longitude) {
		super();
		this.restaurantId = restaurantId;
		this.name = name;
		this.categoryName = categoryName;
		this.rating = rating;
		this.imageUrl = imageUrl;
		this.distance = distance;
		this.latitude = latitude;
		this.longitude = longitude;
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
	public Double getRating() {
		return rating;
	}
	public void setRating(Double rating) {
		this.rating = rating;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public Double getDistance() {
		return distance;
	}
	public void setDistance(Double distance) {
		this.distance = distance;
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
	
    
}
