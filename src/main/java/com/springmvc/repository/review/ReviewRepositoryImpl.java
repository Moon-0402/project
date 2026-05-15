package com.springmvc.repository.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.dto.review.ReviewDTO;

@Repository
public class ReviewRepositoryImpl implements ReviewRepository {


	@Autowired
	private JdbcTemplate template;
	
	@Override
	public List<ReviewDTO> getReviewListByRestaurantId(Long restaurantId) {
		// TODO Auto-generated method stub
		String sql =
                "SELECT rv.review_id, rv.member_id, rv.restaurant_id, "
              + "rv.rating, rv.content, rv.image, rv.status, "
              + "rv.created_at, rv.updated_at, "
              + "m.name AS member_name, "
              + "r.name AS restaurant_name "
              + "FROM REVIEW rv "
              + "JOIN MEMBER m ON rv.member_id = m.member_id "
              + "JOIN RESTAURANT r ON rv.restaurant_id = r.restaurant_id "
              + "WHERE rv.restaurant_id = ? "
              + "AND rv.status = 'VISIBLE' "
              + "ORDER BY rv.created_at DESC";
		
		return template.query(sql, new ReviewRowMapper(), restaurantId);
	}

	@Override
	public void insertReview(ReviewDTO review) {
		// TODO Auto-generated method stub
		String sql = 
				"INSERT INTO REVIEW "
				+ "(member_id, restaurant_id, rating, content, image, status, created_at) "
				+ "VALUES (?, ?, ?, ?, ?, 'VISIBLE', NOW())";
		
		template.update(
				sql, 
				review.getMemberId(),
				review.getRestaurantId(),
				review.getRating(),
				review.getContent(),
				review.getImage()
		);
	}

	@Override
	public void updateReview(ReviewDTO review) {
		// TODO Auto-generated method stub
		String sql =
				"UPDATE REVIEW "
				+ "SET rating = ?, content = ?, image = ?, updated_at = NOW() "
				+ "WHERE review_id = ? "
				+ "AND member_id = ?";
		
		template.update(
				sql,
				review.getRating(),
				review.getContent(),
				review.getImage(),
				review.getReviewId(),
				review.getMemberId()
		);
	}
	
	// 리뷰 수정 화면/권한 확인용 단건 조회
	@Override
	public ReviewDTO getReviewById(Long reviewId) {
		// TODO Auto-generated method stub
		String sql =
                "SELECT rv.review_id, rv.member_id, rv.restaurant_id, "
              + "rv.rating, rv.content, rv.image, rv.status, "
              + "rv.created_at, rv.updated_at, "
              + "m.name AS member_name, "
              + "r.name AS restaurant_name "
              + "FROM REVIEW rv "
              + "JOIN MEMBER m ON rv.member_id = m.member_id "
              + "JOIN RESTAURANT r ON rv.restaurant_id = r.restaurant_id "
              + "WHERE rv.review_id = ?";
				
		return template.queryForObject(sql, new ReviewRowMapper(), reviewId);
	}

	// 내가 쓴 것
	@Override
	public List<ReviewDTO> getReviewListByMemberId(Long memberId) {
		// TODO Auto-generated method stub
		String sql =
                "SELECT rv.review_id, rv.member_id, rv.restaurant_id, "
              + "rv.rating, rv.content, rv.image, rv.status, "
              + "rv.created_at, rv.updated_at, "
              + "m.name AS member_name, "
              + "r.name AS restaurant_name "
              + "FROM REVIEW rv "
              + "JOIN MEMBER m ON rv.member_id = m.member_id "
              + "JOIN RESTAURANT r ON rv.restaurant_id = r.restaurant_id "
              + "WHERE rv.member_id = ? "
              + "AND rv.status = 'VISIBLE' "
              + "ORDER BY rv.created_at DESC";
		
		return template.query(sql, new ReviewRowMapper(), memberId);
	}
	
	// 같은 회원이 같은 맛집에 이미 리뷰 썼는지 확인
	@Override
	public int countReviewByMemberAndRestaurant(Long memberId, Long restaurantId) {
		// TODO Auto-generated method stub
		String sql =
                "SELECT COUNT(*) "
              + "FROM REVIEW "
              + "WHERE member_id = ? "
              + "AND restaurant_id = ? "
              + "AND status = 'VISIBLE'";
		
		return template.queryForObject(
				sql,
				Integer.class,
				memberId,
				restaurantId
		);
	}
	
}
