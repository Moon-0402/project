package com.springmvc.repository.reviewAdmin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.dto.review.ReviewDTO;

@Repository
public class ReviewAdminRepositoryImpl implements ReviewAdminRepository{
	
	@Autowired
	private JdbcTemplate template;
	
	@Override
	public List<ReviewDTO> reviewManagement(int offset, int size) {
		// TODO Auto-generated method stub
		String sql = "select rv.review_id, rv.member_id, rv.restaurant_id, rv.rating, rv.content, rv.image, "
				+ "rv.status, rv.created_at, rv.updated_at, m.name , r.name from REVIEW rv "
				+ "join MEMBER m on rv.member_id = m.member_id "
				+ "join RESTAURANT r on rv.restaurant_id = r.restaurant_id "
				+ "order by rv.review_id desc "
				+ "LIMIT ? OFFSET ?";
		return template.query(sql, new ReviewRowMapper(),size,offset);
	}

	@Override
	public void updateReviewStatus(Long reviewId, String status) {
		// TODO Auto-generated method stub
		String sql = "update REVIEW set status = ?, updated_at = NOW() where review_id = ?";
		template.update(sql,status,reviewId);
	}

	@Override
	public List<ReviewDTO> findReviewByRestaurantName(String restaurantName,int offset, int size) {
		// TODO Auto-generated method stub
		String sql = "select rv.review_id, rv.member_id, rv.restaurant_id, rv.rating, rv.content, rv.image, "
				+ "rv.status, rv.created_at, rv.updated_at, m.name, r.name from REVIEW rv "
				+ "join MEMBER m on rv.member_id = m.member_id "
				+"join RESTAURANT r on rv.restaurant_id = r.restaurant_id "
				+ "where r.name like ? "
				+ "LIMIT ? OFFSET ?";
		String keyword = "%" + restaurantName + "%";
		return template.query(sql, new ReviewRowMapper(),keyword,size,offset);
	}

	@Override
	public int countReviewManagement() {
		// TODO Auto-generated method stub
		String sql = "select count(*) from REVIEW";
		Integer count = template.queryForObject(sql, Integer.class);
		return count != null ? count : 0;
	}


	@Override
	public int countReviewByRestaurantName(String restaurantName) {
		// TODO Auto-generated method stub
		String sql = "select count(*) from review rv join RESTAURANT r on rv.restaurant_id = r.restaurant_id "
				+ "where r.name like ?";
		String keyword = "%" + restaurantName +"%";
		Integer count = template.queryForObject(sql, Integer.class,keyword);
		return count != null ? count :0;
	}

	@Override
	public ReviewDTO findReviewDetailById(Long reviewId) {
		// TODO Auto-generated method stub
		String sql = "SELECT "
				+ "rv.review_id, "
				+ "rv.member_id, "
				+ "rv.restaurant_id, "
				+ "rv.rating, "
				+ "rv.content, "
				+ "rv.image, "
				+ "rv.status, "
				+ "rv.created_at, "
				+ "rv.updated_at, "
				+ "m.name , "
				+ "r.name "
				+ "FROM REVIEW rv "
				+ "JOIN MEMBER m ON rv.member_id = m.member_id "
				+ "JOIN RESTAURANT r ON rv.restaurant_id = r.restaurant_id "
				+ "WHERE rv.review_id = ?";

		return template.queryForObject(sql, new ReviewRowMapper(), reviewId);
	}
	
}
