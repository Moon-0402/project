<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat - 리뷰</title>

<style>
* {
	box-sizing: border-box;
	font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
}

body {
	margin: 0;
	background: linear-gradient(135deg, #fffaf4, #fff3e4, #f8fbff);
	color: #111827;
}

a {
	text-decoration: none;
	color: inherit;
}

.container {
	max-width: 1180px;
	margin: 0 auto;
	padding: 54px 24px;
}

.hero {
	background: rgba(255, 255, 255, 0.9);
	border-radius: 32px;
	padding: 42px;
	box-shadow: 0 24px 70px rgba(255, 112, 0, 0.14);
	margin-bottom: 30px;
}

.hero-badge {
	display: inline-block;
	padding: 9px 15px;
	border-radius: 999px;
	background: #fff3e8;
	color: #ff6500;
	font-weight: 900;
	margin-bottom: 18px;
}

.hero h1 {
	font-size: 42px;
	margin: 0 0 14px;
	font-weight: 900;
	letter-spacing: -1px;
}

.hero p {
	color: #6b7280;
	font-size: 17px;
	line-height: 1.8;
	margin-bottom: 26px;
}

.hero-actions {
	display: flex;
	gap: 12px;
	flex-wrap: wrap;
}

.btn {
	border: none;
	border-radius: 16px;
	padding: 14px 20px;
	font-weight: 900;
	cursor: pointer;
	font-size: 14px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	transition: 0.2s ease;
}

.btn:hover {
	transform: translateY(-2px);
}

.primary {
	background: #ff6500;
	color: white;
	box-shadow: 0 10px 24px rgba(255, 101, 0, 0.22);
}

.secondary {
	background: #111827;
	color: white;
}

.section-title {
	font-size: 26px;
	font-weight: 900;
	margin: 36px 0 18px;
}

.review-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
}

.review-card {
	background: rgba(255, 255, 255, 0.92);
	border: 1px solid #f1f1f1;
	border-radius: 24px;
	padding: 24px;
	box-shadow: 0 16px 40px rgba(0, 0, 0, 0.07);
	transition: 0.2s ease;
}

.review-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 22px 50px rgba(255, 101, 0, 0.14);
}

.card-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 12px;
}

.category {
	background: #fff3e8;
	color: #ff6500;
	padding: 7px 12px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 900;
}

.stars {
	color: #ff9500;
	font-weight: 900;
}

.restaurant-name {
	font-size: 21px;
	font-weight: 900;
	margin-bottom: 10px;
}

.review-text {
	color: #6b7280;
	line-height: 1.7;
	font-size: 15px;
	min-height: 78px;
}

.meta {
	margin-top: 18px;
	padding-top: 14px;
	border-top: 1px solid #eee;
	color: #9ca3af;
	font-size: 13px;
	font-weight: 700;
}

.guide-box {
	margin-top: 34px;
	background: #111827;
	color: white;
	border-radius: 28px;
	padding: 30px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 20px;
}

.guide-box h2 {
	margin: 0 0 8px;
	font-size: 24px;
}

.guide-box p {
	margin: 0;
	color: #d1d5db;
	line-height: 1.7;
}

.empty {
	background: white;
	border-radius: 24px;
	padding: 42px;
	text-align: center;
	color: #9ca3af;
	font-weight: 800;
	box-shadow: 0 14px 35px rgba(0, 0, 0, 0.06);
}

@media (max-width: 900px) {
	.review-grid {
		grid-template-columns: 1fr;
	}

	.hero h1 {
		font-size: 32px;
	}

	.guide-box {
		display: block;
	}
}
</style>
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<main class="container">

		<section class="hero">
			<div class="hero-badge">PICK EAT REVIEW</div>

			<h1>맛집 리뷰를 한눈에 확인해보세요</h1>

			<p>
				다른 사용자들이 남긴 솔직한 후기를 보고 맛집 선택에 참고할 수 있습니다.
				리뷰 작성은 각 맛집 상세 페이지에서 가능합니다.
			</p>

			<div class="hero-actions">
				<a class="btn primary" href="${contextPath}/restaurants">
					맛집 보러가기
				</a>

				<c:choose>
					<c:when test="${not empty sessionScope.loginMember}">
						<a class="btn secondary" href="${contextPath}/mypage/reviews">
							내가 쓴 리뷰
						</a>
					</c:when>
					<c:otherwise>
						<a class="btn secondary" href="${contextPath}/member/login">
							로그인하고 리뷰 쓰기
						</a>
					</c:otherwise>
				</c:choose>
			</div>
		</section>

		<div class="section-title">리뷰 이용 방법</div>

		<div class="review-grid">

			<div class="review-card">
				<div class="card-top">
					<span class="category">STEP 01</span>
					<span class="stars">🍽</span>
				</div>
				<div class="restaurant-name">맛집 선택</div>
				<div class="review-text">
					맛집 리스트에서 원하는 식당을 선택하고 상세 페이지로 이동합니다.
				</div>
				<div class="meta">맛집 리스트 → 상세보기</div>
			</div>

			<div class="review-card">
				<div class="card-top">
					<span class="category">STEP 02</span>
					<span class="stars">⭐</span>
				</div>
				<div class="restaurant-name">리뷰 작성</div>
				<div class="review-text">
					상세 페이지의 리뷰 작성 버튼을 눌러 별점과 후기를 작성합니다.
				</div>
				<div class="meta">로그인한 회원만 작성 가능</div>
			</div>

			<div class="review-card">
				<div class="card-top">
					<span class="category">STEP 03</span>
					<span class="stars">📌</span>
				</div>
				<div class="restaurant-name">리뷰 확인</div>
				<div class="review-text">
					작성된 리뷰는 맛집별 리뷰 목록과 마이페이지에서 확인할 수 있습니다.
				</div>
				<div class="meta">리뷰 목록 / 마이페이지</div>
			</div>

		</div>

		<section class="guide-box">
			<div>
				<h2>리뷰는 맛집 상세 페이지에서 작성해요</h2>
				<p>
					리뷰는 특정 맛집에 연결되어야 하므로, 먼저 맛집을 선택한 뒤 리뷰를 작성하는 구조입니다.
				</p>
			</div>

			<a class="btn primary" href="${contextPath}/restaurants">
				맛집 선택하기
			</a>
		</section>

	</main>

	<%@ include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>