<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>픽잇 - 맛집 상세</title>

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

.header {
	height: 70px;
	background: rgba(255, 255, 255, 0.92);
	border-bottom: 1px solid #eee;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 42px;
	position: sticky;
	top: 0;
	z-index: 10;
}

.logo {
	display: flex;
	align-items: center;
	gap: 8px;
	font-size: 28px;
	font-weight: 900;
}

.logo-icon {
	width: 22px;
	height: 28px;
	background: #ff6500;
	border-radius: 50% 50% 50% 0;
	transform: rotate(-45deg);
	position: relative;
}

.logo-icon::before {
	content: "";
	width: 8px;
	height: 8px;
	background: white;
	border-radius: 50%;
	position: absolute;
	top: 8px;
	left: 7px;
}

.nav {
	display: flex;
	gap: 40px;
	font-weight: 800;
}

.nav a.active {
	color: #ff6500;
}

.container {
	max-width: 1180px;
	margin: 0 auto;
	padding: 52px 24px;
}

.back {
	display: inline-block;
	margin-bottom: 22px;
	color: #ff6500;
	font-weight: 900;
}

.detail-card {
	background: rgba(255, 255, 255, 0.92);
	border-radius: 30px;
	box-shadow: 0 24px 70px rgba(255, 112, 0, 0.14);
	overflow: hidden;
	display: grid;
	grid-template-columns: 1fr 1fr;
}

.image-area {
	min-height: 480px;
	background: #f3f4f6;
}

.image-area img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.kakao {
	background: #fee500;
	color: #191919;
}

.info-area {
	padding: 48px;
}

.badge {
	display: inline-block;
	padding: 9px 15px;
	border-radius: 999px;
	background: #fff3e8;
	color: #ff6500;
	font-weight: 900;
	margin-bottom: 18px;
}

.title {
	font-size: 42px;
	font-weight: 900;
	margin: 0 0 16px;
	letter-spacing: -1px;
}

.rating {
	font-size: 20px;
	color: #ff9500;
	font-weight: 900;
	margin-bottom: 28px;
}

.desc {
	color: #6b7280;
	line-height: 1.8;
	font-size: 17px;
	margin-bottom: 30px;
}

.info-list {
	display: grid;
	gap: 14px;
	margin-bottom: 34px;
}

.info-row {
	background: #fff;
	border: 1px solid #eee;
	border-radius: 16px;
	padding: 16px 18px;
	color: #374151;
	font-weight: 700;
}

.actions {
	display: flex;
	flex-wrap: wrap;
	gap: 12px;
	margin-top: 8px;
}

.btn {
	border: none;
	border-radius: 16px;
	padding: 15px 22px;
	font-weight: 900;
	cursor: pointer;
	font-size: 15px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 7px;
	transition: 0.2s ease;
	box-shadow: 0 10px 24px rgba(0, 0, 0, 0.08);
}

.btn:hover {
	transform: translateY(-2px);
}

.primary {
	background: #ff6500;
	color: #fff;
}

.secondary {
	background: #111827;
	color: #fff;
}

.map-box {
	margin-top: 34px;
	background: #fff;
	border-radius: 28px;
	padding: 24px;
	box-shadow: 0 18px 45px rgba(0, 0, 0, 0.08);
}

.map-title {
	font-size: 24px;
	font-weight: 900;
	margin-bottom: 18px;
}

#map {
	width: 100%;
	height: 360px;
	border-radius: 20px;
}

@media ( max-width : 900px) {
	.detail-card {
		grid-template-columns: 1fr;
	}
	.nav {
		display: none;
	}
}
</style>
</head>

<body>

	<%@ include file = "/WEB-INF/views/header.jsp" %>

<main class="container">

	<a href="${contextPath}/restaurants" class="back">← 맛집 리스트로 돌아가기</a>

	<section class="detail-card">

		<div class="image-area">

			<c:choose>
				<c:when test="${restaurant.categoryId == 1 or fn:contains(restaurant.kakaoCategoryName, '한식')}">
					<img src="${contextPath}/resources/images/category/korean.jpg" alt="${restaurant.name}">
				</c:when>

				<c:when test="${restaurant.categoryId == 2 or fn:contains(restaurant.kakaoCategoryName, '중식')}">
					<img src="${contextPath}/resources/images/category/chinese.jpg" alt="${restaurant.name}">
				</c:when>

				<c:when test="${restaurant.categoryId == 3 or fn:contains(restaurant.kakaoCategoryName, '일식')}">
					<img src="${contextPath}/resources/images/category/japanese.jpg" alt="${restaurant.name}">
				</c:when>

				<c:when test="${restaurant.categoryId == 4 or fn:contains(restaurant.kakaoCategoryName, '양식') or fn:contains(restaurant.kakaoCategoryName, '샐러드')}">
					<img src="${contextPath}/resources/images/category/western.jpg" alt="${restaurant.name}">
				</c:when>

				<c:when test="${restaurant.categoryId == 5 or fn:contains(restaurant.kakaoCategoryName, '치킨')}">
					<img src="${contextPath}/resources/images/category/chicken.jpg" alt="${restaurant.name}">
				</c:when>

				<c:when test="${restaurant.categoryId == 6 or fn:contains(restaurant.kakaoCategoryName, '분식')}">
					<img src="${contextPath}/resources/images/category/snack_food.jpg" alt="${restaurant.name}">
				</c:when>

				<c:when test="${restaurant.categoryId == 7 or fn:contains(restaurant.kakaoCategoryName, '카페') or fn:contains(restaurant.kakaoCategoryName, '디저트') or fn:contains(restaurant.kakaoCategoryName, '커피')}">
					<img src="${contextPath}/resources/images/category/cafe.jpg" alt="${restaurant.name}">
				</c:when>

				<c:when test="${restaurant.categoryId == 8 or fn:contains(restaurant.kakaoCategoryName, '술집') or fn:contains(restaurant.kakaoCategoryName, '호프') or fn:contains(restaurant.kakaoCategoryName, '주점') or fn:contains(restaurant.kakaoCategoryName, '이자카야')}">
					<img src="${contextPath}/resources/images/category/bar.jpg" alt="${restaurant.name}">
				</c:when>

				<c:otherwise>
					<img src="${contextPath}/resources/images/category/etc_food.png">
				</c:otherwise>
			</c:choose>

		</div>

		<div class="info-area">

			<div class="badge">맛집 정보</div>

			<h1 class="title">${restaurant.name}</h1>

			<div class="rating">★ 0.0</div>

			<div class="desc">${restaurant.description}</div>

			<div class="info-list">

				<c:if test="${not empty restaurant.kakaoCategoryName}">
					<div class="info-row">🏷 카테고리 : ${restaurant.kakaoCategoryName}</div>
				</c:if>

				<div class="info-row">📍 주소 : ${restaurant.address}</div>

				<div class="info-row">☎ 전화번호 : ${restaurant.phone}</div>

				<div class="info-row">💰 가격대 : ${restaurant.priceRange}</div>

			</div>

			<div class="actions">

				<a class="btn primary" href="${contextPath}/recommend">추천 받기</a>

				<c:if test="${not empty restaurant.placeUrl}">
					<a class="btn kakao" href="${restaurant.placeUrl}" target="_blank">
						카카오맵 상세정보
					</a>
				</c:if>

				<c:if test="${empty restaurant.placeUrl}">
					<a class="btn kakao"
					   href="https://map.kakao.com/link/search/${restaurant.name} ${restaurant.address}"
					   target="_blank">
						카카오맵 검색
					</a>
				</c:if>

				<form action="${contextPath}/bookmark/add" method="post" style="margin: 0;" onsubmit="alert('즐겨찾기에 추가되었습니다.');">
				
					<input type="hidden" name="restaurantId" value="${restaurant.restaurantId}">

					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

					<button type="submit" class="btn secondary">♡ 즐겨찾기</button>

				</form>

			</div>

		</div>

	</section>

	<c:if test="${not empty restaurant.latitude and not empty restaurant.longitude}">

		<section class="map-box">
			<div class="map-title">위치 보기</div>
			<div id="map"></div>
		</section>

		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a87f90deda3136d9524a194c121dcf1"></script>

		<script>
			var lat = ${restaurant.latitude};
			var lng = ${restaurant.longitude};
			var restaurantName = "${restaurant.name}";

			var mapContainer = document.getElementById('map');

			var mapOption = {
				center: new kakao.maps.LatLng(lat, lng),
				level: 4
			};

			var map = new kakao.maps.Map(mapContainer, mapOption);

			var markerPosition = new kakao.maps.LatLng(lat, lng);

			var marker = new kakao.maps.Marker({
				position: markerPosition
			});

			marker.setMap(map);

			var infowindow = new kakao.maps.InfoWindow({
				content: '<div style="padding:8px 12px;font-weight:800;">' + restaurantName + '</div>'
			});

			infowindow.open(map, marker);
		</script>

	</c:if>

</main>
	<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>