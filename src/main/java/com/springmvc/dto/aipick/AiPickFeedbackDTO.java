package com.springmvc.dto.aipick;

public class AiPickFeedbackDTO {

	private Long feedbackId;
	private Long memberId;
	private Long restaurantId;
	private String feedbackType;
	public AiPickFeedbackDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AiPickFeedbackDTO(Long feedbackId, Long memberId, Long restaurantId, String feedbackType) {
		super();
		this.feedbackId = feedbackId;
		this.memberId = memberId;
		this.restaurantId = restaurantId;
		this.feedbackType = feedbackType;
	}
	public Long getFeedbackId() {
		return feedbackId;
	}
	public void setFeedbackId(Long feedbackId) {
		this.feedbackId = feedbackId;
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
	public String getFeedbackType() {
		return feedbackType;
	}
	public void setFeedbackType(String feedbackType) {
		this.feedbackType = feedbackType;
	}
}
