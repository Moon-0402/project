package com.springmvc.service.aipick;

import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.dto.aipick.AiPickDTO;
import com.springmvc.repository.aipick.AiPickRepository;

@Service
public class AiPickServiceImpl implements AiPickService {

    @Autowired
    private AiPickRepository aiPickRepository;

    @Override
    public List<AiPickDTO> getAiPickList(Long memberId, Double lat, Double lng) {

        List<AiPickDTO> aiPickList =
                aiPickRepository.getAiPickList(memberId, lat, lng);

        Map<String, Integer> bookmarkMap =
                aiPickRepository.getBookmarkCategoryMap(memberId);

        Map<String, Integer> reviewMap =
                aiPickRepository.getReviewCategoryMap(memberId);

        Map<String, Integer> recentViewMap =
                aiPickRepository.getRecentViewCategoryMap(memberId);

        for (AiPickDTO aiPick : aiPickList) {

            String categoryName = aiPick.getCategoryName();
            String kakaoCategoryName = aiPick.getKakaoCategoryName();

            int bookmarkScore = Math.min(
                    calculateCategoryScore(bookmarkMap, categoryName, kakaoCategoryName, 25, 12),
                    100
            );

            int reviewScore = Math.min(
                    calculateCategoryScore(reviewMap, categoryName, kakaoCategoryName, 20, 10),
                    80
            );

            int recentViewScore = Math.min(
                    calculateCategoryScore(recentViewMap, categoryName, kakaoCategoryName, 15, 8),
                    50
            );

            int preferenceScore =
                    bookmarkScore + reviewScore + recentViewScore;

            int distanceScore =
                    calculateDistanceScore(aiPick.getDistance());

            int ratingScore =
                    calculateRatingScore(aiPick.getRating());

            // 테이블 없이 추천 결과가 매번 완전히 고정되지 않도록 소폭 랜덤 점수 부여
            int randomScore =
                    ThreadLocalRandom.current().nextInt(0, 11);
            int duplicatePenalty = calculateDuplicatePenalty(aiPick, bookmarkMap, reviewMap, recentViewMap);

            int totalScore =
                    preferenceScore
                    + distanceScore
                    + ratingScore
                    + randomScore
                    - duplicatePenalty;

            aiPick.setBookmarkScore(bookmarkScore);
            aiPick.setReviewScore(reviewScore);
            aiPick.setRecentViewScore(recentViewScore);
            aiPick.setPreferenceScore(preferenceScore);
            aiPick.setDistanceScore(distanceScore);
            aiPick.setDuplicatePenalty(duplicatePenalty);
            aiPick.setTotalScore(totalScore);

            aiPick.setAiReason(makeAiReason(aiPick));
        }

        List<AiPickDTO> scoreBasedList = aiPickList.stream()
                .filter(pick -> pick.getDistance() != null && pick.getDistance() <= 10)
                .sorted(Comparator.comparingInt(AiPickDTO::getTotalScore).reversed())
                .collect(Collectors.toList());

        List<AiPickDTO> result = scoreBasedList.stream()
                .limit(2)
                .collect(Collectors.toList());

        String favoriteCategory = findFavoriteCategory(bookmarkMap, reviewMap, recentViewMap);

        if (favoriteCategory != null) {

            AiPickDTO explorationPick = findExplorationPick(memberId, favoriteCategory, lat, lng, result);

            if (explorationPick != null) {
                result.add(explorationPick);
            }
        }

        if (result.size() < 3) {
            for (AiPickDTO pick : scoreBasedList) {
                if (result.size() >= 3) break;

                boolean alreadyExists = result.stream()
                        .anyMatch(r -> r.getRestaurantId().equals(pick.getRestaurantId()));

                if (!alreadyExists) {
                    result.add(pick);
                }
            }
        }

        return result;
    }

    private int calculateSimilarityScore(
            AiPickDTO pick,
            Map<String, Double> similarityMap,
            String favoriteCategory) {

        String categoryName = pick.getCategoryName();

        if (categoryName == null || categoryName.isBlank()) {
            return 0;
        }

        if (categoryName.equals(favoriteCategory)) {
            return 35;
        }

        double similarity = similarityMap.getOrDefault(categoryName, 0.0);

        return (int) (similarity * 60);
    }

    private int calculatePopularityScore(Double rating) {

        if (rating == null) {
            return 0;
        }

        if (rating >= 4.5) {
            return 30;
        } else if (rating >= 4.0) {
            return 20;
        } else if (rating >= 3.5) {
            return 10;
        }

        return 0;
    }
    
    // 선호 카테고리

    private String findFavoriteCategory(
            Map<String, Integer> bookmarkMap,
            Map<String, Integer> reviewMap,
            Map<String, Integer> recentViewMap) {

        Map<String, Integer> totalMap = new java.util.HashMap<>();

        addCategoryScore(totalMap, bookmarkMap, 3);
        addCategoryScore(totalMap, reviewMap, 2);
        addCategoryScore(totalMap, recentViewMap, 1);

        return totalMap.entrySet()
                .stream()
                .max(Map.Entry.comparingByValue())
                .map(Map.Entry::getKey)
                .orElse(null);
    }

    private void addCategoryScore(
            Map<String, Integer> totalMap,
            Map<String, Integer> sourceMap,
            int weight) {

        for (Map.Entry<String, Integer> entry : sourceMap.entrySet()) {
            totalMap.put(
                    entry.getKey(),
                    totalMap.getOrDefault(entry.getKey(), 0)
                            + entry.getValue() * weight
            );
        }
    }

    private int calculateCategoryScore(
            Map<String, Integer> map,
            String categoryName,
            String kakaoCategoryName,
            int kakaoWeight,
            int categoryWeight) {

        int score = 0;

        if (kakaoCategoryName != null && !kakaoCategoryName.isBlank()) {
            score += map.getOrDefault(kakaoCategoryName, 0) * kakaoWeight;
        }

        if (categoryName != null && !categoryName.isBlank()) {
            score += map.getOrDefault(categoryName, 0) * categoryWeight;
        }

        return score;
    }

    private int calculateDistanceScore(Double distance) {

        if (distance == null) {
            return 0;
        }

        if (distance <= 1) {
            return 50;
        } else if (distance <= 3) {
            return 40;
        } else if (distance <= 5) {
            return 30;
        } else if (distance <= 10) {
            return 20;
        }

        return 10;
    }

    
    private AiPickDTO findExplorationPick(Long memberId, String favoriteCategory, Double lat, Double lng, List<AiPickDTO> alreadySelectedList) {

        List<AiPickDTO> candidates =
                aiPickRepository.getExplorationCandidateList(memberId, lat, lng);

        Map<String, Double> similarityMap =
                aiPickRepository.getCategorySimilarityMap(favoriteCategory);

        List<AiPickDTO> scoredCandidates = new java.util.ArrayList<>();

        for (AiPickDTO pick : candidates) {

            boolean alreadySelected = alreadySelectedList.stream()
                    .anyMatch(selected ->
                            selected.getRestaurantId().equals(pick.getRestaurantId()));

            if (alreadySelected) {
                continue;
            }

            int similarityScore =
                    calculateSimilarityScore(pick, similarityMap, favoriteCategory);

            int popularityScore =
                    calculatePopularityScore(pick.getRating());

            int noveltyScore = 30;

            int distanceScore =
                    calculateDistanceScore(pick.getDistance());

            int randomScore =
                    ThreadLocalRandom.current().nextInt(0, 11);

            int explorationScore =
                    similarityScore
                    + popularityScore
                    + noveltyScore
                    + distanceScore
                    + randomScore;

            pick.setPreferenceScore(explorationScore);
            pick.setDistanceScore(distanceScore);
            pick.setTotalScore(explorationScore);

            scoredCandidates.add(pick);
        }

        if (scoredCandidates.isEmpty()) {
            return null;
        }

        // 점수 높은 순으로 정렬
        scoredCandidates.sort(
                Comparator.comparingInt(AiPickDTO::getTotalScore).reversed()
        );

        // 상위 5개 중 랜덤 선택
        int limit = Math.min(5, scoredCandidates.size());
        int randomIndex = ThreadLocalRandom.current().nextInt(0, limit);

        AiPickDTO explorationPick = scoredCandidates.get(randomIndex);

        explorationPick.setNewTasteRecommendation(true);
        explorationPick.setAiReason(
                "최근 기록을 분석해보니 " + favoriteCategory
                + " 계열을 선호하는 것으로 보여요. "
                + "이번에는 평점, 거리, 유사 카테고리를 함께 고려해서 새로운 취향 추천으로 선정했어요."
        );

        return explorationPick;
    }

    private int calculateRatingScore(Double rating) {

        if (rating == null) {
            return 0;
        }

        return (int) (rating * 5);
    }

    private String makeAiReason(AiPickDTO aiPick) {

        List<String> reasons = new java.util.ArrayList<>();

        if (aiPick.getBookmarkScore() > 0) {
            reasons.add("즐겨찾기한 맛집과 비슷한 취향");
        }

        if (aiPick.getReviewScore() > 0) {
            reasons.add("리뷰를 자주 남긴 카테고리");
        }

        if (aiPick.getRecentViewScore() > 0) {
            reasons.add("최근 관심을 보인 음식");
        }

        if (aiPick.getDistance() != null && aiPick.getDistance() <= 3) {
            reasons.add("현재 위치와 가까운 거리");
        }

        if (aiPick.getRating() != null && aiPick.getRating() >= 4.0) {
            reasons.add("높은 평점");
        }

        if (reasons.isEmpty()) {
            return "거리와 평점 정보를 종합하여 추천했어요.";
        }

        return String.join(", ", reasons) + "를 종합하여 추천했어요.";
    }

    //최근 본 맛집과 같은 카테고리 → -5점 리뷰 쓴 카테고리와 같음 → -5점 즐겨찾기한 카테고리와 같음 → -5점 --->사용자가 이미 자주 본 카테고리면 약간 감점 그래도 점수가 높으면 추천 가능 완전히 제외하지는 않음
    private int calculateDuplicatePenalty(AiPickDTO aiPick, Map<String, Integer> bookmarkMap, Map<String, Integer> reviewMap, Map<String, Integer> recentViewMap) {

        int penalty = 0;

        String categoryName = aiPick.getCategoryName();

        if (categoryName == null || categoryName.isBlank()) {
            return 0;
        }

        if (bookmarkMap.containsKey(categoryName)) {
            penalty += 5;
        }

        if (reviewMap.containsKey(categoryName)) {
            penalty += 5;
        }

        if (recentViewMap.containsKey(categoryName)) {
            penalty += 5;
        }

        return Math.min(penalty, 15);
    }
}