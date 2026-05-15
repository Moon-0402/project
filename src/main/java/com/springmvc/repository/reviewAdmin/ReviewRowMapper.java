package com.springmvc.repository.reviewAdmin;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.review.ReviewDTO;

public class ReviewRowMapper implements RowMapper<ReviewDTO> {

	@Override
	public ReviewDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		// TODO Auto-generated method stub
	    ReviewDTO review = new ReviewDTO();
	    review.setReviewId(rs.getLong("review_id"));
	    review.setMemberId(rs.getLong("member_id"));
	    review.setRestaurantId(rs.getLong("restaurant_id"));
	    review.setRating(rs.getInt("rating"));
	    review.setContent(rs.getString("content"));
	    review.setImage(rs.getString("image"));
	    review.setStatus(rs.getString("status"));
	    Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            review.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            review.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        review.setMemberName(rs.getString("member_name"));
        review.setRestaurantName(rs.getString("restaurant_name"));
		return review;
	}
	
}
