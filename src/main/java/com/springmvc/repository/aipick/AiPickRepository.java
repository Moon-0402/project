package com.springmvc.repository.aipick;

import java.util.List;
import java.util.Map;

import com.springmvc.dto.aipick.AiPickDTO;

public interface AiPickRepository {

    // AI PICK 후보 맛집 조회
    List<AiPickDTO> getAiPickList(Long memberId, Double lat, Double lng);

    // 사용자가 직접 설정한 선호 카테고리
    Map<String, Integer> getPreferenceCategoryMap(Long memberId);

    // 즐겨찾기 기반 카테고리 선호도
    Map<String, Integer> getBookmarkCategoryMap(Long memberId);

    // 리뷰 작성 기반 카테고리 선호도
    Map<String, Integer> getReviewCategoryMap(Long memberId);

    // 최근 본 맛집 기반 카테고리 선호도
    Map<String, Integer> getRecentViewCategoryMap(Long memberId);
    
    // 탐색 추천 후보 맛집 조회
    // 아직 사용자가 보지 않은 맛집 중 거리와 평점 조건을 만족하는 후보 조회
    List<AiPickDTO> getExplorationCandidateList(Long memberId, Double lat, Double lng);
    
    // 선호 카테고리와 다른 카테고리들의 유사도 조회
    Map<String, Double> getCategorySimilarityMap(String favoriteCategory);
    
    // 좋아요 기반 카테고리 선호도
    Map<String, Integer> getLikeFeedbackCategoryMap(Long memberId);
    
    // 싫어요 기반 카테고리 선호도
    Map<String, Integer> getDislikeFeedbackCategoryMap(Long memberId);
}