package com.springmvc.repository.review;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.review.ReviewDTO;

public class ReviewRowMapper implements RowMapper<ReviewDTO> {

    @Override
    public ReviewDTO mapRow(ResultSet rs, int rowNum) throws SQLException {

        ReviewDTO review = new ReviewDTO();

        review.setReviewId(rs.getLong("review_id"));
        review.setMemberId(rs.getLong("member_id"));
        review.setRestaurantId(rs.getLong("restaurant_id"));
        review.setRating(rs.getInt("rating"));
        review.setContent(rs.getString("content"));
        review.setImage(rs.getString("image"));
        review.setStatus(rs.getString("status"));

        if (rs.getTimestamp("created_at") != null) {
            review.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }

        if (rs.getTimestamp("updated_at") != null) {
            review.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        }

        try {
            review.setMemberName(rs.getString("member_name"));
        } catch (Exception e) {
        }

        try {
            review.setRestaurantName(rs.getString("restaurant_name"));
        } catch (Exception e) {
        }

        return review;
    }
}