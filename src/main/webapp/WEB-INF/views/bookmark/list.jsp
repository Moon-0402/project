<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PickEat - 즐겨찾기</title>

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
	padding: 44px 60px;
}

.page-title {
	margin-bottom: 28px;
}

.page-title h1 {
	font-size: 38px;
	margin: 0 0 10px;
}

.page-title p {
	margin: 0;
	color: #6b7280;
	font-weight: 700;
}

.bookmark-wrap {
	display: grid;
	grid-template-columns: 1fr 300px;
	gap: 30px;
	align-items: start;
}

.bookmark-list {
	display: flex;
	flex-direction: column;
	gap: 18px;
}

.bookmark-card {
	background: #fff;
	border-radius: 22px;
	padding: 24px 28px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
	border: 1px solid #ffe0c2;
	display: flex;
	justify-content: space-between;
	gap: 20px;
}

.restaurant-name {
	font-size: 30px;
	font-weight: 900;
	color: #ff6500;
	margin-bottom: 10px;
}

.info-list {
	display: flex;
	flex-direction: column;
	gap: 8px;
	color: #4b5563;
	font-weight: 700;
}

.tags {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
	margin-top: 16px;
}

.tag {
	background: #f3f4f6;
	border-radius: 999px;
	padding: 8px 12px;
	font-size: 14px;
	font-weight: 800;
	max-width: 260px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.card-right {
	min-width: 170px;
	text-align: right;
}

.date {
	color: #9ca3af;
	font-weight: 700;
	margin-bottom: 18px;
}

.btns {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.btn {
	display: inline-block;
	text-decoration: none;
	border-radius: 12px;
	padding: 11px 14px;
	font-weight: 900;
	text-align: center;
	border: none;
	cursor: pointer;
}

.btn-orange {
	background: #ff6500;
	color: #fff;
}

.btn-outline {
	background: #fff;
	color: #111827;
	border: 1px solid #ddd;
	width: 100%;
}

.delete-form {
	margin: 0;
}

.side-panel {
	background: #fff;
	border-radius: 22px;
	padding: 24px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
}

.side-panel h3 {
	margin-top: 0;
}

.summary-card {
	border: 1px solid #eee;
	border-radius: 16px;
	padding: 18px;
	margin-bottom: 14px;
}

.summary-card strong {
	display: block;
	font-size: 22px;
	color: #ff6500;
	margin-bottom: 6px;
}

.summary-card span {
	color: #6b7280;
	font-weight: 700;
}

.empty-box {
	background: #fff;
	border-radius: 22px;
	padding: 60px;
	text-align: center;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
}

.empty-box h2 {
	margin-bottom: 10px;
}

.empty-box p {
	color: #6b7280;
	font-weight: 700;
}

@media ( max-width : 1000px) {
	.bookmark-wrap {
		grid-template-columns: 1fr;
	}
	.bookmark-card {
		flex-direction: column;
	}
	.card-right {
		text-align: left;
	}
	.btns {
		flex-direction: row;
	}
}
</style>
</head>

<body>

	<%@ include file = "/WEB-INF/views/header.jsp" %>

	<main class="container">

		<section class="page-title">
			<h1>내 즐겨찾기 ❤️</h1>
			<p>다시 가고 싶은 맛집들을 한눈에 확인해보세요.</p>
		</section>

		<section class="bookmark-wrap">

			<div class="bookmark-list">

				<c:choose>
					<c:when test="${empty bookmarkList}">
						<div class="empty-box">
							<h2>아직 즐겨찾기가 없어요.</h2>
							<p>맛집 상세 페이지에서 마음에 드는 맛집을 저장해보세요.</p>
							<a class="btn btn-orange" href="${contextPath}/restaurants">맛집
								보러 가기</a>
						</div>
					</c:when>

					<c:otherwise>
						<c:forEach var="b" items="${bookmarkList}">
							<article class="bookmark-card">
								<div>
									<div class="restaurant-name">${b.restaurantName}</div>

									<div class="info-list">
										<div>📍 주소 : ${b.address}</div>
										<div>☎ 전화번호 : ${b.phone}</div>
									</div>

									<div class="tags">
										<span class="tag">🏷 ${b.categoryName}</span> <span
											class="tag">💰 ${b.priceRange}</span>
									</div>
								</div>

								<div class="card-right">
									<div class="date">${b.createdAt}</div>

									<div class="btns">
										<a class="btn btn-orange"
											href="${contextPath}/restaurants/${b.restaurantId}"> 상세
											보기 </a>

										<form class="delete-form"
											action="${contextPath}/bookmark/delete" method="post"
											onsubmit="return confirm('즐겨찾기를 삭제하시겠습니까?');">

											<input type="hidden" name="bookmarkId"
												value="${b.bookmarkId}"> <input type="hidden"
												name="${_csrf.parameterName}" value="${_csrf.token}">

											<button class="btn btn-outline" type="submit">삭제</button>
										</form>
									</div>
								</div>
							</article>
						</c:forEach>
					</c:otherwise>
				</c:choose>

			</div>

			<aside class="side-panel">
				<h3>즐겨찾기 요약</h3>

				<div class="summary-card">
					<strong>${bookmarkList.size()}개</strong> <span>총 즐겨찾기</span>
				</div>

				<div class="summary-card">
					<c:choose>
						<c:when test="${empty bookmarkList}">
							<strong>-</strong>
						</c:when>
						<c:otherwise>
							<strong>${bookmarkList[0].restaurantName}</strong>
						</c:otherwise>
					</c:choose>
					<span>최근 저장한 맛집</span>
				</div>

				<div class="summary-card">
					<c:choose>
						<c:when test="${empty bookmarkList}">
							<strong>-</strong>
						</c:when>
						<c:otherwise>
							<strong>${bookmarkList[0].categoryName}</strong>
						</c:otherwise>
					</c:choose>
					<span>최근 저장 카테고리</span>
				</div>
			</aside>

		</section>

	</main>

</body>
</html>