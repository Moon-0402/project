package com.springmvc.service.aipick;

public interface AiPickFeedbackService {

	// AI PICK 좋아요/별로에요 피드백 저장
	void saveFeedback(Long memberId, Long restaurantId, String feedbackType);
}
