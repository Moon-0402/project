<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat - 리뷰 목록</title>

<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Pretendard', 'Noto Sans KR', Arial, sans-serif;
	min-height: 100vh;
	background: linear-gradient(135deg, #fff7ed 0%, #fff1e6 45%, #fef3c7 100%);
	color: #2f241d;
}

.container {
	max-width: 1100px;
	margin: 0 auto;
	padding: 50px 24px;
}

.back-link {
	display: inline-block;
	margin-bottom: 20px;
	color: #ff6500;
	font-weight: 900;
	text-decoration: none;
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	gap: 20px;
	margin-bottom: 28px;
}

.page-title h1 {
	font-size: 34px;
	color: #2f241d;
	margin-bottom: 8px;
}

.page-title p {
	color: #7a6a5d;
	font-size: 15px;
	line-height: 1.6;
}

.review-badge {
	display: inline-block;
	background: rgba(255, 255, 255, 0.78);
	border: 1px solid rgba(255, 184, 107, 0.45);
	color: #a15c22;
	padding: 10px 16px;
	border-radius: 999px;
	font-size: 13px;
	font-weight: 900;
	white-space: nowrap;
}

.summary-card {
	position: relative;
	overflow: hidden;
	background: rgba(255, 255, 255, 0.86);
	border: 1px solid rgba(255, 184, 107, 0.35);
	border-radius: 28px;
	box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
	padding: 30px 32px;
	margin-bottom: 24px;
}

.summary-card::after {
	content: "💬";
	position: absolute;
	right: 32px;
	bottom: 14px;
	font-size: 86px;
	opacity: 0.11;
}

.summary-title {
	font-size: 25px;
	font-weight: 900;
	color: #2f241d;
	margin-bottom: 10px;
}

.summary-text {
	color: #7a6a5d;
	line-height: 1.7;
	font-size: 15px;
	max-width: 760px;
}

.action-area {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 24px;
}

.write-btn {
	height: 48px;
	padding: 0 22px;
	border-radius: 15px;
	background: #ff914d;
	color: #fff;
	font-size: 14px;
	font-weight: 900;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	box-shadow: 0 8px 20px rgba(255, 145, 77, 0.32);
	transition: 0.2s;
}

.write-btn:hover {
	background: #f97316;
	transform: translateY(-1px);
}

.content-card {
	background: rgba(255, 255, 255, 0.86);
	border: 1px solid rgba(255, 184, 107, 0.35);
	border-radius: 28px;
	box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
	padding: 28px;
}

.review-card {
	background: #fffaf3;
	border: 1px solid #f4d7b7;
	border-radius: 22px;
	padding: 22px;
	margin-bottom: 16px;
}

.review-card:last-child {
	margin-bottom: 0;
}

.review-head {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	gap: 18px;
	margin-bottom: 14px;
}

.review-info h3 {
	font-size: 20px;
	font-weight: 900;
	color: #2f241d;
	margin-bottom: 6px;
}

.review-meta {
	color: #7a6a5d;
	font-size: 13px;
	font-weight: 800;
}

.rating {
	color: #f97316;
	font-weight: 900;
	font-size: 18px;
	white-space: nowrap;
}

.review-content {
	color: #3f3026;
	line-height: 1.8;
	font-size: 15px;
	font-weight: 700;
	margin-bottom: 14px;
	white-space: pre-wrap;
}

.review-image {
	margin-top: 12px;
}

.review-image img {
	width: 180px;
	height: 120px;
	object-fit: cover;
	border-radius: 16px;
	border: 1px solid #f4d7b7;
}

.review-actions {
	display: flex;
	gap: 8px;
	margin-top: 14px;
}

.action-btn {
	height: 38px;
	padding: 0 15px;
	border-radius: 13px;
	font-weight: 900;
	font-size: 13px;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	transition: 0.2s;
}

.edit-btn {
	background: #fff3df;
	color: #b45309;
	border: 1px solid #f4d7b7;
}

.edit-btn:hover {
	background: #fed7aa;
}

.empty {
	padding: 70px 20px;
	text-align: center;
	color: #7a6a5d;
	background: #fffaf3;
	border: 1px dashed #f4c999;
	border-radius: 22px;
	font-weight: 800;
}

.empty strong {
	color: #f97316;
}

.pagination-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	margin-top: 35px;
	flex-wrap: wrap;
}

.page-num, .page-btn {
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

.page-num.active {
	background: #ff914d;
	color: white;
	border-color: #ff914d;
}

@media ( max-width : 900px) {
	.container {
		padding: 32px 20px;
	}
	.top-bar {
		display: block;
	}
	.review-badge {
		margin-top: 16px;
	}
	.review-head {
		display: block;
	}
	.rating {
		margin-top: 8px;
	}
	.action-area {
		justify-content: stretch;
	}
	.write-btn {
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
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<main class="container">

		<a class="back-link" href="${contextPath}/restaurants/${restaurantId}">
			← 맛집 상세로 돌아가기 </a>

		<div class="top-bar">
			<div class="page-title">
				<h1>리뷰 목록</h1>
				<p>이 맛집에 대한 사용자들의 솔직한 후기를 확인해보세요.</p>
			</div>

			<div class="review-badge">REVIEW MODE</div>
		</div>

		<section class="summary-card">
			<div class="summary-title">
				<c:choose>
					<c:when test="${not empty restaurantName}">
						${restaurantName}
					</c:when>

					<c:otherwise>
						맛집 리뷰
					</c:otherwise>
				</c:choose>
			</div>

			<p class="summary-text">별점과 리뷰 내용을 확인하고, 직접 방문 후기를 남길 수 있습니다. 좋은
				리뷰는 다른 사용자의 맛집 선택에 도움이 됩니다.</p>
		</section>

		<div class="action-area">
			<a class="write-btn"
				href="${contextPath}/review/write?restaurantId=${restaurantId}">
				+ 리뷰 작성하기 </a>
		</div>

		<section class="content-card">

			<c:choose>
				<c:when test="${empty reviewList}">
					<div class="empty">
						아직 등록된 리뷰가 없습니다.<br> <strong>첫 리뷰를 작성해보세요!</strong>
					</div>
				</c:when>

				<c:otherwise>
					<c:forEach var="review" items="${reviewList}">
						<div class="review-card">

							<div class="review-head">
								<div class="review-info">
									<h3>${review.memberName}</h3>
									<div class="review-meta">${review.createdAt}</div>
								</div>

								<div class="rating">

									<c:forEach begin="1" end="${review.rating}">
										★
									</c:forEach>

								</div>
							</div>

							<div class="review-content">${review.content}</div>

							<c:if test="${not empty review.image}">
								<div class="review-image">
									<img src="${contextPath}${review.image}" alt="리뷰 이미지">
								</div>
							</c:if>

							<c:if test="${loginMember.memberId == review.memberId}">
								<div class="review-actions">
									<a class="action-btn edit-btn"
										href="${contextPath}/review/update?reviewId=${review.reviewId}">
										수정 </a>
								</div>
							</c:if>

						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>

		</section>
		<c:if test="${totalPage > 1}">
			<div class="pagination-wrap">

				<c:if test="${startPage > 1}">
					<a class="page-btn"
						href="${contextPath}/review/list?restaurantId=${restaurantId}&page=${startPage - pageLimit}&size=${size}">
						‹ 이전 </a>
				</c:if>

				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:choose>
						<c:when test="${i == currentPage}">
							<span class="page-num active">${i}</span>
						</c:when>
						<c:otherwise>
							<a class="page-num"
								href="${contextPath}/review/list?restaurantId=${restaurantId}&page=${i}&size=${size}">
								${i} </a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${endPage < totalPage}">
					<a class="page-btn"
						href="${contextPath}/review/list?restaurantId=${restaurantId}&page=${endPage + 1}&size=${size}">
						다음 › </a>
				</c:if>

			</div>
		</c:if>

	</main>

	<%@ include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>