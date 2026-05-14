package com.springmvc.dto.recommend;

import java.time.LocalDateTime;

public class RecommendHistory {
    private Long recommendId;
    private Long memberId;
    private String situation;
    private String weather;
    private String priceRange;
    private String spicyLevel;
    private String selectedFood;
    private Long resultRestaurantId;
    private LocalDateTime createdAt;
	public RecommendHistory() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RecommendHistory(Long recommendId, Long memberId, String situation, String weather, String priceRange,
			String spicyLevel, String selectedFood, Long resultRestaurantId, LocalDateTime createdAt) {
		super();
		this.recommendId = recommendId;
		this.memberId = memberId;
		this.situation = situation;
		this.weather = weather;
		this.priceRange = priceRange;
		this.spicyLevel = spicyLevel;
		this.selectedFood = selectedFood;
		this.resultRestaurantId = resultRestaurantId;
		this.createdAt = createdAt;
	}
	public Long getRecommendId() {
		return recommendId;
	}
	public void setRecommendId(Long recommendId) {
		this.recommendId = recommendId;
	}
	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	public String getSituation() {
		return situation;
	}
	public void setSituation(String situation) {
		this.situation = situation;
	}
	public String getWeather() {
		return weather;
	}
	public void setWeather(String weather) {
		this.weather = weather;
	}
	public String getPriceRange() {
		return priceRange;
	}
	public void setPriceRange(String priceRange) {
		this.priceRange = priceRange;
	}
	public String getSpicyLevel() {
		return spicyLevel;
	}
	public void setSpicyLevel(String spicyLevel) {
		this.spicyLevel = spicyLevel;
	}
	public String getSelectedFood() {
		return selectedFood;
	}
	public void setSelectedFood(String selectedFood) {
		this.selectedFood = selectedFood;
	}
	public Long getResultRestaurantId() {
		return resultRestaurantId;
	}
	public void setResultRestaurantId(Long resultRestaurantId) {
		this.resultRestaurantId = resultRestaurantId;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
}