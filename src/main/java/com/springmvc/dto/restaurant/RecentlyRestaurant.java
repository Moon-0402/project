package com.springmvc.dto.restaurant;

import java.time.LocalDateTime;

public class RecentlyRestaurant {
    private Long recentlyId;
    private Long memberId;
    private Long restaurantId;
    private LocalDateTime viewedAt;
	public RecentlyRestaurant() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RecentlyRestaurant(Long recentlyId, Long memberId, Long restaurantId, LocalDateTime viewedAt) {
		super();
		this.recentlyId = recentlyId;
		this.memberId = memberId;
		this.restaurantId = restaurantId;
		this.viewedAt = viewedAt;
	}
	public Long getRecentlyId() {
		return recentlyId;
	}
	public void setRecentlyId(Long recentlyId) {
		this.recentlyId = recentlyId;
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
	public LocalDateTime getViewedAt() {
		return viewedAt;
	}
	public void setViewedAt(LocalDateTime viewedAt) {
		this.viewedAt = viewedAt;
	}
}