<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PickEat - 맛집 리스트</title>

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
	letter-spacing: -1px;
	color: #111827;
}

.logo-icon {
	position: relative;
	width: 22px;
	height: 28px;
	background: #ff6500;
	border-radius: 50% 50% 50% 0;
	transform: rotate(-45deg);
}

.logo-icon::before {
	content: "";
	position: absolute;
	width: 8px;
	height: 8px;
	background: white;
	border-radius: 50%;
	top: 8px;
	left: 7px;
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

.search-form {
	display: flex;
	gap: 8px;
	align-items: center;
}

.search-box {
	width: 150px;
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 0 15px;
}

.search-btn {
	height: 40px;
	border: none;
	border-radius: 10px;
	background: #ff6500;
	color: white;
	font-weight: 900;
	padding: 0 16px;
	cursor: pointer;
}

.container {
	padding: 40px;
}

.title {
	font-size: 28px;
	font-weight: 900;
	margin-bottom: 20px;
}

.content {
	display: grid;
	grid-template-columns: 1.1fr 1fr;
	gap: 24px;
	align-items: start;
}

.list {
	background: #fff;
	border-radius: 16px;
	padding: 20px;
	min-height: 700px;
}

.card {
	display: flex;
	gap: 15px;
	border-bottom: 1px solid #eee;
	padding: 15px 0;
	border: 2px solid transparent;
	border-radius: 14px;
	transition: all 0.25s ease;
}

.card.active {
	border: 2px solid #ff6500;
	background: #fff7f0;
	box-shadow: 0 8px 20px rgba(255, 101, 0, 0.12);
	transform: translateY(-2px);
}

.card img {
	width: 120px;
	height: 90px;
	border-radius: 12px;
	object-fit: cover;
}

.info h3 {
	margin: 0;
}

.rating {
	color: #ff9500;
	font-weight: 800;
}

.category-text {
	max-width: 260px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	color: #6b7280;
	font-weight: 700;
	margin-top: 4px;
}

.map {
	background: #ddd;
	border-radius: 16px;
	height: 100%;
	min-height: 700px;
	position: sticky;
	top: 40px;
}

.map-card {
	position: relative;
	width: 230px;
	background: white;
	border-radius: 16px;
	padding: 14px 16px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.18);
	border: 1px solid #eee;
}

.map-card-title {
	font-size: 15px;
	font-weight: 900;
	color: #111827;
	margin-bottom: 6px;
	line-height: 1.35;
}

.map-card-category {
	font-size: 13px;
	color: #6b7280;
	margin-bottom: 6px;
	max-width: 190px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.map-card-rating {
	color: #ff6500;
	font-weight: 800;
	font-size: 13px;
	margin-bottom: 10px;
}

.map-card-link {
	display: inline-block;
	background: #ff6500;
	color: white;
	padding: 6px 10px;
	border-radius: 8px;
	font-size: 12px;
	font-weight: 800;
	text-decoration: none;
}

.map-card-close {
	position: absolute;
	top: 8px;
	right: 10px;
	border: none;
	background: none;
	font-size: 16px;
	font-weight: 900;
	cursor: pointer;
	color: #9ca3af;
}

.btn {
	background: #ff6500;
	color: white;
	padding: 6px 12px;
	border-radius: 8px;
	text-decoration: none;
	font-size: 14px;
	display: inline-block;
	margin-top: 8px;
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
	border: 1px solid #e5e7eb;
	background: white;
	color: #374151;
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 700;
	transition: all 0.2s ease;
}

.page-num:hover, .page-btn:hover {
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

.empty-message {
	height: 650px;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	color: #9ca3af;
	font-size: 20px;
	font-weight: 700;
	text-align: center;
	line-height: 1.8;
}

.dp-flex {
	display: flex;
	justify-content: space-between;
	align-items: center;
}
</style>
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>
	<%-- jsp:include page="/WEB-INF/views/header.jsp"/>--%>


	<main class="container">

		<div class="title dp-flex">
			맛집 리스트 (${totalCount})
			<form class="search-form" action="${contextPath}/restaurants"
				method="get">
				<input class="search-box" type="text" name="regionKeyword"
					value="${regionKeyword}" placeholder="지역 예: 경남대"> <input
					class="search-box" type="text" name="foodKeyword"
					value="${foodKeyword}" placeholder="음식 예: 피자">

				<button class="search-btn" type="submit">검색</button>
			</form>
		</div>

		<div class="content">

			<div class="list">

				<c:if test="${empty regionKeyword and empty foodKeyword}">
					<div class="empty-message">
						🔍 지역과 음식을 검색해보세요<br> 예: 지역 = 경남대 / 음식 = 피자
					</div>
				</c:if>

				<c:forEach var="r" items="${restaurantList}">
					<div class="card" id="restaurant-${r.restaurantId}"
						onclick="moveToRestaurant('${r.restaurantId}')">

						<c:choose>
							<c:when test="${fn:contains(r.categoryName, '한식')}">
								<img src="${contextPath}/resources/images/category/korean.jpg" />
							</c:when>

							<c:when
								test="${fn:contains(r.categoryName, '양식') or fn:contains(r.categoryName, '샐러드')}">
								<img src="${contextPath}/resources/images/category/western.jpg" />
							</c:when>

							<c:when test="${fn:contains(r.categoryName, '중식')}">
								<img src="${contextPath}/resources/images/category/chinese.jpg" />
							</c:when>

							<c:when test="${fn:contains(r.categoryName, '일식')}">
								<img src="${contextPath}/resources/images/category/japanese.jpg" />
							</c:when>

							<c:when test="${fn:contains(r.categoryName, '치킨')}">
								<img src="${contextPath}/resources/images/category/chicken.jpg" />
							</c:when>

							<c:when
								test="${fn:contains(r.categoryName, '카페') or fn:contains(r.categoryName, '디저트') or fn:contains(r.categoryName, '커피')}">
								<img src="${contextPath}/resources/images/category/cafe.jpg" />
							</c:when>

							<c:when test="${fn:contains(r.categoryName, '분식')}">
								<img
									src="${contextPath}/resources/images/category/snack_food.jpg" />
							</c:when>

							<c:when
								test="${fn:contains(r.categoryName, '술집') or fn:contains(r.categoryName, '호프') or fn:contains(r.categoryName, '주점') or fn:contains(r.categoryName, '이자카야')}">
								<img src="${contextPath}/resources/images/category/bar.jpg" />
							</c:when>

							<c:otherwise>
								<img src="${contextPath}/resources/images/category/etc_food.png">
							</c:otherwise>
						</c:choose>

						<div class="info">
							<h3>${r.name}</h3>

							<div class="rating">★ ${r.rating}</div>

							<div class="category-text" title="${r.categoryName}">
								${r.categoryName}</div>

							<a class="btn"
								href="${contextPath}/restaurants/${r.restaurantId}"> 상세보기 </a>
						</div>

					</div>
				</c:forEach>

				<div class="pagination-wrap">

					<c:if test="${startPage > 1}">
						<a class="page-btn"
							href="${contextPath}/restaurants?page=${startPage - pageLimit}&regionKeyword=${regionKeyword}&foodKeyword=${foodKeyword}">
							‹ 이전 </a>
					</c:if>

					<c:forEach var="i" begin="${startPage}" end="${endPage}">
						<c:choose>
							<c:when test="${i == currentPage}">
								<span class="page-num active"> ${i} </span>
							</c:when>

							<c:otherwise>
								<a class="page-num"
									href="${contextPath}/restaurants?page=${i}&regionKeyword=${regionKeyword}&foodKeyword=${foodKeyword}">
									${i} </a>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<c:if test="${endPage < totalPage}">
						<a class="page-btn"
							href="${contextPath}/restaurants?page=${endPage + 1}&regionKeyword=${regionKeyword}&foodKeyword=${foodKeyword}">
							다음 › </a>
					</c:if>

				</div>

			</div>

			<div id="map" class="map"></div>

		</div>

	</main>

	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a87f90deda3136d9524a194c121dcf1"></script>

	<script>
	var mapContainer = document.getElementById('map');

	var mapOption = {
		center: new kakao.maps.LatLng(37.5665, 126.9780),
		level: 5
	};

	var map = new kakao.maps.Map(mapContainer, mapOption);

	var bounds = new kakao.maps.LatLngBounds();

	var overlay = null;

	var markerMap = {};
	var positionMap = {};
	var overlayContentMap = {};

	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			var lat = position.coords.latitude;
			var lng = position.coords.longitude;

			var moveLatLon = new kakao.maps.LatLng(lat, lng);

			var currentMarker = new kakao.maps.Marker({
				position: moveLatLon
			});

			currentMarker.setMap(map);
			bounds.extend(moveLatLon);
		});
	}

	<c:forEach var="r" items="${mapList}" varStatus="status">
		<c:if test="${not empty r.latitude and not empty r.longitude}">

			var markerPosition${status.index} =
				new kakao.maps.LatLng(${r.latitude}, ${r.longitude});

			var marker${status.index} = new kakao.maps.Marker({
				position: markerPosition${status.index},
				map: map
			});

			bounds.extend(markerPosition${status.index});

			var overlayContent${status.index} = `
				<div class="map-card">
					<button class="map-card-close" onclick="closeOverlay()">×</button>

					<div class="map-card-title">
						${r.name}
					</div>

					<div class="map-card-category" title="${r.categoryName}">
						${r.categoryName}
					</div>

					<div class="map-card-rating">
						★ ${r.rating}
					</div>

					<a class="map-card-link"
					   href="${contextPath}/restaurants/${r.restaurantId}">
						상세보기
					</a>
				</div>
			`;

			markerMap['${r.restaurantId}'] = marker${status.index};
			positionMap['${r.restaurantId}'] = markerPosition${status.index};
			overlayContentMap['${r.restaurantId}'] = overlayContent${status.index};

			kakao.maps.event.addListener(marker${status.index}, 'click', function() {
				if (overlay != null) {
					overlay.setMap(null);
				}

				overlay = new kakao.maps.CustomOverlay({
					content: overlayContent${status.index},
					position: markerPosition${status.index},
					yAnchor: 1.2
				});

				overlay.setMap(map);
				map.panTo(markerPosition${status.index});
				focusRestaurantCard('${r.restaurantId}');
			});

		</c:if>
	</c:forEach>

	<c:if test="${not empty mapList}">
		map.setBounds(bounds);
	</c:if>

	function closeOverlay() {
		if (overlay != null) {
			overlay.setMap(null);
		}
	}

	function focusRestaurantCard(restaurantId) {
		var cards = document.querySelectorAll('.card');

		cards.forEach(function(card) {
			card.classList.remove('active');
		});

		var targetCard = document.getElementById('restaurant-' + restaurantId);

		if (targetCard) {
			targetCard.classList.add('active');

			targetCard.scrollIntoView({
				behavior: 'smooth',
				block: 'center'
			});
		}
	}

	function moveToRestaurant(restaurantId) {
		var marker = markerMap[restaurantId];
		var position = positionMap[restaurantId];
		var content = overlayContentMap[restaurantId];

		if (!marker || !position || !content) {
			return;
		}

		if (overlay != null) {
			overlay.setMap(null);
		}

		overlay = new kakao.maps.CustomOverlay({
			content: content,
			position: position,
			yAnchor: 1.2
		});

		overlay.setMap(map);
		map.panTo(position);
		focusRestaurantCard(restaurantId);
	}
</script>
<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>