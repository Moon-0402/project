<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PickEat - 추천 기록</title>

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

.history-wrap {
	display: grid;
	grid-template-columns: 1fr 300px;
	gap: 30px;
	align-items: start;
}

.history-list {
	display: flex;
	flex-direction: column;
	gap: 18px;
}

.history-card {
	background: #fff;
	border-radius: 22px;
	padding: 24px 28px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
	border: 1px solid #ffe0c2;
	display: flex;
	justify-content: space-between;
	gap: 20px;
}

.food-name {
	font-size: 30px;
	font-weight: 900;
	color: #ff6500;
	margin-bottom: 8px;
}

.desc {
	color: #6b7280;
	font-weight: 600;
	margin-bottom: 18px;
}

.tags {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
}

.tag {
	background: #f3f4f6;
	border-radius: 999px;
	padding: 8px 12px;
	font-size: 14px;
	font-weight: 800;
	/* 수정: 긴 값 들어와도 안 깨지게 */
	max-width: 220px;
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
	.history-wrap {
		grid-template-columns: 1fr;
	}
	.history-card {
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
			<h1>내 추천 기록 🕘</h1>
			<p>돌림판으로 추천받았던 음식들을 다시 확인해보세요.</p>
		</section>

		<section class="history-wrap">

			<div class="history-list">

				<c:choose>
					<c:when test="${empty historyList}">
						<div class="empty-box">
							<h2>아직 추천 기록이 없어요.</h2>
							<p>돌림판을 돌려 오늘의 메뉴를 추천받아보세요.</p>
							<a class="btn btn-orange" href="${contextPath}/recommend">추천
								받으러 가기</a>
						</div>
					</c:when>

					<c:otherwise>
						<c:forEach var="history" items="${historyList}">
							<article class="history-card">
								<div>
									<div class="food-name">${history.selectedFood}</div>
									<p class="desc">${history.selectedFood}기준으로 주변 맛집을 추천받았어요.</p>

									<div class="tags">
										<span class="tag">☁ ${history.weather}</span> <span
											class="tag">👤 ${history.situation}</span> <span class="tag">🪙
											${history.priceRange}</span> <span class="tag">🌶
											${history.spicyLevel}</span>
									</div>
								</div>

								<div class="card-right">
									<div class="date">${history.createdAt}</div>

									<div class="btns">
										<a class="btn btn-orange"
											href="${contextPath}/recommend/result?selectedFood=${history.selectedFood}">
											결과 보기 </a>

										<form class="delete-form"
											action="${contextPath}/recommend/history/delete"
											method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">

											<input type="hidden" name="recommendId"
												value="${history.recommendId}"> <input type="hidden"
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
				<h3>추천 기록 요약</h3>

				<div class="summary-card">
					<strong>${historyList.size()}개</strong> <span>총 추천 기록</span>
				</div>

				<div class="summary-card">
					<c:choose>
						<c:when test="${empty historyList}">
							<strong>-</strong>
						</c:when>
						<c:otherwise>
							<strong>${historyList[0].selectedFood}</strong>
						</c:otherwise>
					</c:choose>
					<span>최근 추천 음식</span>
				</div>

				<div class="summary-card">
					<c:choose>
						<c:when test="${empty historyList}">
							<strong>-</strong>
						</c:when>
						<c:otherwise>
							<strong>${historyList[0].situation}</strong>
						</c:otherwise>
					</c:choose>
					<span>최근 선택한 상황</span>
				</div>
			</aside>

		</section>

	</main>
	<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>