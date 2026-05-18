<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

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
	background: rgba(255, 255, 255, 0.92);
	border-radius: 32px;
	padding: 46px;
	box-shadow: 0 24px 70px rgba(255, 112, 0, 0.14);
	margin-bottom: 34px;
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
	margin-bottom: 28px;
}

.search-box {
	background: #fff7ed;
	border: 1px solid #ffe0c2;
	border-radius: 24px;
	padding: 22px;
}

.search-title {
	font-size: 18px;
	font-weight: 900;
	margin-bottom: 14px;
	color: #111827;
}

.search-form {
	display: grid;
	grid-template-columns: 1fr 1fr 120px;
	gap: 12px;
}

.search-form input {
	height: 50px;
	border: 1px solid #e5e7eb;
	border-radius: 14px;
	padding: 0 16px;
	font-size: 14px;
	font-weight: 700;
	outline: none;
	background: white;
}

.search-form input:focus {
	border-color: #ff6500;
	box-shadow: 0 0 0 4px rgba(255, 101, 0, 0.1);
}

.search-form button {
	height: 50px;
	border: none;
	border-radius: 14px;
	background: #ff6500;
	color: white;
	font-weight: 900;
	cursor: pointer;
	transition: 0.2s;
}

.search-form button:hover {
	background: #ea580c;
	transform: translateY(-1px);
}

.hero-actions {
	display: flex;
	gap: 12px;
	flex-wrap: wrap;
	margin-top: 20px;
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

.section-head {
	display: flex;
	align-items: flex-end;
	justify-content: space-between;
	gap: 20px;
	margin: 38px 0 18px;
}

.section-title {
	font-size: 28px;
	font-weight: 900;
}

.section-subtitle {
	color: #6b7280;
	font-weight: 700;
	margin-top: 6px;
}

.review-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
}

.review-card {
	background: rgba(255, 255, 255, 0.94);
	border: 1px solid #f1f1f1;
	border-radius: 24px;
	overflow: hidden;
	box-shadow: 0 16px 40px rgba(0, 0, 0, 0.07);
	transition: 0.2s ease;
	display: flex;
	flex-direction: column;
}

.review-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 22px 50px rgba(255, 101, 0, 0.14);
}

.review-image {
	width: 100%;
	height: 180px;
	object-fit: cover;
	background: #f3f4f6;
}

.no-image-box {
	width: 100%;
	height: 180px;
	background: #f3f4f6;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #9ca3af;
	font-weight: 900;
}

.review-body {
	padding: 22px;
	display: flex;
	flex-direction: column;
	flex: 1;
}

.card-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 12px;
	gap: 10px;
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
	color: #facc15;
	font-weight: 900;
	white-space: nowrap;
}

.restaurant-name {
	font-size: 21px;
	font-weight: 900;
	margin-bottom: 10px;
	color: #111827;
}

.review-text {
	color: #6b7280;
	line-height: 1.7;
	font-size: 15px;
	min-height: 78px;
	word-break: break-word;
}

.meta {
	margin-top: 18px;
	padding-top: 14px;
	border-top: 1px solid #eee;
	color: #9ca3af;
	font-size: 13px;
	font-weight: 700;
}

.card-actions {
	display: flex;
	gap: 10px;
	margin-top: 16px;
}

.card-btn {
	flex: 1;
	height: 42px;
	border-radius: 13px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 900;
	font-size: 13px;
	text-decoration: none;
}

.detail-btn {
	background: #fff3df;
	color: #b45309;
	border: 1px solid #f4d7b7;
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

.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 10px;
	margin-top: 42px;
	flex-wrap: wrap;
}

.pagination a {
	min-width: 42px;
	height: 42px;
	padding: 0 14px;
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: white;
	border: 1px solid #e5e7eb;
	font-weight: 800;
	color: #374151;
	transition: 0.2s;
}

.pagination a:hover {
	background: #fff3df;
	border-color: #ff6500;
	color: #ff6500;
}

.pagination a.active {
	background: #ff6500;
	color: white;
	border-color: #ff6500;
}

@media (max-width: 900px) {
	.search-form {
		grid-template-columns: 1fr;
	}

	.review-grid {
		grid-template-columns: 1fr;
	}

	.hero h1 {
		font-size: 32px;
	}

	.guide-box {
		display: block;
	}

	.guide-box .btn {
		margin-top: 18px;
	}
}
</style>
</head>

<body>

<%@ include file="/WEB-INF/views/header.jsp"%>

<main class="container">

	<section class="hero">
		<div class="hero-badge">PICK EAT REVIEW</div>

		<h1>맛집 리뷰를 보고 오늘의 식당을 골라보세요</h1>

		<p>
			다른 사용자들이 남긴 최신 리뷰를 확인하고,
			지역과 음식 키워드로 원하는 리뷰를 검색할 수 있습니다.
		</p>

		<div class="search-box">
			<div class="search-title">리뷰 검색</div>

			<form class="search-form"
				  action="${contextPath}/review"
				  method="get">

				<input type="text"
					   name="regionKeyword"
					   value="${regionKeyword}"
					   placeholder="지역 예: 경남대, 창원시청">

				<input type="text"
					   name="foodKeyword"
					   value="${foodKeyword}"
					   placeholder="음식/리뷰 예: 피자, 국밥, 분위기 좋은">

				<button type="submit">리뷰 검색</button>
			</form>
		</div>

		<div class="hero-actions">
			<a class="btn primary"
			   href="${contextPath}/restaurants">
				맛집 리스트 보기
			</a>

			<c:choose>
				<c:when test="${not empty sessionScope.loginMember}">
					<a class="btn secondary"
					   href="${contextPath}/mypage/reviews">
						내가 쓴 리뷰
					</a>
				</c:when>

				<c:otherwise>
					<a class="btn secondary"
					   href="${contextPath}/member/login">
						로그인하고 리뷰 쓰기
					</a>
				</c:otherwise>
			</c:choose>
		</div>
	</section>

	<div class="section-head">
		<div>
			<div class="section-title">
				<c:choose>
					<c:when test="${isSearch}">
						리뷰 검색 결과
					</c:when>
					<c:otherwise>
						최신 리뷰
					</c:otherwise>
				</c:choose>
			</div>

			<div class="section-subtitle">
				<c:choose>
					<c:when test="${isSearch}">
						검색 조건에 맞는 리뷰 결과입니다.
					</c:when>
					<c:otherwise>
						사용자들이 방금 남긴 따끈한 맛집 후기를 확인해보세요.
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	<c:choose>
		<c:when test="${empty latestReviewList}">
			<div class="empty">
				<c:choose>
					<c:when test="${isSearch}">
						검색 결과가 없습니다.
					</c:when>
					<c:otherwise>
						아직 등록된 최신 리뷰가 없습니다.
					</c:otherwise>
				</c:choose>
			</div>
		</c:when>

		<c:otherwise>
			<div class="review-grid">
				<c:forEach var="review" items="${latestReviewList}">
					<div class="review-card">

						<c:choose>
							<c:when test="${not empty review.image}">
								<img class="review-image"
									 src="${contextPath}${review.image}"
									 alt="리뷰 이미지"
									 onerror="this.outerHTML='<div class=&quot;no-image-box&quot;>등록된 이미지 없음</div>';">
							</c:when>

							<c:otherwise>
								<div class="no-image-box">
									등록된 이미지 없음
								</div>
							</c:otherwise>
						</c:choose>

						<div class="review-body">
							<div class="card-top">
								<span class="category">NEW REVIEW</span>

								<span class="stars">
									<c:forEach begin="1" end="${review.rating}">
										★
									</c:forEach>
								</span>
							</div>

							<div class="restaurant-name">
								${review.restaurantName}
							</div>

							<div class="review-text">
								${review.content}
							</div>

							<div class="meta">
								${review.memberName} · ${review.createdAt}
							</div>

							<div class="card-actions">
								<a class="card-btn detail-btn"
								   href="${contextPath}/review/one?reviewId=${review.reviewId}">
									리뷰 보기
								</a>
							</div>
						</div>

					</div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>

	<c:if test="${totalPage > 1}">
		<div class="pagination">

			<c:if test="${startPage > 1}">
				<a href="${contextPath}/review?page=${startPage - 1}&size=${size}&regionKeyword=${regionKeyword}&foodKeyword=${foodKeyword}">
					이전
				</a>
			</c:if>

			<c:forEach begin="${startPage}" end="${endPage}" var="num">
				<a href="${contextPath}/review?page=${num}&size=${size}&regionKeyword=${regionKeyword}&foodKeyword=${foodKeyword}"
				   class="${currentPage == num ? 'active' : ''}">
					${num}
				</a>
			</c:forEach>

			<c:if test="${endPage < totalPage}">
				<a href="${contextPath}/review?page=${endPage + 1}&size=${size}&regionKeyword=${regionKeyword}&foodKeyword=${foodKeyword}">
					다음
				</a>
			</c:if>

		</div>
	</c:if>

	<section class="guide-box">
		<div>
			<h2>리뷰는 맛집 상세 페이지에서도 작성할 수 있어요</h2>
			<p>
				관심 있는 맛집을 찾은 뒤,
				상세 페이지에서 지도와 정보도 함께 확인해보세요.
			</p>
		</div>

		<a class="btn primary"
		   href="${contextPath}/restaurants">
			맛집 선택하기
		</a>
	</section>

</main>

<%@ include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>