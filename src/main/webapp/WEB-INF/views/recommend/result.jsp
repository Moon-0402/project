<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PickEat - 추천 결과</title>

<style>
* {
	box-sizing: border-box;
	font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
}

body {
	margin: 0;
	background: #fff7ed;
	color: #111827;
}

.header {
	height: 70px;
	background: #fff;
	border-bottom: 1px solid #eee;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 40px;
}

.logo {
	display: flex;
	align-items: center;
	gap: 8px;
	text-decoration: none;
}

.logo-text {
	font-size: 26px;
	font-weight: 900;
	color: #111827;
}

.logo-icon {
	width: 22px;
	height: 28px;
	background: #ff6500;
	border-radius: 50% 50% 50% 0;
	transform: rotate(-45deg);
}

.nav {
	display: flex;
	gap: 40px;
}

.nav a {
	text-decoration: none;
	color: #111827;
	font-weight: 800;
}

.nav a.active {
	color: #ff6500;
}

.container {
	padding: 40px;
}

.result-hero {
	background: #fff;
	border-radius: 24px;
	padding: 40px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
	text-align: center;
	margin-bottom: 30px;
}

.result-hero h1 {
	margin: 0;
	font-size: 34px;
}

.food-name {
	margin-top: 18px;
	font-size: 48px;
	color: #ff6500;
	font-weight: 900;
}

.reason-box {
	margin: 25px auto 0;
	max-width: 520px;
	background: #fff7ed;
	border: 1px solid #ffd9b3;
	border-radius: 18px;
	padding: 22px;
	line-height: 1.7;
}

.section-title {
	font-size: 24px;
	font-weight: 900;
	margin: 30px 0 18px;
}

.card-list {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 22px;
}

.card {
	background: #fff;
	border-radius: 18px;
	overflow: hidden;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
}

.card-img {
	height: 190px;
	background: #eee;
}

.card-img img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.card-body {
	padding: 18px;
}

.card-body h3 {
	margin: 0 0 8px;
	font-size: 20px;
}

.rating {
	color: #ff9500;
	font-weight: 900;
	margin-bottom: 8px;
}

.tag {
	display: inline-block;
	background: #f3f4f6;
	border-radius: 999px;
	padding: 6px 10px;
	font-size: 13px;
	margin-right: 5px;
}

.btn-area {
	display: flex;
	gap: 12px;
	justify-content: center;
	margin-top: 30px;
}

.btn {
	display: inline-block;
	padding: 14px 22px;
	border-radius: 14px;
	font-weight: 900;
	text-decoration: none;
}

.btn-main {
	background: #ff6500;
	color: white;
}

.btn-sub {
	background: white;
	color: #111827;
	border: 1px solid #ddd;
}
</style>
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<main class="container">

		<section class="result-hero">
			<h1>오늘의 추천 결과 🎉</h1>

			<div class="food-name">${selectedFood}</div>

			<div class="reason-box">
				<strong>추천 이유</strong><br> 돌림판 결과 선택된 음식은 <strong>${selectedFood}</strong>입니다.<br>
				지금 기분과 후보 입력 결과를 바탕으로 이 음식을 추천했어요!
			</div>

			<div class="btn-area">
				<a class="btn btn-main" href="${contextPath}/restaurants"> 맛집
					리스트 보기 </a>

				<!-- ⭐ 여기 추가 -->
				<a class="btn btn-main" href="${contextPath}/recommend/history">
					추천 기록 보기 </a> <a class="btn btn-sub" href="${contextPath}/recommend">
					다시 추천받기 </a>
			</div>
		</section>

		<div class="section-title">${selectedFood}관련추천맛집</div>

		<p>검색 개수: ${nearRestaurantList.size()}</p>

		<section class="card-list">

			<c:forEach var="r" items="${nearRestaurantList}">
				<div class="card">
					<div class="card-img">
						<c:choose>

							<c:when test="${r.categoryName.contains('한식')}">
								<img src="${contextPath}/resources/images/category/korean.jpg">
							</c:when>

							<c:when test="${r.categoryName.contains('중식')}">
								<img src="${contextPath}/resources/images/category/chinese.jpg">
							</c:when>

							<c:when test="${r.categoryName.contains('일식')}">
								<img src="${contextPath}/resources/images/category/japanese.jpg">
							</c:when>

							<c:when
								test="${r.categoryName.contains('양식') || r.categoryName.contains('샐러드')}">
								<img src="${contextPath}/resources/images/category/western.jpg">
							</c:when>

							<c:when test="${r.categoryName.contains('치킨')}">
								<img src="${contextPath}/resources/images/category/chicken.jpg">
							</c:when>

							<c:when test="${r.categoryName.contains('분식')}">
								<img
									src="${contextPath}/resources/images/category/snack_food.jpg">
							</c:when>

							<c:when
								test="${r.categoryName.contains('카페') || r.categoryName.contains('디저트') || r.categoryName.contains('커피')}">
								<img src="${contextPath}/resources/images/category/cafe.jpg">
							</c:when>

							<c:when
								test="${r.categoryName.contains('술집') || r.categoryName.contains('호프') || r.categoryName.contains('주점') || r.categoryName.contains('이자카야')}">
								<img src="${contextPath}/resources/images/category/bar.jpg">
							</c:when>

							<c:otherwise>
								<img src="${contextPath}/resources/images/category/etc_food.png">
							</c:otherwise>

						</c:choose>
					</div>

					<div class="card-body">
						<h3>${r.name}</h3>
						<div class="rating">★ ${r.rating}</div>
						<span class="tag">근처 맛집</span> <span class="tag">${r.categoryName}</span>
						<span class="tag">${selectedFood}</span>

						<c:if test="${not empty r.distance}">
							<span class="tag">${r.distance} km</span>
						</c:if>
						<br> <br> <a class="btn btn-main"
							href="${contextPath}/restaurants/${r.restaurantId}"> 상세보기 </a>
					</div>
				</div>
			</c:forEach>

		</section>

	</main>
	<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>