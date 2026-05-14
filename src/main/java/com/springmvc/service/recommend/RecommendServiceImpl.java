package com.springmvc.service.recommend;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.dto.recommend.RecommendHistory;
import com.springmvc.repository.recommend.RecommendRepository;

@Service
public class RecommendServiceImpl implements RecommendService {

	@Autowired
	private RecommendRepository recommendRepository;

	@Override
	public List<RecommendHistory> getRecommendHistoryList(Long memberId) {
		// TODO Auto-generated method stub
		return recommendRepository.getRecommendHistoryList(memberId);
	}

	@Override
	public void insertRecommendHistory(RecommendHistory history) {
		// TODO Auto-generated method stub
		recommendRepository.insertRecommendHistory(history);
	}

	@Override
	public void deleteRecommendHistory(Long recommendId, Long memberId) {
		// TODO Auto-generated method stub
		recommendRepository.deleteRecommendHistory(recommendId, memberId);
	}
}
