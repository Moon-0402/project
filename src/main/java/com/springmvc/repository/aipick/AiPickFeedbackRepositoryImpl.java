package com.springmvc.repository.aipick;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AiPickFeedbackRepositoryImpl implements AiPickFeedbackRepository {

    @Autowired
    private JdbcTemplate template;

    @Override
    public void saveFeedback(Long memberId, Long restaurantId, String feedbackType) {

        String sql =
                "INSERT INTO AIPICK_FEEDBACK(member_id, restaurant_id, feedback_type) "
              + "VALUES (?, ?, ?) "
              + "ON DUPLICATE KEY UPDATE "
              + "feedback_type = VALUES(feedback_type), "
              + "created_at = CURRENT_TIMESTAMP";

        template.update(sql, memberId, restaurantId, feedbackType);
    }

    @Override
    public String getFeedback(Long memberId, Long restaurantId) {

        String sql =
                "SELECT feedback_type "
              + "FROM AIPICK_FEEDBACK "
              + "WHERE member_id = ? AND restaurant_id = ?";

        try {
            return template.queryForObject(
                    sql,
                    String.class,
                    memberId,
                    restaurantId
            );
        } catch (Exception e) {
            return null;
        }
    }
}