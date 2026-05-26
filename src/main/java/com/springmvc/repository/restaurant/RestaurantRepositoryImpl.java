package com.springmvc.repository.restaurant;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.dto.restaurant.Restaurant;
import com.springmvc.dto.restaurant.RestaurantDTO;
import com.springmvc.dto.restaurant.RestaurantMapDTO;

@Repository
public class RestaurantRepositoryImpl implements RestaurantRepository {

	@Autowired
	private JdbcTemplate template;
	
	// 전체 조회
	@Override
	public List<RestaurantDTO> getRestaurantList() {
		String sql = "SELECT r.restaurant_id, r.name, "
				// 수정: 카카오 카테고리가 있으면 카카오 카테고리, 없으면 기존 CATEGORY 카테고리 사용
				+ "COALESCE(r.kakao_category_name, c.category_name) AS category_name, "
				+ "IFNULL(AVG(rv.rating), 0) AS rating, "
				+ "MIN(ri.image_url) AS image_url, "
				+ "r.latitude, r.longitude "
				+ "FROM RESTAURANT r "
				+ "LEFT JOIN CATEGORY c ON r.category_id = c.category_id "
				+ "LEFT JOIN REVIEW rv ON r.restaurant_id = rv.restaurant_id "
				+ "LEFT JOIN RESTAURANT_IMAGE ri ON r.restaurant_id = ri.restaurant_id "
				+ "WHERE r.status = 'ACTIVE' "
				// 수정: r.kakao_category_name 추가
				+ "GROUP BY r.restaurant_id, r.name, r.kakao_category_name, c.category_name, r.latitude, r.longitude "
				+ "ORDER BY r.restaurant_id DESC";

		List<RestaurantDTO> list = template.query(sql, new RestaurantDTORowMapper());

		System.out.println("맛집 전체 조회 개수 = " + list.size());

		return list;
	}

	// 식당 조회
	@Override
	public Restaurant getRestaurantById(Long restaurantId) {
		String sql = "SELECT * FROM RESTAURANT WHERE restaurant_id = ?";

		return template.queryForObject(sql, new RestaurantRowMapper(), restaurantId);
	}
	
	// 지도에 뜨는 식당
	@Override
	public List<RestaurantMapDTO> getRestaurantMapList() {
		String sql = "SELECT r.restaurant_id, r.name, "
				// 수정
				+ "COALESCE(r.kakao_category_name, c.category_name) AS category_name, "
				+ "r.address, r.latitude, r.longitude, "
				+ "IFNULL(AVG(rv.rating), 0) AS rating "
				+ "FROM RESTAURANT r "
				+ "LEFT JOIN CATEGORY c ON r.category_id = c.category_id "
				+ "LEFT JOIN REVIEW rv ON r.restaurant_id = rv.restaurant_id "
				+ "WHERE r.status = 'ACTIVE' "
				// 수정
				+ "GROUP BY r.restaurant_id, r.name, r.kakao_category_name, c.category_name, r.address, r.latitude, r.longitude";

		return template.query(sql, new RestaurantMapDTORowMapper());
	}

	// 식당 넣기
	@Override
	public void insertRestaurant(Restaurant restaurant) {
		String sql = "INSERT IGNORE INTO RESTAURANT "
				+ "(api_place_id, category_id, kakao_category_name, name, address, latitude, longitude, phone, opening_hours, price_range, description, place_url) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		template.update(sql,
				restaurant.getApiPlaceId(),
				restaurant.getCategoryId(),
				restaurant.getKakaoCategoryName(),
				restaurant.getName(),
				restaurant.getAddress(),
				restaurant.getLatitude(),
				restaurant.getLongitude(),
				restaurant.getPhone(),
				restaurant.getOpeningHours(),
				restaurant.getPriceRange(),
				restaurant.getDescription(),
				restaurant.getPlaceUrl());
	}

	// 식당 수정
	@Override
	public void updateRestaurant(Restaurant restaurant) {
		String sql = "update RESTAURANT set name = ?, phone = ? , address = ? , price_range = ? , opening_hours = ?, description = ?, status = ? where restaurant_id = ? ";
		template.update(sql,
				restaurant.getName(), restaurant.getPhone(), restaurant.getAddress(),restaurant.getPriceRange(),restaurant.getOpeningHours(),restaurant.getDescription(), restaurant.getStatus(),restaurant.getRestaurantId());
	}

	// 식당 삭제
	@Override
	public void deleteRestaurant(Long restaurantId) {

	    String sql = "DELETE FROM RESTAURANT WHERE restaurant_id = ?";

	    template.update(sql, restaurantId);

	}
	
	// 관리자용 식당 목록
	@Override
	public List<RestaurantDTO> getAdminRestaurantList(int offset, int size) {

		String sql =
				"SELECT r.restaurant_id, r.name, "
				+ "COALESCE(r.kakao_category_name, c.category_name) AS category_name, "
				+ "IFNULL(AVG(rv.rating), 0) AS rating, "
				+ "MIN(ri.image_url) AS image_url, "
				+ "r.latitude, r.longitude "
				+ "FROM RESTAURANT r "
				+ "LEFT JOIN CATEGORY c ON r.category_id = c.category_id "
				+ "LEFT JOIN REVIEW rv ON r.restaurant_id = rv.restaurant_id "
				+ "LEFT JOIN RESTAURANT_IMAGE ri ON r.restaurant_id = ri.restaurant_id "
				+ "GROUP BY r.restaurant_id, r.name, "
				+ "r.kakao_category_name, c.category_name, "
				+ "r.latitude, r.longitude "
				+ "ORDER BY r.restaurant_id DESC "
				+ "LIMIT ? OFFSET ?";

		return template.query(
				sql,
				new RestaurantDTORowMapper(),
				size,
				offset
		);
	}

	// 식당 목록 개수
	@Override
	public int countAdminRestaurantList() {

		String sql =
				"SELECT COUNT(*) "
				+ "FROM RESTAURANT";

		return template.queryForObject(
				sql,
				Integer.class
		);
	}
	
	// 관리자용 식당 조회
	@Override
	public List<RestaurantDTO> searchAdminRestaurantList(
	        String keyword,
	        int offset,
	        int size) {

	    String sql =
	            "SELECT r.restaurant_id, r.name, "
	            + "COALESCE(r.kakao_category_name, c.category_name) AS category_name, "
	            + "IFNULL(AVG(rv.rating), 0) AS rating, "
	            + "MIN(ri.image_url) AS image_url, "
	            + "r.latitude, r.longitude "
	            + "FROM RESTAURANT r "
	            + "LEFT JOIN CATEGORY c ON r.category_id = c.category_id "
	            + "LEFT JOIN REVIEW rv ON r.restaurant_id = rv.restaurant_id "
	            + "LEFT JOIN RESTAURANT_IMAGE ri ON r.restaurant_id = ri.restaurant_id "
	            + "WHERE r.name LIKE ? "
	            + "GROUP BY r.restaurant_id, r.name, "
	            + "r.kakao_category_name, c.category_name, "
	            + "r.latitude, r.longitude "
	            + "ORDER BY r.restaurant_id DESC "
	            + "LIMIT ? OFFSET ?";

	    String keywordLike = "%" + keyword.trim() + "%";

	    return template.query(
	            sql,
	            new RestaurantDTORowMapper(),
	            keywordLike,
	            size,
	            offset
	    );
	}

	// 관리자용 식당 조회 개수
	@Override
	public int countSearchAdminRestaurantList(String keyword) {

	    String sql =
	            "SELECT COUNT(*) "
	            + "FROM RESTAURANT r "
	            + "WHERE r.name LIKE ?";

	    String keywordLike = "%" + keyword.trim() + "%";

	    return template.queryForObject(
	            sql,
	            Integer.class,
	            keywordLike
	    );
	}

	// 최근 본 식당 삽입
	@Override
	public void insertRecentlyRestaurant(Long memberId, Long restaurantId) {

		// 수정: 1개월 지난 최근 본 맛집 기록 삭제
		// viewed_at이 현재 날짜 기준 1개월보다 오래된 데이터는 삭제됨
		String deleteOldSql = "DELETE FROM RECENTLY_RESTAURANT "
				+ "WHERE viewed_at < DATE_SUB(NOW(), INTERVAL 1 MONTH)";

		template.update(deleteOldSql);

		// 수정: 같은 회원이 같은 맛집을 다시 보면 중복 저장되지 않도록 기존 기록 삭제
		String deleteDuplicateSql = "DELETE FROM RECENTLY_RESTAURANT "
				+ "WHERE member_id = ? AND restaurant_id = ?";

		template.update(deleteDuplicateSql, memberId, restaurantId);

		// 수정: 최근 본 맛집을 현재 시간으로 다시 저장
		String insertSql = "INSERT INTO RECENTLY_RESTAURANT "
				+ "(member_id, restaurant_id, viewed_at) "
				+ "VALUES (?, ?, NOW())";

		template.update(insertSql, memberId, restaurantId);
	}

	// 최근 본 식당 불러오기
	@Override
	public List<RestaurantDTO> getRecentlyRestaurantList(Long memberId) {
		String sql = "SELECT r.restaurant_id, r.name, "
				// 수정
				+ "COALESCE(r.kakao_category_name, c.category_name) AS category_name, "
				+ "IFNULL(AVG(rv.rating), 0) AS rating, "
				+ "MIN(ri.image_url) AS image_url, "
				+ "r.latitude, r.longitude "
				+ "FROM RECENTLY_RESTAURANT rr "
				+ "JOIN RESTAURANT r ON rr.restaurant_id = r.restaurant_id "
				+ "LEFT JOIN CATEGORY c ON r.category_id = c.category_id "
				+ "LEFT JOIN REVIEW rv ON r.restaurant_id = rv.restaurant_id "
				+ "LEFT JOIN RESTAURANT_IMAGE ri ON r.restaurant_id = ri.restaurant_id "
				+ "WHERE rr.member_id = ? AND r.status = 'ACTIVE' "
				// 수정: 최근 1개월 안에 본 맛집만 조회
				+ "AND rr.viewed_at >= DATE_SUB(NOW(), INTERVAL 1 MONTH) "
				// 수정
				+ "GROUP BY r.restaurant_id, r.name, r.kakao_category_name, c.category_name, r.latitude, r.longitude, rr.viewed_at "
				+ "ORDER BY rr.viewed_at DESC";

		return template.query(sql, new RestaurantDTORowMapper(), memberId);
	}
	
	// 페이징 넣기
	@Override
	public List<RestaurantDTO> getRecentlyRestaurantList(Long memberId, int offset, int size) {

		String sql = "SELECT r.restaurant_id, r.name, "
				+ "COALESCE(r.kakao_category_name, c.category_name) AS category_name, "
				+ "IFNULL(ROUND(AVG(rv.rating), 1), 0) AS rating, "
				+ "MIN(ri.image_url) AS image_url, "
				+ "r.latitude, r.longitude "
				+ "FROM RECENTLY_RESTAURANT rr "
				+ "JOIN RESTAURANT r ON rr.restaurant_id = r.restaurant_id "
				+ "LEFT JOIN CATEGORY c ON r.category_id = c.category_id "
				+ "LEFT JOIN REVIEW rv ON r.restaurant_id = rv.restaurant_id "
				+ "LEFT JOIN RESTAURANT_IMAGE ri ON r.restaurant_id = ri.restaurant_id "
				+ "WHERE rr.member_id = ? "
				+ "AND r.status = 'ACTIVE' "
				+ "AND rr.viewed_at >= DATE_SUB(NOW(), INTERVAL 1 MONTH) "
				+ "GROUP BY r.restaurant_id, r.name, r.kakao_category_name, "
				+ "c.category_name, r.latitude, r.longitude, rr.viewed_at "
				+ "ORDER BY rr.viewed_at DESC "
				+ "LIMIT ? OFFSET ?";

		return template.query(
				sql,
				new RestaurantDTORowMapper(),
				memberId,
				size,
				offset
		);
	}
	
	// 개수
	@Override
	public int countRecentlyRestaurantList(Long memberId) {

		String sql = "SELECT COUNT(*) "
				+ "FROM RECENTLY_RESTAURANT rr "
				+ "JOIN RESTAURANT r ON rr.restaurant_id = r.restaurant_id "
				+ "WHERE rr.member_id = ? "
				+ "AND r.status = 'ACTIVE' "
				+ "AND rr.viewed_at >= DATE_SUB(NOW(), INTERVAL 1 MONTH)";

		return template.queryForObject(
				sql,
				Integer.class,
				memberId
		);
	}

	@Override
	public List<RestaurantDTO> searchRestaurantList(String regionKeyword, String foodKeyword, int offset, int size) {

		StringBuilder sql = new StringBuilder();
		List<Object> params = new ArrayList<>();

		sql.append("SELECT r.restaurant_id, r.name, ");
		// 수정
		sql.append("COALESCE(r.kakao_category_name, c.category_name) AS category_name, ");
		sql.append("IFNULL(AVG(rv.rating), 0) AS rating, ");
		sql.append("MIN(ri.image_url) AS image_url, ");
		sql.append("r.latitude, r.longitude ");

		sql.append("FROM RESTAURANT r ");
		sql.append("LEFT JOIN CATEGORY c ON r.category_id = c.category_id ");
		sql.append("LEFT JOIN REVIEW rv ON r.restaurant_id = rv.restaurant_id ");
		sql.append("LEFT JOIN RESTAURANT_IMAGE ri ON r.restaurant_id = ri.restaurant_id ");
		sql.append("WHERE r.status = 'ACTIVE' ");

		if (regionKeyword != null && !regionKeyword.trim().isEmpty()) {
			String regionLike = "%" + regionKeyword.trim() + "%";

			sql.append("AND ( ");
			sql.append("r.name LIKE ? ");
			sql.append("OR r.address LIKE ? ");
			sql.append(") ");

			params.add(regionLike);
			params.add(regionLike);
		}

		if (foodKeyword != null && !foodKeyword.trim().isEmpty()) {
			String foodLike = "%" + foodKeyword.trim() + "%";

			sql.append("AND ( ");
			sql.append("r.name LIKE ? ");
			sql.append("OR c.category_name LIKE ? ");
			// 수정: 카카오 원본 카테고리도 검색
			sql.append("OR r.kakao_category_name LIKE ? ");
			sql.append("OR r.description LIKE ? ");
			sql.append(") ");

			params.add(foodLike);
			params.add(foodLike);
			// 수정: r.kakao_category_name LIKE ? 파라미터 추가
			params.add(foodLike);
			params.add(foodLike);
		}

		// 수정
		sql.append("GROUP BY r.restaurant_id, r.name, r.kakao_category_name, c.category_name, r.latitude, r.longitude ");
		sql.append("ORDER BY r.restaurant_id DESC ");
		sql.append("LIMIT ? OFFSET ?");

		params.add(size);
		params.add(offset);

		return template.query(sql.toString(), new RestaurantDTORowMapper(), params.toArray());
	}

	@Override
	public List<RestaurantMapDTO> getSearchRestaurantMapList(String regionKeyword, String foodKeyword) {

		StringBuilder sql = new StringBuilder();
		List<Object> params = new ArrayList<>();

		sql.append("SELECT r.restaurant_id, r.name, ");
		// 수정
		sql.append("COALESCE(r.kakao_category_name, c.category_name) AS category_name, ");
		sql.append("r.address, ");
		sql.append("0 AS rating, ");
		sql.append("r.latitude, r.longitude ");
		sql.append("FROM RESTAURANT r ");
		sql.append("LEFT JOIN CATEGORY c ON r.category_id = c.category_id ");
		sql.append("WHERE r.status = 'ACTIVE' ");
		sql.append("AND r.latitude IS NOT NULL ");
		sql.append("AND r.longitude IS NOT NULL ");

		if (regionKeyword != null && !regionKeyword.trim().isEmpty()) {
			String regionLike = "%" + regionKeyword.trim() + "%";

			sql.append("AND ( ");
			sql.append("r.name LIKE ? ");
			sql.append("OR r.address LIKE ? ");
			sql.append(") ");

			params.add(regionLike);
			params.add(regionLike);
		}

		if (foodKeyword != null && !foodKeyword.trim().isEmpty()) {
			String foodLike = "%" + foodKeyword.trim() + "%";

			sql.append("AND ( ");
			sql.append("r.name LIKE ? ");
			sql.append("OR c.category_name LIKE ? ");
			// 수정
			sql.append("OR r.kakao_category_name LIKE ? ");
			sql.append("OR r.description LIKE ? ");
			sql.append(") ");

			params.add(foodLike);
			params.add(foodLike);
			// 수정
			params.add(foodLike);
			params.add(foodLike);
		}

		sql.append("ORDER BY r.restaurant_id DESC ");

		return template.query(sql.toString(), new RestaurantMapDTORowMapper(), params.toArray());
	}

	@Override
	public int countSearchRestaurantList(String regionKeyword, String foodKeyword) {

		StringBuilder sql = new StringBuilder();
		List<Object> params = new ArrayList<>();

		sql.append("SELECT COUNT(*) ");
		sql.append("FROM RESTAURANT r ");
		sql.append("LEFT JOIN CATEGORY c ON r.category_id = c.category_id ");
		sql.append("WHERE r.status = 'ACTIVE' ");

		if (regionKeyword != null && !regionKeyword.trim().isEmpty()) {
			String regionLike = "%" + regionKeyword.trim() + "%";

			sql.append("AND ( ");
			sql.append("r.name LIKE ? ");
			sql.append("OR r.address LIKE ? ");
			sql.append(") ");

			params.add(regionLike);
			params.add(regionLike);
		}

		if (foodKeyword != null && !foodKeyword.trim().isEmpty()) {
			String foodLike = "%" + foodKeyword.trim() + "%";

			sql.append("AND ( ");
			sql.append("r.name LIKE ? ");
			sql.append("OR c.category_name LIKE ? ");
			// 수정
			sql.append("OR r.kakao_category_name LIKE ? ");
			sql.append("OR r.description LIKE ? ");
			sql.append(") ");

			params.add(foodLike);
			params.add(foodLike);
			// 수정
			params.add(foodLike);
			params.add(foodLike);
		}

		return template.queryForObject(sql.toString(), Integer.class, params.toArray());
	}

	@Override
	public List<RestaurantDTO> getRestaurantList(int offset, int size) {

		String sql = "SELECT r.restaurant_id, r.name, "
				// 수정
				+ "COALESCE(r.kakao_category_name, c.category_name) AS category_name, "
				+ "IFNULL(AVG(rv.rating), 0) AS rating, "
				+ "MIN(ri.image_url) AS image_url, "
				+ "r.latitude, r.longitude "
				+ "FROM RESTAURANT r "
				+ "LEFT JOIN CATEGORY c ON r.category_id = c.category_id "
				+ "LEFT JOIN REVIEW rv ON r.restaurant_id = rv.restaurant_id "
				+ "LEFT JOIN RESTAURANT_IMAGE ri ON r.restaurant_id = ri.restaurant_id "
				+ "WHERE r.status = 'ACTIVE' "
				// 수정
				+ "GROUP BY r.restaurant_id, r.name, r.kakao_category_name, c.category_name, r.latitude, r.longitude "
				+ "ORDER BY r.restaurant_id DESC "
				+ "LIMIT ? OFFSET ?";

		return template.query(sql, new RestaurantDTORowMapper(), size, offset);
	}

	@Override
	public int countRestaurantList() {
		String sql = "SELECT COUNT(*) FROM RESTAURANT WHERE status = 'ACTIVE'";

		return template.queryForObject(sql, Integer.class);
	}

	@Override
	public List<RestaurantDTO> getNearRestaurants(String keyword, Double lat, Double lng, int limit) {

	    StringBuilder sql = new StringBuilder();

	    sql.append("SELECT ");
	    sql.append("r.restaurant_id, ");
	    sql.append("r.name, ");
	    sql.append("COALESCE(r.kakao_category_name, c.category_name) AS category_name, ");
	    sql.append("IFNULL(AVG(rv.rating), 0) AS rating, ");
	    sql.append("MIN(ri.image_url) AS image_url, ");
	    sql.append("r.latitude, ");
	    sql.append("r.longitude, ");

	    // 실제 거리 계산, 단위 km
	    sql.append("ROUND((");
	    sql.append("6371 * ACOS(");
	    sql.append("COS(RADIANS(?)) ");
	    sql.append("* COS(RADIANS(r.latitude)) ");
	    sql.append("* COS(RADIANS(r.longitude) - RADIANS(?)) ");
	    sql.append("+ SIN(RADIANS(?)) ");
	    sql.append("* SIN(RADIANS(r.latitude))");
	    sql.append(")");
	    sql.append("), 3) AS distance ");

	    sql.append("FROM RESTAURANT r ");
	    sql.append("LEFT JOIN CATEGORY c ON r.category_id = c.category_id ");
	    sql.append("LEFT JOIN REVIEW rv ON r.restaurant_id = rv.restaurant_id ");
	    sql.append("LEFT JOIN RESTAURANT_IMAGE ri ON r.restaurant_id = ri.restaurant_id ");

	    sql.append("WHERE r.status = 'ACTIVE' ");
	    sql.append("AND r.latitude IS NOT NULL ");
	    sql.append("AND r.longitude IS NOT NULL ");

	    sql.append("AND ( ");
	    sql.append("r.name LIKE ? ");
	    sql.append("OR r.address LIKE ? ");
	    sql.append("OR c.category_name LIKE ? ");
	    sql.append("OR r.kakao_category_name LIKE ? ");
	    sql.append("OR r.description LIKE ? ");
	    sql.append(") ");

	    sql.append("GROUP BY ");
	    sql.append("r.restaurant_id, ");
	    sql.append("r.name, ");
	    sql.append("r.kakao_category_name, ");
	    sql.append("c.category_name, ");
	    sql.append("r.latitude, ");
	    sql.append("r.longitude ");

	    sql.append("HAVING distance <= 3 ");
	    sql.append("ORDER BY RAND() ");
	    sql.append("LIMIT ? ");

	    String keywordLike = "%" + keyword + "%";

	    return template.query(
	            sql.toString(),
	            new RestaurantDTORowMapper(),
	            lat,
	            lng,
	            lat,
	            keywordLike,
	            keywordLike,
	            keywordLike,
	            keywordLike,
	            keywordLike,
	            limit
	    );
	}
}