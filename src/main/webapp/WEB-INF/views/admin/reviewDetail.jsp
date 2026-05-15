<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 관리자 | 리뷰 상세보기</title>

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
}

.menu-list a:hover, .menu-list a.active {
	background: #ff914d;
	color: #fff;
	box-shadow: 0 8px 18px rgba(255, 145, 77, 0.35);
}

.main {
	flex: 1;
	padding: 38px 48px;
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	gap: 20px;
	margin-bottom: 34px;
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

.panel {
	background: rgba(255, 255, 255, 0.86);
	border: 1px solid rgba(255, 184, 107, 0.35);
	border-radius: 28px;
	box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
	padding: 30px;
}

.panel-title {
	font-size: 21px;
	color: #2f241d;
	margin-bottom: 22px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.panel-title::before {
	content: "";
	width: 8px;
	height: 24px;
	background: #ff914d;
	border-radius: 999px;
}

.detail-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 22px;
	margin-bottom: 24px;
}

.info-card {
	background: #fffaf3;
	border: 1px solid #f4d7b7;
	border-radius: 20px;
	padding: 22px;
}

.info-title {
	font-size: 14px;
	color: #a27755;
	font-weight: 900;
	margin-bottom: 8px;
}

.info-value {
	font-size: 17px;
	color: #2f241d;
	font-weight: 800;
	line-height: 1.6;
}

.review-content {
	background: #fffaf3;
	border: 1px solid #f4d7b7;
	border-radius: 20px;
	padding: 24px;
	margin-bottom: 24px;
}

.content-text {
	white-space: pre-wrap;
	word-break: break-word;
	line-height: 1.8;
	color: #4a372a;
	font-size: 15px;
}

.image-box {
	background: #fffaf3;
	border: 1px solid #f4d7b7;
	border-radius: 20px;
	padding: 24px;
	margin-bottom: 24px;
}

.review-image {
	max-width: 100%;
	max-height: 520px;
	border-radius: 18px;
	border: 1px solid #f3dcc5;
	box-shadow: 0 14px 30px rgba(90, 64, 43, 0.16);
	display: block;
	margin-top: 14px;
}

.no-image {
	color: #8a7666;
	font-size: 14px;
	padding: 30px 0;
}

.rating {
	color: #f97316;
	font-weight: 900;
}

.status-badge {
	display: inline-block;
	padding: 8px 13px;
	border-radius: 999px;
	font-size: 13px;
	font-weight: 900;
}

.status-active {
	background: #dcfce7;
	color: #166534;
}

.status-blocked {
	background: #fee2e2;
	color: #991b1b;
}

.button-row {
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
}

.btn {
	border: none;
	outline: none;
	border-radius: 14px;
	padding: 12px 17px;
	font-size: 14px;
	font-weight: 900;
	cursor: pointer;
	text-decoration: none;
	display: inline-block;
	transition: 0.2s;
	white-space: nowrap;
}

.btn-primary {
	background: #ff914d;
	color: #fff;
	box-shadow: 0 8px 20px rgba(255, 145, 77, 0.32);
}

.btn-primary:hover {
	background: #f97316;
	transform: translateY(-1px);
}

.btn-soft {
	background: #fff3df;
	color: #b45309;
}

.btn-soft:hover {
	background: #fed7aa;
}

.btn-blocked {
	background: #ef4444;
	color: #fff;
}

.btn-blocked:hover {
	background: #dc2626;
	transform: translateY(-1px);
}

.btn-active {
	background: #22c55e;
	color: #fff;
}

.btn-active:hover {
	background: #16a34a;
	transform: translateY(-1px);
}

.status-form {
	display: inline-block;
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
	.detail-grid {
		grid-template-columns: 1fr;
	}
	.btn {
		width: 100%;
		text-align: center;
		margin-bottom: 8px;
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
				<li><a href="${contextPath}/admin/restaurants">맛집 관리</a></li>
				<li><a href="${contextPath}/admin/reviewList" class="active">리뷰
						관리</a></li>
			</ul>
		</aside>

		<main class="main">

			<div class="top-bar">
				<div class="page-title">
					<h1>리뷰 상세보기</h1>
					<p>사용자가 작성한 리뷰 내용과 첨부 이미지를 확인하고 상태를 관리합니다.</p>
				</div>

				<div class="admin-badge">REVIEW DETAIL</div>
			</div>

			<section class="panel">
				<h2 class="panel-title">리뷰 정보</h2>

				<div class="detail-grid">
					<div class="info-card">
						<div class="info-title">리뷰 번호</div>
						<div class="info-value">${review.reviewId}</div>
					</div>

					<div class="info-card">
						<div class="info-title">상태</div>
						<div class="info-value">
							<c:choose>
								<c:when test="${review.status == 'ACTIVE'}">
									<span class="status-badge status-active">ACTIVE</span>
								</c:when>
								<c:otherwise>
									<span class="status-badge status-blocked">BLOCKED</span>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="info-card">
						<div class="info-title">음식점</div>
						<div class="info-value">
							${review.restaurantName} <br> <span
								style="font-size: 13px; color: #9b7b64;">ID:
								${review.restaurantId}</span>
						</div>
					</div>

					<div class="info-card">
						<div class="info-title">작성자</div>
						<div class="info-value">
							${review.memberName} <br> <span
								style="font-size: 13px; color: #9b7b64;">회원 ID:
								${review.memberId}</span>
						</div>
					</div>

					<div class="info-card">
						<div class="info-title">별점</div>
						<div class="info-value rating">★ ${review.rating}</div>
					</div>

					<div class="info-card">
						<div class="info-title">작성일 / 수정일</div>
						<div class="info-value">
							${review.createdAt} <br> <span
								style="font-size: 13px; color: #9b7b64;"> 수정일: <c:choose>
									<c:when test="${not empty review.updatedAt}">
                                    ${review.updatedAt}
                                </c:when>
									<c:otherwise>
                                    -
                                </c:otherwise>
								</c:choose>
							</span>
						</div>
					</div>
				</div>

				<div class="review-content">
					<h2 class="panel-title">리뷰 내용</h2>
					<div class="content-text">${review.content}</div>
				</div>

				<div class="image-box">
					<h2 class="panel-title">등록 이미지</h2>

					<c:choose>
						<c:when test="${not empty review.image}">
							<img class="review-image" src="${contextPath}${review.image}"
								alt="리뷰 이미지">
						</c:when>

						<c:otherwise>
							<div class="no-image">등록된 이미지가 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="button-row">

					<a href="${contextPath}/admin/reviewList" class="btn btn-soft">
						목록으로 </a>

					<form class="status-form" action="${contextPath}/admin/status"
						method="post">

						<input type="hidden" name="reviewId" value="${review.reviewId}">
						<input type="hidden" name="page" value="1"> <input
							type="hidden" name="size" value="10"> <input
							type="hidden" name="restaurantName" value="">

						<c:choose>
							<c:when test="${review.status == 'ACTIVE'}">
								<input type="hidden" name="status" value="BLOCKED">
								<button type="submit" class="btn btn-blocked"
									onclick="return confirm('이 리뷰를 차단하시겠습니까?');">리뷰 차단</button>
							</c:when>

							<c:otherwise>
								<input type="hidden" name="status" value="ACTIVE">
								<button type="submit" class="btn btn-active"
									onclick="return confirm('이 리뷰를 다시 활성화하시겠습니까?');">리뷰
									활성화</button>
							</c:otherwise>
						</c:choose>

						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}">
					</form>

				</div>

			</section>

		</main>
	</div>

</body>
</html>