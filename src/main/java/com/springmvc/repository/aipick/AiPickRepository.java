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
    
    // 새로운 추천 1개
    AiPickDTO getNewPickByFavoriteCategory(Long memberId, String categoryName, Double lat, Double lng);
}