package com.springmvc.repository.aipick;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.dto.aipick.AiPickDTO;

@Repository
public class AiPickRepositoryImpl implements AiPickRepository {

	@Autowired
	private JdbcTemplate template;

    /**
     * AI PICK 후보 맛집 조회
     *
     * 현재 위치(lat, lng)를 기준으로
     * 가까운 맛집 후보를 가져온다.
     *
     * 실제 개인화 점수 계산은 Service에서 수행한다.
     */
    @Override
    public List<AiPickDTO> getAiPickList(Long memberId, Double lat, Double lng) {

        String sql =
                "SELECT "
                // 맛집 기본 정보
                + "r.restaurant_id, "
                + "r.name, "

                // 카테고리명
                + "c.category_name AS category_name, "
                + "r.kakao_category_name AS kakao_category_name, "
                + "r.address, "

                // 이미지 컬럼이 없으면 임시 NULL 처리
                + "NULL AS image_url, "

                // 리뷰 평균 평점
                + "IFNULL(ROUND(AVG(rv.rating), 1), 0) AS rating, "

                // 현재 위치 기준 거리(km)
                + "ROUND((6371 * ACOS( "
                + "COS(RADIANS(?)) "
                + "* COS(RADIANS(r.latitude)) "
                + "* COS(RADIANS(r.longitude) - RADIANS(?)) "
                + "+ SIN(RADIANS(?)) "
                + "* SIN(RADIANS(r.latitude)) "
                + ")), 3) AS distance "

                + "FROM RESTAURANT r "

                // 카테고리 정보 조인
                + "LEFT JOIN CATEGORY c "
                + "ON r.category_id = c.category_id "

                // 평균 평점 계산용 리뷰 조인
                + "LEFT JOIN REVIEW rv "
                + "ON r.restaurant_id = rv.restaurant_id "

                // 활성화된 맛집만 조회
                + "WHERE r.status = 'ACTIVE' "

                // 위치 정보 없는 맛집 제외
                + "AND r.latitude IS NOT NULL "
                + "AND r.longitude IS NOT NULL "

                // 집계 함수 사용으로 GROUP BY 필요
                + "GROUP BY "
                + "r.restaurant_id, "
                + "r.name, "
                + "c.category_name, "
                + "r.address, "
                + "r.latitude, "
                + "r.longitude ";

        return template.query(
                sql,
                new AiPickRowMapper(),

                // 거리 계산에 사용할 현재 위치
                lat,
                lng,
                lat
        );
    }
    
    @Override
    public Map<String, Integer> getPreferenceCategoryMap(Long memberId) {

        String sql =
                "SELECT favorite_category AS category_name, COUNT(*) AS cnt "
              + "FROM PREFERENCE "
              + "WHERE member_id = ? "
              + "AND favorite_category IS NOT NULL "
              + "GROUP BY favorite_category";

        return template.query(sql, rs -> {
            Map<String, Integer> map = new java.util.HashMap<>();

            while (rs.next()) {
                map.put(
                    rs.getString("category_name"),
                    rs.getInt("cnt")
                );
            }

            return map;
        }, memberId);
    }

    @Override
    public Map<String, Integer> getBookmarkCategoryMap(Long memberId) {

        String sql =
                "SELECT c.category_name, COUNT(*) AS cnt "
              + "FROM BOOKMARK b "
              + "JOIN RESTAURANT r ON b.restaurant_id = r.restaurant_id "
              + "JOIN CATEGORY c ON r.category_id = c.category_id "
              + "WHERE b.member_id = ? "
              + "GROUP BY c.category_name";

        return template.query(sql, rs -> {
            Map<String, Integer> map = new java.util.HashMap<>();

            while (rs.next()) {
                map.put(
                    rs.getString("category_name"),
                    rs.getInt("cnt")
                );
            }

            return map;
        }, memberId);
    }

    @Override
    public Map<String, Integer> getReviewCategoryMap(Long memberId) {

        String sql =
                "SELECT c.category_name, COUNT(*) AS cnt "
              + "FROM REVIEW rv "
              + "JOIN RESTAURANT r ON rv.restaurant_id = r.restaurant_id "
              + "JOIN CATEGORY c ON r.category_id = c.category_id "
              + "WHERE rv.member_id = ? "
              + "AND rv.status = 'VISIBLE' "
              + "GROUP BY c.category_name";

        return template.query(sql, rs -> {
            Map<String, Integer> map = new java.util.HashMap<>();

            while (rs.next()) {
                map.put(
                    rs.getString("category_name"),
                    rs.getInt("cnt")
                );
            }

            return map;
        }, memberId);
    }

    @Override
    public Map<String, Integer> getRecentViewCategoryMap(Long memberId) {

        String sql =
                "SELECT c.category_name, COUNT(*) AS cnt "
              + "FROM RECENTLY_RESTAURANT rr "
              + "JOIN RESTAURANT r ON rr.restaurant_id = r.restaurant_id "
              + "JOIN CATEGORY c ON r.category_id = c.category_id "
              + "WHERE rr.member_id = ? "
              + "GROUP BY c.category_name";

        return template.query(sql, rs -> {
            Map<String, Integer> map = new java.util.HashMap<>();

            while (rs.next()) {
                map.put(
                    rs.getString("category_name"),
                    rs.getInt("cnt")
                );
            }

            return map;
        }, memberId);
    }
    
    // 탐색 추천 후보 맛집 조회
    @Override
    public List<AiPickDTO> getExplorationCandidateList(
            Long memberId,
            Double lat,
            Double lng) {

        String sql =
                "SELECT "
              + "r.restaurant_id, "
              + "r.name, "
              + "c.category_name AS category_name, "
              + "r.kakao_category_name AS kakao_category_name, "
              + "r.address, "
              + "NULL AS image_url, "
              + "IFNULL(ROUND(AVG(rv.rating), 1), 0) AS rating, "
              + "ROUND((6371 * ACOS( "
              + "COS(RADIANS(?)) "
              + "* COS(RADIANS(r.latitude)) "
              + "* COS(RADIANS(r.longitude) - RADIANS(?)) "
              + "+ SIN(RADIANS(?)) "
              + "* SIN(RADIANS(r.latitude)) "
              + ")), 3) AS distance "
              + "FROM RESTAURANT r "
              + "LEFT JOIN CATEGORY c ON r.category_id = c.category_id "
              + "LEFT JOIN REVIEW rv ON r.restaurant_id = rv.restaurant_id "
              + "WHERE r.status = 'ACTIVE' "
              + "AND r.latitude IS NOT NULL "
              + "AND r.longitude IS NOT NULL "

              // 제외 시켜야할 것들(즐겨찾기한 맛집, 리뷰 쓴 맛집)
              + "AND r.restaurant_id NOT IN ( "
              + "    SELECT restaurant_id FROM BOOKMARK WHERE member_id = ? "
              + "    UNION "
              + "    SELECT restaurant_id FROM REVIEW WHERE member_id = ? "
              + ") "
              + "GROUP BY r.restaurant_id, r.name, c.category_name, r.kakao_category_name, "
              + "r.address, r.latitude, r.longitude "
              + "HAVING distance <= 10 "
              + "AND rating >= 3.5";

        return template.query(
                sql,
                new AiPickRowMapper(),
                lat, lng, lat,
                memberId, memberId
        );
    }
    
    // 선호 카테고리와 다른 카테고리들의 유사도 조회
    @Override
    public Map<String, Double> getCategorySimilarityMap(String favoriteCategory) {

        String sql =
                "SELECT target.category_name, cs.similarity "
              + "FROM CATEGORY_SIMILARITY cs "
              + "JOIN CATEGORY base ON cs.base_category_id = base.category_id "
              + "JOIN CATEGORY target ON cs.target_category_id = target.category_id "
              + "WHERE base.category_name = ?";

        return template.query(sql, rs -> {
            Map<String, Double> map = new java.util.HashMap<>();

            while (rs.next()) {
                map.put(
                        rs.getString("category_name"),
                        rs.getDouble("similarity")
                );
            }

            return map;
        }, favoriteCategory);
    }

    @Override
    public Map<String, Integer> getLikeFeedbackCategoryMap(Long memberId) {

        String sql =
                "SELECT c.category_name, COUNT(*) AS cnt "
              + "FROM AIPICK_FEEDBACK af "
              + "JOIN RESTAURANT r ON af.restaurant_id = r.restaurant_id "
              + "JOIN CATEGORY c ON r.category_id = c.category_id "
              + "WHERE af.member_id = ? "
              + "AND af.feedback_type = 'LIKE' "
              + "GROUP BY c.category_name";

        return template.query(sql, rs -> {
            Map<String, Integer> map = new java.util.HashMap<>();

            while (rs.next()) {
                map.put(
                    rs.getString("category_name"),
                    rs.getInt("cnt")
                );
            }

            return map;
        }, memberId);
    }

    @Override
    public Map<String, Integer> getDislikeFeedbackCategoryMap(Long memberId) {

        String sql =
                "SELECT c.category_name, COUNT(*) AS cnt "
              + "FROM AIPICK_FEEDBACK af "
              + "JOIN RESTAURANT r ON af.restaurant_id = r.restaurant_id "
              + "JOIN CATEGORY c ON r.category_id = c.category_id "
              + "WHERE af.member_id = ? "
              + "AND af.feedback_type = 'DISLIKE' "
              + "GROUP BY c.category_name";

        return template.query(sql, rs -> {
            Map<String, Integer> map = new java.util.HashMap<>();

            while (rs.next()) {
                map.put(
                    rs.getString("category_name"),
                    rs.getInt("cnt")
                );
            }

            return map;
        }, memberId);
    }
    
}
