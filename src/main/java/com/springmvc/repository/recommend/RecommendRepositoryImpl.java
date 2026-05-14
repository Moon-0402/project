package com.springmvc.repository.recommend;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.dto.recommend.RecommendHistory;

@Repository
public class RecommendRepositoryImpl implements RecommendRepository {
	
	@Autowired
	private JdbcTemplate template;
	
	@Override
	public List<RecommendHistory> getRecommendHistoryList(Long memberId) {
		String sql = "SELECT * FROM RECOMMEND_HISTORY WHERE member_id = ? ORDER BY created_at DESC";
		return template.query(sql, new RecommendHistoryRowMapper(), memberId);
	}
	
	@Override
	public void insertRecommendHistory(RecommendHistory history) {
		String sql = "INSERT INTO RECOMMEND_HISTORY "
                + "(member_id, situation, weather, price_range, spicy_level, selected_food, result_restaurant_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		template.update(sql,
			history.getMemberId(),
			history.getSituation(),
			history.getWeather(),
			history.getPriceRange(),
			history.getSpicyLevel(),
			history.getSelectedFood(),
			history.getResultRestaurantId()				
			);
	}
	
	@Override
    public void deleteRecommendHistory(Long recommendId, Long memberId) {
        String sql = "DELETE FROM RECOMMEND_HISTORY WHERE recommend_id = ? AND member_id = ?";
        template.update(sql, recommendId, memberId);
    }
}
