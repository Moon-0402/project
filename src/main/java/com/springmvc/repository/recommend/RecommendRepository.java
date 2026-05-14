package com.springmvc.repository.recommend;

import java.util.List;

import com.springmvc.dto.recommend.RecommendHistory;

public interface RecommendRepository {

    // 추천 기록 조회
    List<RecommendHistory> getRecommendHistoryList(Long memberId);

    // 추천 기록 저장
    void insertRecommendHistory(RecommendHistory history);

    // 추천 기록 삭제
    void deleteRecommendHistory(Long recommendId, Long memberId);
}
