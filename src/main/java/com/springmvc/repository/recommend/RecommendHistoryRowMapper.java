package com.springmvc.repository.recommend;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.recommend.RecommendHistory;

public class RecommendHistoryRowMapper implements RowMapper<RecommendHistory> {

    @Override
    public RecommendHistory mapRow(ResultSet rs, int rowNum) throws SQLException {

        RecommendHistory history = new RecommendHistory();

        // PK
        history.setRecommendId(rs.getLong("recommend_id"));

        // FK
        history.setMemberId(rs.getLong("member_id"));

        // 조건들
        history.setSituation(rs.getString("situation"));
        history.setWeather(rs.getString("weather"));
        history.setPriceRange(rs.getString("price_range"));
        history.setSpicyLevel(rs.getString("spicy_level"));

        // 결과
        history.setSelectedFood(rs.getString("selected_food"));

        // nullable 컬럼 (주의!)
        Long restaurantId = rs.getObject("result_restaurant_id", Long.class);
        history.setResultRestaurantId(restaurantId);

        // 날짜
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            history.setCreatedAt(createdAt.toLocalDateTime());
        }

        return history;
    }
}