package com.springmvc.repository.aipick;

public interface AiPickFeedbackRepository {

	// 좋아요/별로에요 피드백 저장
	void saveFeedback(Long memberId, Long restaurantId, String feedbackType);
	
	// 사용자가 남긴 피드백 조회
	String getFeedback(Long memberId, Long restaurantId);
}
