package com.springmvc.dto.aipick;
// 최종 추천 결과 1개를 화면에 보여주기 위한 데이터
public class AiPickDTO {
    private Long restaurantId;
    private String name;
    private String categoryName;
    private String kakaoCategoryName;
    private String address;
    private String imageUrl;
    private Double rating;
    private Double distance;
    private int preferenceScore;
    private int distanceScore;
    private int reviewScore;
    private int bookmarkScore;
    private int recentViewScore;
    private int feedbackScore;
    // 최근 추천 이력에 존재하면 감점요소를 주어 다른 맛집이 올라갈 수 있도록 설정
    private int duplicatePenalty;
    private int totalScore;
    private String aiReason;
	private boolean newTasteRecommendation;
	private int popularityScore;
	public AiPickDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AiPickDTO(Long restaurantId, String name, String categoryName, String kakaoCategoryName, String address,
			String imageUrl, Double rating, Double distance, int preferenceScore, int distanceScore, int reviewScore,
			int bookmarkScore, int recentViewScore, int feedbackScore, int duplicatePenalty, int totalScore,
			String aiReason, boolean newTasteRecommendation, int popularityScore) {
		super();
		this.restaurantId = restaurantId;
		this.name = name;
		this.categoryName = categoryName;
		this.kakaoCategoryName = kakaoCategoryName;
		this.address = address;
		this.imageUrl = imageUrl;
		this.rating = rating;
		this.distance = distance;
		this.preferenceScore = preferenceScore;
		this.distanceScore = distanceScore;
		this.reviewScore = reviewScore;
		this.bookmarkScore = bookmarkScore;
		this.recentViewScore = recentViewScore;
		this.feedbackScore = feedbackScore;
		this.duplicatePenalty = duplicatePenalty;
		this.totalScore = totalScore;
		this.aiReason = aiReason;
		this.newTasteRecommendation = newTasteRecommendation;
		this.popularityScore = popularityScore;
	}
	public Long getRestaurantId() {
		return restaurantId;
	}
	public void setRestaurantId(Long restaurantId) {
		this.restaurantId = restaurantId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getKakaoCategoryName() {
		return kakaoCategoryName;
	}
	public void setKakaoCategoryName(String kakaoCategoryName) {
		this.kakaoCategoryName = kakaoCategoryName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public Double getRating() {
		return rating;
	}
	public void setRating(Double rating) {
		this.rating = rating;
	}
	public Double getDistance() {
		return distance;
	}
	public void setDistance(Double distance) {
		this.distance = distance;
	}
	public int getPreferenceScore() {
		return preferenceScore;
	}
	public void setPreferenceScore(int preferenceScore) {
		this.preferenceScore = preferenceScore;
	}
	public int getDistanceScore() {
		return distanceScore;
	}
	public void setDistanceScore(int distanceScore) {
		this.distanceScore = distanceScore;
	}
	public int getReviewScore() {
		return reviewScore;
	}
	public void setReviewScore(int reviewScore) {
		this.reviewScore = reviewScore;
	}
	public int getBookmarkScore() {
		return bookmarkScore;
	}
	public void setBookmarkScore(int bookmarkScore) {
		this.bookmarkScore = bookmarkScore;
	}
	public int getRecentViewScore() {
		return recentViewScore;
	}
	public void setRecentViewScore(int recentViewScore) {
		this.recentViewScore = recentViewScore;
	}
	public int getFeedbackScore() {
		return feedbackScore;
	}
	public void setFeedbackScore(int feedbackScore) {
		this.feedbackScore = feedbackScore;
	}
	public int getDuplicatePenalty() {
		return duplicatePenalty;
	}
	public void setDuplicatePenalty(int duplicatePenalty) {
		this.duplicatePenalty = duplicatePenalty;
	}
	public int getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(int totalScore) {
		this.totalScore = totalScore;
	}
	public String getAiReason() {
		return aiReason;
	}
	public void setAiReason(String aiReason) {
		this.aiReason = aiReason;
	}
	public boolean isNewTasteRecommendation() {
		return newTasteRecommendation;
	}
	public void setNewTasteRecommendation(boolean newTasteRecommendation) {
		this.newTasteRecommendation = newTasteRecommendation;
	}
	public int getPopularityScore() {
		return popularityScore;
	}
	public void setPopularityScore(int popularityScore) {
		this.popularityScore = popularityScore;
	}
	
}
