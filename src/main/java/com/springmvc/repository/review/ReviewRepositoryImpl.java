package com.springmvc.repository.review;

import java.util.ArrayList;
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
              + "AND rv.status = 'ACTIVE' "
              + "ORDER BY rv.created_at DESC";
		
		return template.query(sql, new ReviewRowMapper(), restaurantId);
	}
	
	@Override
	public List<ReviewDTO> getReviewListByRestaurantId(Long restaurantId, int offset, int size) {

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
	          + "AND rv.status = 'ACTIVE' "
	          + "ORDER BY rv.created_at DESC "
	          + "LIMIT ?, ?";

	    return template.query(
	            sql,
	            new ReviewRowMapper(),
	            restaurantId,
	            offset,
	            size
	    );
	}

	@Override
	public int countReviewByRestaurantId(Long restaurantId) {

	    String sql =
	            "SELECT COUNT(*) "
	          + "FROM REVIEW "
	          + "WHERE restaurant_id = ? "
	          + "AND status = 'ACTIVE'";

	    return template.queryForObject(
	            sql,
	            Integer.class,
	            restaurantId
	    );
	}

	@Override
	public void insertReview(ReviewDTO review) {
		// TODO Auto-generated method stub
		String sql = 
				"INSERT INTO REVIEW "
				+ "(member_id, restaurant_id, rating, content, image, status, created_at) "
				+ "VALUES (?, ?, ?, ?, ?, 'ACTIVE', NOW())";
		
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
              + "AND rv.status = 'ACTIVE' "
              + "ORDER BY rv.created_at DESC";
		
		return template.query(sql, new ReviewRowMapper(), memberId);
	}
	
	@Override
	public List<ReviewDTO> getReviewListByMemberId(Long memberId, int offset, int size) {

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
	          + "AND rv.status = 'ACTIVE' "
	          + "ORDER BY rv.created_at DESC "
	          + "LIMIT ?, ?";

	    return template.query(
	            sql,
	            new ReviewRowMapper(),
	            memberId,
	            offset,
	            size
	    );
	}

	@Override
	public int countReviewByMemberId(Long memberId) {
		// TODO Auto-generated method stub
		
		String sql =
	            "SELECT COUNT(*) "
	          + "FROM REVIEW "
	          + "WHERE member_id = ? "
	          + "AND status = 'ACTIVE'";
		
		return template.queryForObject(
	            sql,
	            Integer.class,
	            memberId
	    );
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
              + "AND status = 'ACTIVE'";
		
		return template.queryForObject(
				sql,
				Integer.class,
				memberId,
				restaurantId
		);
	}

	// 최신 리뷰 조회 기능
	@Override
	public List<ReviewDTO> getLatestReviewList(int limit) {
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
	          + "WHERE rv.status = 'ACTIVE' "
	          + "ORDER BY rv.created_at DESC "
	          + "LIMIT ?";
		
		return template.query(
				sql,
				new ReviewRowMapper(),
				limit
		);
	}

	@Override
	public List<ReviewDTO> getReviewList(int offset, int size) {
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
	          + "WHERE rv.status = 'ACTIVE' "
	          + "ORDER BY rv.created_at DESC "
	          + "LIMIT ?, ?";
		
		return template.query(
	            sql,
	            new ReviewRowMapper(),
	            offset,
	            size
	    );
	}

	@Override
	public int countReview() {
		// TODO Auto-generated method stub
		
		String sql =
	            "SELECT COUNT(*) "
	          + "FROM REVIEW "
	          + "WHERE status = 'ACTIVE'";
			    
		return template.queryForObject(sql, Integer.class);
	}

	@Override
	public List<ReviewDTO> searchReviewList(String regionKeyword, String foodKeyword, int offset, int size) {
		// TODO Auto-generated method stub
		 StringBuilder sql = new StringBuilder();

		    List<Object> params = new ArrayList<>();

		    sql.append("SELECT rv.review_id, rv.member_id, rv.restaurant_id, ");
		    sql.append("rv.rating, rv.content, rv.image, rv.status, ");
		    sql.append("rv.created_at, rv.updated_at, ");
		    sql.append("m.name AS member_name, ");
		    sql.append("r.name AS restaurant_name ");
		    sql.append("FROM REVIEW rv ");
		    sql.append("JOIN MEMBER m ON rv.member_id = m.member_id ");
		    sql.append("JOIN RESTAURANT r ON rv.restaurant_id = r.restaurant_id ");
		    sql.append("LEFT JOIN CATEGORY c ON r.category_id = c.category_id ");
		    sql.append("WHERE rv.status = 'ACTIVE' ");

		    // 지역 검색
		    if (regionKeyword != null
		            && !regionKeyword.trim().isEmpty()) {

		        String regionLike =
		                "%" + regionKeyword.trim() + "%";

		        sql.append("AND ( ");
		        sql.append("r.name LIKE ? ");
		        sql.append("OR r.address LIKE ? ");
		        sql.append(") ");

		        params.add(regionLike);
		        params.add(regionLike);
		    }

		    // 음식/리뷰 검색
		    if (foodKeyword != null
		            && !foodKeyword.trim().isEmpty()) {

		        String foodLike =
		                "%" + foodKeyword.trim() + "%";

		        sql.append("AND ( ");
		        sql.append("r.name LIKE ? ");
		        sql.append("OR c.category_name LIKE ? ");
		        sql.append("OR r.kakao_category_name LIKE ? ");
		        sql.append("OR rv.content LIKE ? ");
		        sql.append("OR r.description LIKE ? ");
		        sql.append(") ");

		        params.add(foodLike);
		        params.add(foodLike);
		        params.add(foodLike);
		        params.add(foodLike);
		        params.add(foodLike);
		    }

		    sql.append("ORDER BY rv.created_at DESC ");
		    sql.append("LIMIT ?, ? ");

		    params.add(offset);
		    params.add(size);

		    return template.query(
		            sql.toString(),
		            new ReviewRowMapper(),
		            params.toArray()
		    );
	}

	@Override
	public int countSearchReviewList(
	        String regionKeyword,
	        String foodKeyword) {

	    StringBuilder sql = new StringBuilder();
	    List<Object> params = new ArrayList<>();

	    sql.append("SELECT COUNT(*) ");
	    sql.append("FROM REVIEW rv ");
	    sql.append("JOIN RESTAURANT r ");
	    sql.append("ON rv.restaurant_id = r.restaurant_id ");
	    sql.append("LEFT JOIN CATEGORY c ");
	    sql.append("ON r.category_id = c.category_id ");
	    sql.append("WHERE rv.status = 'ACTIVE' ");

	    // 지역 검색
	    if (regionKeyword != null
	            && !regionKeyword.trim().isEmpty()) {

	        String regionLike =
	                "%" + regionKeyword.trim() + "%";

	        sql.append("AND ( ");
	        sql.append("r.name LIKE ? ");
	        sql.append("OR r.address LIKE ? ");
	        sql.append(") ");

	        params.add(regionLike);
	        params.add(regionLike);
	    }

	    // 음식/리뷰 검색
	    if (foodKeyword != null
	            && !foodKeyword.trim().isEmpty()) {

	        String foodLike =
	                "%" + foodKeyword.trim() + "%";

	        sql.append("AND ( ");
	        sql.append("r.name LIKE ? ");
	        sql.append("OR c.category_name LIKE ? ");
	        sql.append("OR r.kakao_category_name LIKE ? ");
	        sql.append("OR rv.content LIKE ? ");
	        sql.append("OR r.description LIKE ? ");
	        sql.append(") ");

	        params.add(foodLike);
	        params.add(foodLike);
	        params.add(foodLike);
	        params.add(foodLike);
	        params.add(foodLike);
	    }

	    return template.queryForObject(
	            sql.toString(),
	            Integer.class,
	            params.toArray()
	    );
	}
	
}
