<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 관리자 | 맛집 등록/수정</title>

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

.admin-layout {
	display: flex;
	min-height: 100vh;
}

.sidebar {
	width: 250px;
	background: #2f241d;
	color: #fff;
	padding: 30px 24px;
	box-shadow: 8px 0 24px rgba(47, 36, 29, 0.15);
	flex-shrink: 0;
}

.logo-box {
	margin-bottom: 45px;
}

.logo-link {
	display: inline-block;
	text-decoration: none;
}

.logo {
	font-size: 30px;
	font-weight: 900;
	color: #ffb86b;
	letter-spacing: -1px;
	transition: 0.2s;
}

.logo span {
	color: #fff;
}

.logo-link:hover .logo {
	transform: translateY(-1px);
	filter: brightness(1.08);
}

.logo-desc {
	font-size: 13px;
	color: #d6c7b8;
	margin-top: 8px;
	line-height: 1.5;
}

.menu-title {
	font-size: 12px;
	color: #a99584;
	margin-bottom: 12px;
	text-transform: uppercase;
	font-weight: 900;
}

.menu-list {
	list-style: none;
}

.menu-list li {
	margin-bottom: 10px;
}

.menu-list a {
	display: block;
	text-decoration: none;
	color: #eee2d6;
	padding: 13px 15px;
	border-radius: 14px;
	transition: 0.2s;
	font-size: 15px;
	font-weight: 700;
}

.menu-list a:hover, .menu-list a.active {
	background: #ff914d;
	color: #fff;
	box-shadow: 0 8px 18px rgba(255, 145, 77, 0.35);
}

.main {
	flex: 1;
	padding: 38px 48px;
	overflow-x: hidden;
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

.admin-badge {
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
	content: "🍽️";
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
	max-width: 720px;
}

.content-card {
	background: rgba(255, 255, 255, 0.86);
	border: 1px solid rgba(255, 184, 107, 0.35);
	border-radius: 28px;
	box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
	padding: 28px;
}

.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 18px;
}

.form-grid .full {
	grid-column: 1/3;
}

.input-group label {
	display: block;
	margin-bottom: 8px;
	color: #a15c22;
	font-size: 14px;
	font-weight: 900;
}

.input-group input,
.input-group textarea,
.input-group select {
	width: 100%;
	border-radius: 15px;
	border: 1px solid #f4d7b7;
	background: #fffaf3;
	color: #2f241d;
	font-size: 14px;
	font-weight: 700;
	outline: none;
	font-family: inherit;
	padding: 14px 16px;
}

.input-group input::placeholder,
.input-group textarea::placeholder {
	color: #b49376;
}

.input-group input:focus,
.input-group textarea:focus,
.input-group select:focus {
	border-color: #ff914d;
	box-shadow: 0 0 0 4px rgba(255, 145, 77, 0.16);
}

.input-group textarea {
	min-height: 150px;
	resize: vertical;
	line-height: 1.7;
}

.map-box {
	width: 100%;
	height: 320px;
	margin-top: 24px;
	border-radius: 24px;
	overflow: hidden;
	border: 1px solid #f4d7b7;
	background: #fffaf3;
	box-shadow: 0 14px 34px rgba(90, 64, 43, 0.08);
}

.help-text {
	margin-top: 14px;
	color: #7a6a5d;
	font-size: 13px;
	font-weight: 800;
	line-height: 1.6;
}

.btn-area {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 10px;
	margin-top: 24px;
}

.submit-btn,
.back-btn {
	height: 48px;
	padding: 0 20px;
	border-radius: 15px;
	font-size: 14px;
	font-weight: 900;
	font-family: inherit;
	cursor: pointer;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	transition: 0.2s;
}

.submit-btn {
	border: none;
	background: #ff914d;
	color: #fff;
	box-shadow: 0 8px 20px rgba(255, 145, 77, 0.32);
}

.submit-btn:hover {
	background: #f97316;
	transform: translateY(-1px);
}

.back-btn {
	border: 1px solid #f4d7b7;
	background: #fff3df;
	color: #b45309;
}

.back-btn:hover {
	background: #fed7aa;
}

@media ( max-width : 900px) {
	.admin-layout {
		display: block;
	}

	.sidebar {
		width: 100%;
	}

	.main {
		padding: 28px 20px;
	}

	.top-bar {
		display: block;
	}

	.admin-badge {
		margin-top: 16px;
	}

	.content-card {
		padding: 20px;
	}

	.form-grid {
		grid-template-columns: 1fr;
	}

	.form-grid .full {
		grid-column: 1;
	}

	.btn-area {
		flex-direction: column;
		align-items: stretch;
	}

	.submit-btn,
	.back-btn {
		width: 100%;
	}
}
</style>
</head>

<body>

	<div class="admin-layout">

		<aside class="sidebar">
			<div class="logo-box">
				<a href="${contextPath}/" class="logo-link">
					<div class="logo">
						Pick<span>Eat</span>
					</div>
				</a>
				<div class="logo-desc">날씨와 상황에 맞는 맛집 추천 서비스</div>
			</div>

			<div class="menu-title">Admin Menu</div>

			<ul class="menu-list">
				<li><a href="${contextPath}/admin">대시보드</a></li>
				<li><a href="${contextPath}/admin/members">회원 관리</a></li>
				<li><a href="${contextPath}/admin/inquiries">문의 관리</a></li>
				<li><a href="${contextPath}/admin/restaurants" class="active">맛집 관리</a></li>
				<li><a href="${contextPath}/admin/reviewList">리뷰 관리</a></li>
			</ul>
		</aside>

		<main class="main">

			<div class="top-bar">
				<div class="page-title">
					<h1>
						<c:choose>
							<c:when test="${edit}">
								맛집 수정
							</c:when>
							<c:otherwise>
								맛집 등록
							</c:otherwise>
						</c:choose>
					</h1>
					<p>맛집 정보를 입력하고 지도에서 위치를 선택할 수 있습니다.</p>
				</div>

				<div class="admin-badge">RESTAURANT MODE</div>
			</div>

			<section class="summary-card">
				<div class="summary-title">맛집 데이터 입력 센터</div>
				<p class="summary-text">
					맛집 이름, 주소, 카카오 카테고리, 상세 URL, 위치 정보를 등록할 수 있습니다.
					지도에서 원하는 위치를 클릭하면 위도와 경도가 자동으로 입력됩니다.
				</p>
			</section>

			<section class="content-card">

				<form
					action="${contextPath}/admin/restaurants/${empty restaurant.restaurantId ? 'add' : 'update'}"
					method="post">

					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<input type="hidden" name="restaurantId" value="${restaurant.restaurantId}">

					<div class="form-grid">

						<div class="input-group">
							<label>이름</label>
							<input type="text" name="name"
								value="${restaurant.name}"
								placeholder="맛집 이름을 입력하세요"
								required>
						</div>

						<div class="input-group">
							<label>전화번호</label>
							<input type="text" name="phone"
								value="${restaurant.phone}"
								placeholder="전화번호를 입력하세요">
						</div>

						<div class="input-group full">
							<label>주소</label>
							<input type="text" name="address"
								value="${restaurant.address}"
								placeholder="주소를 입력하세요"
								required>
						</div>

						<div class="input-group">
							<label>카카오 카테고리명</label>

							<c:choose>
								<c:when test="${edit}">
									<input type="text" name="kakaoCategoryName"
										value="${restaurant.kakaoCategoryName}"
										placeholder="예: 음식점 > 한식"
										readonly>
								</c:when>

								<c:otherwise>
									<input type="text" name="kakaoCategoryName"
										value="${restaurant.kakaoCategoryName}"
										placeholder="예: 음식점 > 한식">
								</c:otherwise>
							</c:choose>
						</div>

						<div class="input-group">
							<label>가격대</label>
							<input type="text" name="priceRange"
								value="${restaurant.priceRange}"
								placeholder="예: 보통">
						</div>

						<div class="input-group full">
							<label>카카오맵 상세 URL</label>

							<c:choose>
								<c:when test="${edit}">
									<input type="text" name="placeUrl"
										value="${restaurant.placeUrl}"
										placeholder="카카오맵 place_url"
										readonly>
								</c:when>

								<c:otherwise>
									<input type="text" name="placeUrl"
										value="${restaurant.placeUrl}"
										placeholder="카카오맵 place_url">
								</c:otherwise>
							</c:choose>
						</div>

						<div class="input-group">
							<label>영업시간</label>
							<input type="text" name="openingHours"
								value="${restaurant.openingHours}"
								placeholder="예: 매일 10:00 - 22:00">
						</div>

						<div class="input-group">
							<label>상태</label>
							<select name="status" required>
								<option value="ACTIVE"
									${restaurant.status == 'ACTIVE' || empty restaurant.status ? 'selected' : ''}>
									ACTIVE
								</option>
								<option value="INACTIVE"
									${restaurant.status == 'INACTIVE' ? 'selected' : ''}>
									INACTIVE
								</option>
							</select>
						</div>

						<div class="input-group full">
							<label>설명</label>
							<textarea name="description" placeholder="맛집 설명을 입력하세요">${restaurant.description}</textarea>
						</div>

						<div class="input-group">
							<label>위도</label>

							<c:choose>
								<c:when test="${edit}">
									<input type="text" id="lat" name="latitude"
										value="${restaurant.latitude}"
										placeholder="지도를 클릭하면 자동 입력됩니다"
										readonly>
								</c:when>

								<c:otherwise>
									<input type="text" id="lat" name="latitude"
										value="${restaurant.latitude}"
										placeholder="지도를 클릭하면 자동 입력됩니다">
								</c:otherwise>
							</c:choose>
						</div>

						<div class="input-group">
							<label>경도</label>

							<c:choose>
								<c:when test="${edit}">
									<input type="text" id="lng" name="longitude"
										value="${restaurant.longitude}"
										placeholder="지도를 클릭하면 자동 입력됩니다"
										readonly>
								</c:when>

								<c:otherwise>
									<input type="text" id="lng" name="longitude"
										value="${restaurant.longitude}"
										placeholder="지도를 클릭하면 자동 입력됩니다">
								</c:otherwise>
							</c:choose>
						</div>

					</div>

					<div id="map" class="map-box"></div>

					<div class="help-text">지도를 클릭하면 위도와 경도가 자동으로 입력됩니다.</div>

					<div class="btn-area">
						<a class="back-btn" href="${contextPath}/admin/restaurants">목록으로</a>
						<button class="submit-btn" type="submit">저장</button>
					</div>

				</form>

			</section>

		</main>

	</div>

	<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=2a87f90deda3136d9524a194c121dcf1"></script>

	<script>
		var lat = ${restaurant.latitude != null ? restaurant.latitude : 37.5665};
		var lng = ${restaurant.longitude != null ? restaurant.longitude : 126.9780};

		var mapContainer = document.getElementById('map');

		var mapOption = {
			center: new kakao.maps.LatLng(lat, lng),
			level: 3
		};

		var map = new kakao.maps.Map(mapContainer, mapOption);

		var markerPosition = new kakao.maps.LatLng(lat, lng);

		var marker = new kakao.maps.Marker({
			position: markerPosition
		});

		marker.setMap(map);

		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			var latlng = mouseEvent.latLng;

			document.getElementById("lat").value = latlng.getLat();
			document.getElementById("lng").value = latlng.getLng();

			marker.setPosition(latlng);
		});
	</script>

</body>
</html>