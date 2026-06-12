<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PickEat - AI PICK</title>

<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a87f90deda3136d9524a194c121dcf1&libraries=services"></script>

<style>
* {
	box-sizing: border-box;
	font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
}

body {
	margin: 0;
	background: radial-gradient(circle at 15% 10%, rgba(94, 234, 212, 0.28),
		transparent 26%),
		radial-gradient(circle at 85% 15%, rgba(96, 165, 250, 0.22),
		transparent 30%),
		linear-gradient(135deg, #f0fdfa 0%, #eff6ff 45%, #fff7ed 100%);
	color: #111827;
}

.container {
	padding: 40px;
}

.hero {
	position: relative;
	overflow: hidden;
	background: linear-gradient(135deg, #2dd4bf, #38bdf8, #818cf8);
	color: white;
	border-radius: 32px;
	padding: 44px 42px;
	box-shadow: 0 18px 42px rgba(56, 189, 248, 0.22);
	margin-bottom: 30px;
}

.hero::after {
	content: "";
	position: absolute;
	width: 220px;
	height: 220px;
	right: -60px;
	top: -70px;
	background: rgba(255, 255, 255, 0.18);
	border-radius: 50%;
}

.hero-badge {
	position: relative;
	z-index: 1;
	display: inline-block;
	background: rgba(255, 255, 255, 0.22);
	border: 1px solid rgba(255, 255, 255, 0.35);
	backdrop-filter: blur(8px);
	padding: 8px 14px;
	border-radius: 999px;
	font-weight: 900;
	margin-bottom: 14px;
}

.hero h1 {
	position: relative;
	z-index: 1;
	font-size: 42px;
	margin: 0 0 12px;
	font-weight: 900;
}

.hero p {
	position: relative;
	z-index: 1;
	margin: 0;
	font-size: 17px;
	font-weight: 700;
	opacity: 0.95;
	line-height: 1.6;
}

.recommend-guide-box {
	background: rgba(255, 255, 255, 0.9);
	border: 1px solid rgba(125, 211, 252, 0.55);
	border-radius: 24px;
	padding: 22px 26px;
	margin-bottom: 30px;
	box-shadow: 0 12px 30px rgba(15, 23, 42, 0.07);
	color: #334155;
	font-weight: 800;
	line-height: 1.7;
}

.recommend-guide-title {
	font-size: 18px;
	font-weight: 900;
	color: #0891b2;
	margin-bottom: 8px;
}

.location-box {
	background: rgba(255, 255, 255, 0.86);
	border: 1px solid rgba(255, 255, 255, 0.75);
	border-radius: 28px;
	padding: 34px;
	margin-bottom: 30px;
	box-shadow: 0 18px 40px rgba(15, 23, 42, 0.08);
	text-align: center;
	backdrop-filter: blur(14px);
}

.location-icon {
	font-size: 46px;
	margin-bottom: 10px;
}

.location-box h2 {
	margin: 0 0 10px;
	font-size: 26px;
	font-weight: 900;
}

.location-box p {
	color: #6b7280;
	font-weight: 700;
	margin-bottom: 20px;
}

.location-actions {
	display: flex;
	justify-content: center;
	gap: 10px;
	flex-wrap: wrap;
	margin-bottom: 18px;
}

.location-input {
	width: 320px;
	height: 48px;
	border: 1px solid #e5e7eb;
	border-radius: 14px;
	padding: 0 16px;
	font-size: 15px;
	font-weight: 800;
	outline: none;
	background: white;
}

.location-input:focus {
	border-color: #38bdf8;
	box-shadow: 0 0 0 4px rgba(56, 189, 248, 0.14);
}

.location-btn {
	height: 48px;
	border: none;
	border-radius: 14px;
	padding: 0 18px;
	font-weight: 900;
	cursor: pointer;
	transition: 0.2s;
}

.location-btn:hover {
	transform: translateY(-1px);
}

.primary-btn {
	background: linear-gradient(135deg, #14b8a6, #38bdf8);
	color: white;
	box-shadow: 0 10px 22px rgba(20, 184, 166, 0.22);
}

.dark-btn {
	background: #334155;
	color: white;
	box-shadow: 0 10px 22px rgba(51, 65, 85, 0.16);
}

.location-help {
	font-size: 13px;
	color: #9ca3af;
	font-weight: 700;
	margin-top: 10px;
}

.card-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 24px;
}

.pick-card {
	background: white;
	border-radius: 24px;
	overflow: hidden;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.07);
	transition: all 0.25s ease;
	position: relative;
}

.pick-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 18px 40px rgba(56, 189, 248, 0.18);
}

.pick-card.new-taste {
	border: 3px solid #fb923c;
	box-shadow: 0 14px 38px rgba(251, 146, 60, 0.22);
}

.rank {
	position: absolute;
	top: 16px;
	left: 16px;
	background: linear-gradient(135deg, #14b8a6, #38bdf8);
	color: white;
	width: 46px;
	height: 46px;
	border-radius: 16px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	font-weight: 900;
	z-index: 2;
	box-shadow: 0 8px 18px rgba(20, 184, 166, 0.28);
}

.pick-card.new-taste .rank {
	background: linear-gradient(135deg, #f97316, #facc15);
	box-shadow: 0 8px 18px rgba(249, 115, 22, 0.28);
}

.new-badge {
	position: absolute;
	top: 16px;
	right: 16px;
	z-index: 2;
	background: linear-gradient(135deg, #f97316, #facc15);
	color: white;
	padding: 9px 13px;
	border-radius: 999px;
	font-size: 13px;
	font-weight: 900;
	box-shadow: 0 8px 18px rgba(249, 115, 22, 0.25);
}

.food-img {
	width: 100%;
	height: 190px;
	object-fit: cover;
	background: #f3f4f6;
}

.card-body {
	padding: 22px;
}

.card-title {
	font-size: 22px;
	font-weight: 900;
	margin: 0 0 10px;
}

.category {
	color: #0891b2;
	font-weight: 900;
	font-size: 14px;
	margin-bottom: 8px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.address {
	color: #6b7280;
	font-size: 14px;
	font-weight: 700;
	line-height: 1.5;
	min-height: 42px;
}

.score-box {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 8px;
	margin: 18px 0;
}

.score-item {
	background: #f0fdfa;
	border: 1px solid #ccfbf1;
	border-radius: 14px;
	padding: 10px;
}

.pick-card.new-taste .score-item {
	background: #fff7ed;
	border: 1px solid #fed7aa;
}

.score-label {
	font-size: 12px;
	color: #6b7280;
	font-weight: 800;
}

.score-value {
	margin-top: 4px;
	font-size: 17px;
	font-weight: 900;
	color: #111827;
}

.score-visual-box {
	margin: 16px 0;
	background: #f8fafc;
	border: 1px solid #e2e8f0;
	border-radius: 16px;
	padding: 14px;
}

.pick-card.new-taste .score-visual-box {
	background: #fff7ed;
	border: 1px solid #fed7aa;
}

.score-visual-title {
	font-size: 13px;
	font-weight: 900;
	color: #334155;
	margin-bottom: 12px;
}

.pick-card.new-taste .score-visual-title {
	color: #9a3412;
}

.score-axis {
	display: grid;
	grid-template-columns: 66px 1fr 48px;
	align-items: center;
	gap: 8px;
	margin-bottom: 10px;
}

.score-axis-scale {
	position: relative;
	height: 22px;
	font-size: 10px;
	font-weight: 900;
	color: #94a3b8;
}

.score-axis-scale span {
	position: absolute;
	top: 0;
	transform: translateX(-50%);
}

.score-axis-scale span:nth-child(1) {
	left: 0%;
}

.score-axis-scale span:nth-child(2) {
	left: 25%;
}

.score-axis-scale span:nth-child(3) {
	left: 50%;
	color: #334155;
}

.score-axis-scale span:nth-child(4) {
	left: 75%;
}

.score-axis-scale span:nth-child(5) {
	left: 100%;
}

.score-bar-row {
	display: grid;
	grid-template-columns: 66px 1fr 48px;
	align-items: center;
	gap: 8px;
	margin-bottom: 10px;
}

.score-bar-row:last-child {
	margin-bottom: 0;
}

.score-bar-label {
	font-size: 12px;
	font-weight: 900;
	color: #475569;
}

.score-bar-track {
	position: relative;
	height: 18px;
	background: linear-gradient(90deg, #fee2e2 0%, #f8fafc 50%, #dcfce7 100%);
	border: 1px solid #e2e8f0;
	border-radius: 999px;
	overflow: hidden;
}

.score-bar-track::before {
	content: "";
	position: absolute;
	left: 50%;
	top: 0;
	bottom: 0;
	width: 2px;
	background: #334155;
	transform: translateX(-50%);
	z-index: 3;
}

.score-bar-track::after {
	content: "";
	position: absolute;
	inset: 0;
	background: repeating-linear-gradient(
		90deg,
		transparent 0,
		transparent calc(25% - 1px),
		rgba(100, 116, 139, 0.22) calc(25% - 1px),
		rgba(100, 116, 139, 0.22) 25%
	);
	pointer-events: none;
	z-index: 2;
}

.score-bar-fill {
	position: absolute;
	top: 50%;
	height: 10px;
	width: 0;
	border-radius: 999px;
	transform: translateY(-50%);
	z-index: 1;
}

.score-bar-fill.positive {
	left: 50%;
	background: linear-gradient(135deg, #14b8a6, #38bdf8);
}

.score-bar-fill.negative {
	right: 50%;
	background: linear-gradient(135deg, #fb7185, #f97316);
}

.pick-card.new-taste .score-bar-fill.positive {
	background: linear-gradient(135deg, #f97316, #facc15);
}

.score-bar-num {
	font-size: 12px;
	font-weight: 900;
	color: #111827;
	text-align: right;
}

.ai-reason {
	background: #f8fafc;
	border: 1px solid #e2e8f0;
	border-radius: 16px;
	padding: 14px;
	color: #374151;
	font-size: 14px;
	font-weight: 800;
	line-height: 1.6;
	min-height: 72px;
}

.pick-card.new-taste .ai-reason {
	background: #fff7ed;
	border: 1px solid #fed7aa;
	color: #9a3412;
}

.reason-title {
	font-weight: 900;
	margin-bottom: 6px;
	color: #f97316;
}

.btn-row {
	display: flex;
	gap: 8px;
	margin-top: 18px;
}

.btn {
	flex: 1;
	text-align: center;
	text-decoration: none;
	border-radius: 12px;
	padding: 11px 10px;
	font-weight: 900;
	font-size: 14px;
	transition: 0.2s;
}

.btn:hover {
	transform: translateY(-1px);
}

.detail-btn {
	background: linear-gradient(135deg, #14b8a6, #38bdf8);
	color: white;
}

.review-btn {
	background: #6366f1;
	color: white;
}

.feedback-row {
	display: flex;
	gap: 8px;
	margin-top: 10px;
}

.feedback-row form {
	flex: 1;
}

.feedback-btn {
	width: 100%;
	border: none;
	border-radius: 12px;
	padding: 11px 10px;
	font-weight: 900;
	font-size: 14px;
	cursor: pointer;
	transition: 0.2s;
}

.feedback-btn:hover {
	transform: translateY(-1px);
}

.like-btn {
	background: #dcfce7;
	color: #166534;
}

.dislike-btn {
	background: #fee2e2;
	color: #991b1b;
}

.empty-box {
	background: white;
	border-radius: 24px;
	padding: 60px;
	text-align: center;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
	color: #6b7280;
	font-weight: 800;
}

@media ( max-width : 1000px) {
	.card-grid {
		grid-template-columns: 1fr;
	}
	.location-input {
		width: 100%;
	}
}


/* footer 하단 정렬용 레이아웃 보정 */
html,
body {
    min-height: 100%;
}

body {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

main,
.container,
.admin-layout,
.page-wrap,
.page-container,
.content,
.main-content {
    flex: 1 0 auto;
}

.admin-layout,
.page-wrap {
    min-height: 0;
}

.footer {
    margin-top: auto;
    flex-shrink: 0;
}
</style>

	<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pickeat-mobile.css?v=20260612-4">
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<main class="container">

		<section class="hero">
			<div class="hero-badge">AI PICK</div>
			<h1>지금 나에게 딱 맞는 맛집 🍽️</h1>
			<p>
				2곳은 취향·거리·평점 점수 기반으로, 1곳은 새로운 취향 탐색 맛집으로 추천해드려요.
				같은 맛집이 자주 보인다면 좋아요/별로예요를 눌러 추천 점수를 조정할 수 있어요.
			</p>
		</section>

		<section class="recommend-guide-box">
			<div class="recommend-guide-title">추천 결과를 더 다양하게 바꾸는 방법</div>
			<div>
				👍 좋아요를 누르면 비슷한 취향의 맛집이 더 자주 추천되고,
				👎 별로예요를 누르면 해당 맛집의 점수가 낮아져 다른 선택지를 볼 가능성이 높아져요.
				추천이 반복될 때는 피드백을 눌러 나에게 맞는 추천으로 조정해보세요.
			</div>
		</section>

		<section class="location-box">
			<div class="location-icon">📍</div>

			<c:choose>
				<c:when test="${needLocation}">
					<h2>추천받을 위치를 선택해주세요</h2>
					<p>현재 위치를 사용하거나, 건물명/장소명을 직접 검색할 수 있어요.</p>
				</c:when>
				<c:otherwise>
					<h2>다른 위치에서 다시 추천받기</h2>
					<p>위치가 다르게 잡혔다면 건물명이나 장소명을 입력해 다시 추천받아보세요.</p>
				</c:otherwise>
			</c:choose>

			<div class="location-actions">
				<button type="button" class="location-btn dark-btn"
					onclick="useCurrentLocation()">현재 위치 사용</button>

				<input type="text" id="locationKeyword" class="location-input"
					placeholder="예: 경민인터빌, 부산역, 강남역">

				<button type="button" class="location-btn primary-btn"
					onclick="searchLocation()">장소 검색</button>
			</div>

			<div class="location-help">
				장소명을 입력하면 카카오 장소 검색으로 좌표를 찾아 AI PICK 추천을 다시 실행합니다.
			</div>
		</section>

		<c:if test="${not needLocation}">

			<c:choose>
				<c:when test="${empty aiPickList}">
					<section class="empty-box">
						추천할 맛집 데이터가 아직 없습니다.<br>
						맛집을 즐겨찾기하거나 리뷰를 작성하면 더 정확한 AI PICK을 받을 수 있어요.
					</section>
				</c:when>

				<c:otherwise>
					<section class="card-grid">

						<c:forEach var="pick" items="${aiPickList}" varStatus="status">

							<article class="pick-card ${pick.newTasteRecommendation ? 'new-taste' : ''}">

								<div class="rank">${status.index + 1}</div>

								<c:if test="${pick.newTasteRecommendation}">
									<div class="new-badge">✨ 탐색 추천</div>
								</c:if>

								<c:choose>
									<c:when test="${fn:contains(pick.categoryName, '한식')}">
										<img class="food-img" src="${contextPath}/resources/images/category/korean.jpg">
									</c:when>
									<c:when test="${fn:contains(pick.categoryName, '중식')}">
										<img class="food-img" src="${contextPath}/resources/images/category/chinese.jpg">
									</c:when>
									<c:when test="${fn:contains(pick.categoryName, '일식')}">
										<img class="food-img" src="${contextPath}/resources/images/category/japanese.jpg">
									</c:when>
									<c:when test="${fn:contains(pick.categoryName, '양식') or fn:contains(pick.categoryName, '샐러드')}">
										<img class="food-img" src="${contextPath}/resources/images/category/western.jpg">
									</c:when>
									<c:when test="${fn:contains(pick.categoryName, '치킨')}">
										<img class="food-img" src="${contextPath}/resources/images/category/chicken.jpg">
									</c:when>
									<c:when test="${fn:contains(pick.categoryName, '카페') or fn:contains(pick.categoryName, '디저트')}">
										<img class="food-img" src="${contextPath}/resources/images/category/cafe.jpg">
									</c:when>
									<c:when test="${fn:contains(pick.categoryName, '분식')}">
										<img class="food-img" src="${contextPath}/resources/images/category/snack_food.jpg">
									</c:when>
									<c:otherwise>
										<img class="food-img" src="${contextPath}/resources/images/category/etc_food.png">
									</c:otherwise>
								</c:choose>

								<div class="card-body">
									<h2 class="card-title">${pick.name}</h2>

									<div class="category" title="${pick.kakaoCategoryName}">
										${pick.categoryName}
									</div>

									<div class="address">${pick.address}</div>

									<div class="score-box">

										<div class="score-item">
											<div class="score-label">
												<c:choose>
													<c:when test="${pick.newTasteRecommendation}">
														추천 유형
													</c:when>
													<c:otherwise>
														총점
													</c:otherwise>
												</c:choose>
											</div>

											<div class="score-value">
												<c:choose>
													<c:when test="${pick.newTasteRecommendation}">
														탐색추천
													</c:when>
													<c:otherwise>
														${pick.totalScore}점
													</c:otherwise>
												</c:choose>
											</div>
										</div>

										<div class="score-item">
											<div class="score-label">거리</div>
											<div class="score-value">${pick.distance}km</div>
										</div>

										<div class="score-item">
											<div class="score-label">평점</div>
											<div class="score-value">★ ${pick.rating}</div>
										</div>

										<div class="score-item">
											<div class="score-label">
												<c:choose>
													<c:when test="${pick.newTasteRecommendation}">
														신규성
													</c:when>
													<c:otherwise>
														취향점수
													</c:otherwise>
												</c:choose>
											</div>

											<div class="score-value">
												<c:choose>
													<c:when test="${pick.newTasteRecommendation}">
														NEW
													</c:when>
													<c:otherwise>
														${pick.preferenceScore}점
													</c:otherwise>
												</c:choose>
											</div>
										</div>

									</div>

									<c:choose>
										<c:when test="${pick.newTasteRecommendation}">
											<div class="score-visual-box">
												<div class="score-visual-title">탐색 추천 기준</div>

												<div class="score-axis">
													<div></div>
													<div class="score-axis-scale">
														<span>-100</span>
														<span>-50</span>
														<span>0</span>
														<span>50</span>
														<span>100</span>
													</div>
													<div></div>
												</div>

												<div class="score-bar-row">
													<div class="score-bar-label">거리</div>
													<div class="score-bar-track" data-score="${pick.distanceScore}">
														<div class="score-bar-fill"></div>
													</div>
													<div class="score-bar-num">${pick.distanceScore}점</div>
												</div>

												<div class="score-bar-row">
													<div class="score-bar-label">평점</div>
													<div class="score-bar-track" data-score="${pick.popularityScore}">
														<div class="score-bar-fill"></div>
													</div>
													<div class="score-bar-num">${pick.popularityScore}점</div>
												</div>

												<div class="score-bar-row">
													<div class="score-bar-label">신규성</div>
													<div class="score-bar-track" data-score="60">
														<div class="score-bar-fill"></div>
													</div>
													<div class="score-bar-num">NEW</div>
												</div>
											</div>
										</c:when>

										<c:otherwise>
											<div class="score-visual-box">
												<div class="score-visual-title">추천 점수 분석</div>

												<div class="score-axis">
													<div></div>
													<div class="score-axis-scale">
														<span>-100</span>
														<span>-50</span>
														<span>0</span>
														<span>50</span>
														<span>100</span>
													</div>
													<div></div>
												</div>

												<div class="score-bar-row">
													<div class="score-bar-label">취향</div>
													<div class="score-bar-track" data-score="${pick.preferenceScore}">
														<div class="score-bar-fill"></div>
													</div>
													<div class="score-bar-num">${pick.preferenceScore}점</div>
												</div>

												<div class="score-bar-row">
													<div class="score-bar-label">피드백</div>
													<div class="score-bar-track" data-score="${pick.feedbackScore}">
														<div class="score-bar-fill"></div>
													</div>
													<div class="score-bar-num">${pick.feedbackScore}점</div>
												</div>

												<div class="score-bar-row">
													<div class="score-bar-label">거리</div>
													<div class="score-bar-track" data-score="${pick.distanceScore}">
														<div class="score-bar-fill"></div>
													</div>
													<div class="score-bar-num">${pick.distanceScore}점</div>
												</div>

												<div class="score-bar-row">
													<div class="score-bar-label">리뷰</div>
													<div class="score-bar-track" data-score="${pick.reviewScore}">
														<div class="score-bar-fill"></div>
													</div>
													<div class="score-bar-num">${pick.reviewScore}점</div>
												</div>

												<div class="score-bar-row">
													<div class="score-bar-label">즐겨찾기</div>
													<div class="score-bar-track" data-score="${pick.bookmarkScore}">
														<div class="score-bar-fill"></div>
													</div>
													<div class="score-bar-num">${pick.bookmarkScore}점</div>
												</div>

												<div class="score-bar-row">
													<div class="score-bar-label">최근조회</div>
													<div class="score-bar-track" data-score="${pick.recentViewScore}">
														<div class="score-bar-fill"></div>
													</div>
													<div class="score-bar-num">${pick.recentViewScore}점</div>
												</div>

												<c:if test="${pick.duplicatePenalty > 0}">
													<div class="score-bar-row">
														<div class="score-bar-label">중복감점</div>
														<div class="score-bar-track" data-score="-${pick.duplicatePenalty}">
															<div class="score-bar-fill"></div>
														</div>
														<div class="score-bar-num">-${pick.duplicatePenalty}점</div>
													</div>
												</c:if>
											</div>
										</c:otherwise>
									</c:choose>

									<div class="ai-reason">
										<c:choose>
											<c:when test="${pick.newTasteRecommendation}">
												<div class="reason-title">
													✨ 탐색 추천: 안 가봤지만 좋아할 가능성이 높은 맛집
												</div>
												🤖 ${pick.aiReason}
											</c:when>
											<c:otherwise>
												🤖 ${pick.aiReason}
											</c:otherwise>
										</c:choose>
									</div>

									<div class="btn-row">
										<a class="btn detail-btn"
											href="${contextPath}/restaurants/${pick.restaurantId}">
											상세보기
										</a>
										<a class="btn review-btn"
											href="${contextPath}/review/list?restaurantId=${pick.restaurantId}">
											리뷰보기
										</a>
									</div>

									<div class="feedback-row">

										<form action="${contextPath}/aipick/feedback" method="post">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
											<input type="hidden" name="restaurantId" value="${pick.restaurantId}">
											<input type="hidden" name="feedbackType" value="LIKE">
											<input type="hidden" name="lat" value="${param.lat}">
											<input type="hidden" name="lng" value="${param.lng}">

											<button type="submit" class="feedback-btn like-btn">
												👍 좋아요
											</button>
										</form>

										<form action="${contextPath}/aipick/feedback" method="post">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
											<input type="hidden" name="restaurantId" value="${pick.restaurantId}">
											<input type="hidden" name="feedbackType" value="DISLIKE">
											<input type="hidden" name="lat" value="${param.lat}">
											<input type="hidden" name="lng" value="${param.lng}">

											<button type="submit" class="feedback-btn dislike-btn">
												👎 별로예요
											</button>
										</form>

									</div>
								</div>

							</article>
						</c:forEach>

					</section>
				</c:otherwise>
			</c:choose>

		</c:if>

	</main>

	<script>
		function useCurrentLocation() {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(function(position) {
					const lat = position.coords.latitude;
					const lng = position.coords.longitude;

					location.href = "${contextPath}/aipick?lat=" + lat
							+ "&lng=" + lng;
				}, function() {
					alert("현재 위치를 가져올 수 없습니다. 장소명을 직접 검색해주세요.");
				});
			} else {
				alert("현재 브라우저에서는 위치 기능을 지원하지 않습니다. 장소명을 직접 검색해주세요.");
			}
		}

		function searchLocation() {
			const keyword = document.getElementById("locationKeyword").value.trim();

			if (!keyword) {
				alert("장소명이나 건물명을 입력해주세요.");
				return;
			}

			if (typeof kakao === "undefined" || !kakao.maps || !kakao.maps.services) {
				alert("카카오 지도 서비스를 불러오지 못했습니다.");
				return;
			}

			const ps = new kakao.maps.services.Places();

			ps.keywordSearch(keyword, function(data, status) {
				if (status === kakao.maps.services.Status.OK && data.length > 0) {
					const lat = data[0].y;
					const lng = data[0].x;

					location.href = "${contextPath}/aipick?lat=" + lat + "&lng=" + lng;
				} else {
					alert("입력한 위치를 찾을 수 없습니다. 예: 경민인터빌, 부산역처럼 다시 입력해주세요.");
				}
			});
		}

		function initScoreBars() {
			document.querySelectorAll(".score-bar-track").forEach(function(track) {
				const fill = track.querySelector(".score-bar-fill");

				if (!fill) {
					return;
				}

				let score = Number(track.dataset.score);

				if (Number.isNaN(score)) {
					score = 0;
				}

				const limitedScore = Math.max(-100, Math.min(100, score));
				const widthPercent = Math.abs(limitedScore) / 2;

				fill.classList.remove("positive", "negative");
				fill.classList.add(limitedScore < 0 ? "negative" : "positive");
				fill.style.width = widthPercent + "%";
			});
		}

		document.addEventListener("DOMContentLoaded", initScoreBars);
	</script>


	<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>