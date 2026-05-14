package com.springmvc.service.recommend;

import java.util.List;

import com.springmvc.dto.recommend.RecommendHistory;

public interface RecommendService {
	
	List<RecommendHistory> getRecommendHistoryList(Long memberId);
	
	void insertRecommendHistory(RecommendHistory history);
	
	void deleteRecommendHistory(Long recommendId, Long memberId);
}
