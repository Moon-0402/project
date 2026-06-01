package com.springmvc.service.aipick;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.repository.aipick.AiPickFeedbackRepository;

@Service
public class AiPickFeedbackServiceImpl implements AiPickFeedbackService {

    @Autowired
    private AiPickFeedbackRepository aiPickFeedbackRepository;

    @Override
    public void saveFeedback(Long memberId, Long restaurantId, String feedbackType) {

        if (!"LIKE".equals(feedbackType) && !"DISLIKE".equals(feedbackType)) {
            throw new IllegalArgumentException("잘못된 피드백 값입니다.");
        }

        aiPickFeedbackRepository.saveFeedback(memberId, restaurantId, feedbackType);
    }
}