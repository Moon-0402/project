<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat - 내가 쓴 리뷰</title>

<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
	background: linear-gradient(135deg, #fff7ed 0%, #fff1e6 45%, #fef3c7 100%);
	min-height: 100vh;
	color: #2f241d;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 50px 24px;
}

.top-section {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
	gap: 20px;
}

.page-title h1 {
	font-size: 38px;
	font-weight: 900;
	margin-bottom: 10px;
}

.page-title p {
	color: #7a6a5d;
	font-size: 15px;
	line-height: 1.7;
}

.review-count {
	background: rgba(255,255,255,0.8);
	border: 1px solid rgba(255, 184, 107, 0.4);
	padding: 16px 22px;
	border-radius: 20px;
	font-weight: 900;
	color: #b45309;
	box-shadow: 0 12px 30px rgba(0,0,0,0.05);
}

.review-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 22px;
}

.review-card {
	background: rgba(255,255,255,0.88);
	border: 1px solid rgba(255, 184, 107, 0.35);
	border-radius: 28px;
	overflow: hidden;
	box-shadow: 0 18px 45px rgba(90, 64, 43, 0.12);
	transition: 0.25s ease;
	display: flex;
	flex-direction: column;
}

.review-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 25px 55px rgba(255,145,77,0.18);
}

.review-image {
	width: 100%;
	height: 220px;
	object-fit: cover;
	background: #f3f4f6;
}

.no-image-box {
	width: 100%;
	height: 220px;
	background: #f3f4f6;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #9ca3af;
	font-weight: 900;
	font-size: 15px;
}

.review-body {
	padding: 22px;
	display: flex;
	flex-direction: column;
	flex: 1;
}

.restaurant-name {
	font-size: 22px;
	font-weight: 900;
	margin-bottom: 12px;
	color: #2f241d;
}

.star-area {
	color: #facc15;
	font-size: 22px;
	margin-bottom: 14px;
	letter-spacing: 2px;
	min-height: 28px;
}

.review-content {
	color: #6b7280;
	font-size: 14px;
	line-height: 1.8;
	margin-bottom: 20px;
	flex: 1;
	word-break: break-word;
	white-space: normal;
}

.review-date {
	font-size: 13px;
	color: #9ca3af;
	font-weight: 700;
	margin-bottom: 18px;
}

.btn-group {
	display: flex;
	gap: 10px;
}

.btn {
	flex: 1;
	height: 46px;
	border-radius: 14px;
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 14px;
	font-weight: 900;
	transition: 0.2s;
}

.detail-btn {
	background: #fff3df;
	color: #b45309;
	border: 1px solid #f4d7b7;
}

.detail-btn:hover {
	background: #fed7aa;
}

.edit-btn {
	background: #ff914d;
	color: white;
	border: none;
	box-shadow: 0 8px 20px rgba(255,145,77,0.28);
}

.edit-btn:hover {
	background: #f97316;
}

.empty-box {
	background: rgba(255,255,255,0.9);
	border-radius: 32px;
	padding: 80px 30px;
	text-align: center;
	box-shadow: 0 18px 45px rgba(90,64,43,0.1);
}

.empty-box h2 {
	font-size: 30px;
	margin-bottom: 14px;
	color: #2f241d;
}

.empty-box p {
	color: #7a6a5d;
	margin-bottom: 28px;
	line-height: 1.8;
}

.empty-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 52px;
	padding: 0 28px;
	border-radius: 18px;
	background: #ff914d;
	color: white;
	text-decoration: none;
	font-weight: 900;
	box-shadow: 0 10px 25px rgba(255,145,77,0.28);
}

.empty-btn:hover {
	background: #f97316;
}

.pagination-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	margin-top: 35px;
	flex-wrap: wrap;
}

.page-num,
.page-btn {
	min-width: 40px;
	height: 40px;
	padding: 0 14px;
	border-radius: 12px;
	border: 1px solid #f4d7b7;
	background: white;
	color: #b45309;
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 900;
	transition: all 0.2s ease;
}

.page-num:hover,
.page-btn:hover {
	background: #fff3df;
	color: #ff6500;
	transform: translateY(-2px);
}

.page-num.active {
	background: #ff914d;
	color: white;
	border-color: #ff914d;
}

@media (max-width: 1000px) {
	.review-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media (max-width: 700px) {
	.top-section {
		flex-direction: column;
		align-items: flex-start;
	}

	.review-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<main class="container">

		<div class="top-section">

			<div class="page-title">
				<h1>내가 작성한 리뷰</h1>
				<p>내가 남긴 맛집 리뷰들을 한눈에 확인하고 수정할 수 있습니다.</p>
			</div>

			<div class="review-count">
				총 ${totalCount}개의 리뷰
			</div>

		</div>

		<c:choose>

			<c:when test="${empty reviewList}">

				<div class="empty-box">

					<h2>아직 작성한 리뷰가 없어요</h2>

					<p>
						맛집에 방문하고 첫 리뷰를 남겨보세요.<br>
						다른 사용자들에게 큰 도움이 됩니다.
					</p>

					<a class="empty-btn" href="${contextPath}/restaurants">
						맛집 보러가기
					</a>

				</div>

			</c:when>

			<c:otherwise>

				<div class="review-grid">

					<c:forEach var="review" items="${reviewList}">

						<div class="review-card">

							<c:choose>

								<c:when test="${not empty review.image}">
									<img class="review-image"
										 src="${contextPath}${review.image}"
										 alt="리뷰 이미지">
								</c:when>

								<c:otherwise>
									<%-- 기존 기본 이미지 방식은 파일이 없으면 깨질 수 있어서 주석 처리 --%>
									<%--
									<img class="review-image"
										 src="${contextPath}/resources/images/no-image.png"
										 alt="기본 이미지">
									--%>

									<div class="no-image-box">
										등록된 이미지 없음
									</div>
								</c:otherwise>

							</c:choose>

							<div class="review-body">

								<div class="restaurant-name">
									${review.restaurantName}
								</div>

								<div class="star-area">
									<c:forEach begin="1" end="${review.rating}">
										★
									</c:forEach>
								</div>

								<div class="review-content">
									${review.content}
								</div>

								<div class="review-date">
									작성일 : ${review.createdAt}
								</div>

								<div class="btn-group">

									<a class="btn detail-btn"
									   href="${contextPath}/review/list?restaurantId=${review.restaurantId}">
										리뷰 보기
									</a>

									<a class="btn edit-btn"
									   href="${contextPath}/review/update?reviewId=${review.reviewId}">
										수정하기
									</a>

								</div>

							</div>

						</div>

					</c:forEach>

				</div>

				<c:if test="${totalPage > 1}">
					<div class="pagination-wrap">

						<c:if test="${startPage > 1}">
							<a class="page-btn"
							   href="${contextPath}/mypage/reviews?page=${startPage - pageLimit}&size=${size}">
								‹ 이전
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${i == currentPage}">
									<span class="page-num active">${i}</span>
								</c:when>

								<c:otherwise>
									<a class="page-num"
									   href="${contextPath}/mypage/reviews?page=${i}&size=${size}">
										${i}
									</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${endPage < totalPage}">
							<a class="page-btn"
							   href="${contextPath}/mypage/reviews?page=${endPage + 1}&size=${size}">
								다음 ›
							</a>
						</c:if>

					</div>
				</c:if>

			</c:otherwise>

		</c:choose>

	</main>

	<%@ include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>