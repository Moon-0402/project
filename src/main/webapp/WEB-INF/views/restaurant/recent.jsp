<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PickEat - 최근 본 맛집</title>

<style>
* {
	box-sizing: border-box;
	font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
}

body {
	margin: 0;
	background: #f9fafb;
	color: #111827;
}

.container {
	padding: 40px;
}

.title {
	font-size: 28px;
	font-weight: 900;
	margin-bottom: 8px;
}

.desc {
	color: #6b7280;
	font-weight: 700;
	margin-bottom: 20px;
}

.list {
	background: #fff;
	border-radius: 16px;
	padding: 20px;
}

.card {
	display: flex;
	gap: 18px;
	border-bottom: 1px solid #eee;
	padding: 18px 0;
}

.card:last-child {
	border-bottom: none;
}

.image-area {
	width: 140px;
	height: 105px;
	flex-shrink: 0;
}

.image-area img {
	width: 140px;
	height: 105px;
	border-radius: 14px;
	object-fit: cover;
	background: #f3f4f6;
}

.info {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.info h3 {
	margin: 0 0 6px 0;
	font-size: 20px;
	font-weight: 900;
}

.rating {
	color: #ff9500;
	font-weight: 800;
	margin-bottom: 4px;
}

.category-text {
	max-width: 420px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	color: #6b7280;
	font-weight: 700;
	margin-bottom: 8px;
}

.btn {
	width: fit-content;
	background: #ff6500;
	color: white;
	padding: 7px 13px;
	border-radius: 8px;
	text-decoration: none;
	font-size: 14px;
	font-weight: 800;
}

.empty {
	padding: 30px;
	text-align: center;
	color: #6b7280;
	font-weight: 800;
}

.pagination-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	margin-top: 30px;
	flex-wrap: wrap;
}

.page-num,
.page-btn {
	min-width: 40px;
	height: 40px;
	padding: 0 14px;
	border-radius: 12px;
	border: 1px solid #e5e7eb;
	background: white;
	color: #374151;
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 800;
	transition: all 0.2s ease;
}

.page-num:hover,
.page-btn:hover {
	background: #fff3e8;
	color: #ff6500;
	border-color: #ffb37a;
	transform: translateY(-2px);
}

.page-num.active {
	background: #ff6500;
	color: white;
	border-color: #ff6500;
	box-shadow: 0 4px 12px rgba(255, 101, 0, 0.25);
}
</style>
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<main class="container">

		<div class="title">
			최근 본 맛집 (${totalCount})
		</div>

		<div class="desc">
			최근 1개월 안에 본 맛집만 표시됩니다.
		</div>

		<div class="list">

			<c:if test="${empty recentList}">
				<div class="empty">
					최근 본 맛집이 없습니다.
				</div>
			</c:if>

			<c:forEach var="restaurant" items="${recentList}">

				<div class="card">

					<div class="image-area">

						<c:choose>

							<c:when test="${fn:contains(restaurant.categoryName, '한식')}">
								<img src="${contextPath}/resources/images/category/korean.jpg"
									alt="${restaurant.name}">
							</c:when>

							<c:when test="${fn:contains(restaurant.categoryName, '중식')}">
								<img src="${contextPath}/resources/images/category/chinese.jpg"
									alt="${restaurant.name}">
							</c:when>

							<c:when test="${fn:contains(restaurant.categoryName, '일식')}">
								<img src="${contextPath}/resources/images/category/japanese.jpg"
									alt="${restaurant.name}">
							</c:when>

							<c:when test="${fn:contains(restaurant.categoryName, '양식') 
								or fn:contains(restaurant.categoryName, '샐러드')}">
								<img src="${contextPath}/resources/images/category/western.jpg"
									alt="${restaurant.name}">
							</c:when>

							<c:when test="${fn:contains(restaurant.categoryName, '치킨')}">
								<img src="${contextPath}/resources/images/category/chicken.jpg"
									alt="${restaurant.name}">
							</c:when>

							<c:when test="${fn:contains(restaurant.categoryName, '분식')}">
								<img src="${contextPath}/resources/images/category/snack_food.jpg"
									alt="${restaurant.name}">
							</c:when>

							<c:when test="${fn:contains(restaurant.categoryName, '카페') 
								or fn:contains(restaurant.categoryName, '디저트')
								or fn:contains(restaurant.categoryName, '커피')}">
								<img src="${contextPath}/resources/images/category/cafe.jpg"
									alt="${restaurant.name}">
							</c:when>

							<c:when test="${fn:contains(restaurant.categoryName, '술집')
								or fn:contains(restaurant.categoryName, '호프')
								or fn:contains(restaurant.categoryName, '주점')
								or fn:contains(restaurant.categoryName, '이자카야')}">
								<img src="${contextPath}/resources/images/category/bar.jpg"
									alt="${restaurant.name}">
							</c:when>

							<c:otherwise>
								<img src="${contextPath}/resources/images/category/etc_food.png">
							</c:otherwise>

						</c:choose>

					</div>

					<div class="info">

						<h3>${restaurant.name}</h3>

						<div class="rating">
							★ ${restaurant.rating}
						</div>

						<div class="category-text"
							title="${restaurant.categoryName}">
							${restaurant.categoryName}
						</div>

						<a class="btn"
							href="${contextPath}/restaurants/${restaurant.restaurantId}">
							다시 보기
						</a>

					</div>

				</div>

			</c:forEach>

		</div>

		<c:if test="${totalPage > 1}">
			<div class="pagination-wrap">

				<c:if test="${startPage > 1}">
					<a class="page-btn"
						href="${contextPath}/restaurants/recent?page=${startPage - pageLimit}">
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
								href="${contextPath}/restaurants/recent?page=${i}">
								${i}
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${endPage < totalPage}">
					<a class="page-btn"
						href="${contextPath}/restaurants/recent?page=${endPage + 1}">
						다음 ›
					</a>
				</c:if>

			</div>
		</c:if>

	</main>

	<%@ include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>