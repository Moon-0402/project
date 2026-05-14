package com.springmvc.dto.restaurant;

import java.time.LocalDateTime;

public class Category {
    private Long categoryId;
    private String categoryName;
	public Category() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Category(Long categoryId, String categoryName) {
		super();
		this.categoryId = categoryId;
		this.categoryName = categoryName;
	}
	public Long getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
}
