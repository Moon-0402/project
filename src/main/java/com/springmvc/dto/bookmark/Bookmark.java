package com.springmvc.dto.bookmark;

import java.time.LocalDateTime;

public class Bookmark {
    private Long bookmarkId;
    private Long memberId;
    private Long restaurantId;
    private LocalDateTime createdAt;
    
 // 화면 출력용: RESTAURANT / CATEGORY JOIN해서 가져올 값
    private String restaurantName;
    private String address;
    private String phone;
    private String priceRange;
    private String categoryName;
	public Bookmark() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Bookmark(Long bookmarkId, Long memberId, Long restaurantId, LocalDateTime createdAt, String restaurantName,
			String address, String phone, String priceRange, String categoryName) {
		super();
		this.bookmarkId = bookmarkId;
		this.memberId = memberId;
		this.restaurantId = restaurantId;
		this.createdAt = createdAt;
		this.restaurantName = restaurantName;
		this.address = address;
		this.phone = phone;
		this.priceRange = priceRange;
		this.categoryName = categoryName;
	}
	public Long getBookmarkId() {
		return bookmarkId;
	}
	public void setBookmarkId(Long bookmarkId) {
		this.bookmarkId = bookmarkId;
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
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public String getRestaurantName() {
		return restaurantName;
	}
	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPriceRange() {
		return priceRange;
	}
	public void setPriceRange(String priceRange) {
		this.priceRange = priceRange;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
}

