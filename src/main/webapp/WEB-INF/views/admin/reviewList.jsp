<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 관리자 | 리뷰 관리</title>

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

.search-box {
	background: #fffaf3;
	border: 1px solid #f4d7b7;
	border-radius: 20px;
	padding: 18px 20px;
	margin-bottom: 24px;
}

.search-form {
	display: flex;
	gap: 10px;
	align-items: center;
}

.search-input {
	flex: 1;
	border: 1px solid #f3c79d;
	border-radius: 14px;
	padding: 13px 15px;
	font-size: 14px;
	outline: none;
	background: #fff;
	color: #2f241d;
}

.search-input:focus {
	border-color: #ff914d;
	box-shadow: 0 0 0 4px rgba(255, 145, 77, 0.16);
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

.message {
	padding: 14px 18px;
	border-radius: 16px;
	margin-bottom: 18px;
	font-size: 14px;
	font-weight: 900;
}

.message-success {
	background: #dcfce7;
	color: #166534;
	border: 1px solid #bbf7d0;
}

.message-error {
	background: #fee2e2;
	color: #991b1b;
	border: 1px solid #fecaca;
}

.table-wrap {
	width: 100%;
	overflow-x: auto;
	border-radius: 20px;
	border: 1px solid #f3dcc5;
	background: #fffaf3;
}

.review-table {
	width: 100%;
	border-collapse: collapse;
	min-width: 1050px;
}

.review-table thead {
	background: #fff3df;
}

.review-table th {
	padding: 16px 14px;
	color: #8a4a17;
	font-size: 13px;
	text-align: left;
	border-bottom: 1px solid #f3dcc5;
	white-space: nowrap;
}

.review-table td {
	padding: 16px 14px;
	color: #3b2a1f;
	font-size: 14px;
	border-bottom: 1px solid #f3dcc5;
	vertical-align: middle;
}

.review-table tbody tr:hover {
	background: #fff7ed;
}

.review-table tbody tr:last-child td {
	border-bottom: none;
}

.content-cell {
	max-width: 330px;
	line-height: 1.5;
	color: #5f4b3d;
	word-break: break-word;
}

.rating {
	color: #f97316;
	font-weight: 900;
	white-space: nowrap;
}

.status-badge {
	display: inline-block;
	padding: 7px 11px;
	border-radius: 999px;
	font-size: 12px;
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

.action-form {
	display: inline-block;
}

.empty-box {
	padding: 60px 20px;
	text-align: center;
	color: #7a6a5d;
	font-size: 15px;
	line-height: 1.7;
}

.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	margin-top: 26px;
	flex-wrap: wrap;
}

.page-link {
	min-width: 38px;
	height: 38px;
	padding: 0 12px;
	border-radius: 12px;
	border: 1px solid #f3c79d;
	background: rgba(255, 255, 255, 0.78);
	color: #9a4b00;
	text-decoration: none;
	font-size: 14px;
	font-weight: 900;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	transition: 0.2s;
}

.page-link:hover, .page-link.active {
	background: #ff914d;
	color: #fff;
	border-color: #ff914d;
	box-shadow: 0 8px 18px rgba(255, 145, 77, 0.28);
}

.page-info {
	margin-top: 18px;
	color: #8a7666;
	font-size: 13px;
	text-align: right;
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
	.search-form {
		display: block;
	}
	.search-input {
		width: 100%;
		margin-bottom: 10px;
	}
	.btn {
		width: 100%;
		text-align: center;
		margin-bottom: 8px;
	}
	.page-info {
		text-align: center;
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
				<li><a href="${contextPath}/admin/reviewList" class="active">리뷰 관리</a></li>
				<li>
                <a href="${pageContext.request.contextPath}/member/logout">
                    로그아웃
                </a>
            </li>
			</ul>
		</aside>

		<main class="main">

			<div class="top-bar">
				<div class="page-title">
					<h1>리뷰 관리</h1>
					<p>음식점 이름으로 리뷰를 검색하고, 리뷰 상태를 ACTIVE 또는 BLOCKED로 변경합니다.</p>
				</div>

				<div class="admin-badge">REVIEW ADMIN</div>
			</div>

			<section class="panel">
				<h2 class="panel-title">리뷰 목록</h2>

				<c:if test="${not empty successMessage}">
					<div class="message message-success">${successMessage}</div>
				</c:if>

				<c:if test="${not empty errorMessage}">
					<div class="message message-error">${errorMessage}</div>
				</c:if>

				<div class="search-box">
					<form class="search-form" action="${contextPath}/admin/reviewList"
						method="get">
						<input type="text" name="restaurantName" class="search-input"
							value="${restaurantName}" placeholder="음식점 이름으로 검색"> <input
							type="hidden" name="page" value="1"> <input type="hidden"
							name="size" value="${pageDTO.size}">

						<button type="submit" class="btn btn-primary">검색</button>
						<a href="${contextPath}/admin/reviewList" class="btn btn-soft">전체
							보기</a>
					</form>
				</div>

				<c:choose>
					<c:when test="${empty reviewList}">
						<div class="empty-box">
							조회된 리뷰가 없습니다.<br> 검색어를 다시 확인해주세요.
						</div>
					</c:when>

					<c:otherwise>
						<div class="table-wrap">
							<table class="review-table">
								<thead>
									<tr>
										<th>리뷰 번호</th>
										<th>음식점</th>
										<th>작성자</th>
										<th>별점</th>
										<th>내용</th>
										<th>이미지</th>
										<th>상태</th>
										<th>작성일</th>
										<th>수정일</th>
										<th>상태 변경</th>
										<th>상세보기</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="review" items="${reviewList}">
										<tr>
											<td>${review.reviewId}</td>

											<td>${review.restaurantName}<br> <span
												style="font-size: 12px; color: #9b7b64;"> ID:
													${review.restaurantId} </span>
											</td>

											<td>${review.memberName}<br> <span
												style="font-size: 12px; color: #9b7b64;"> 회원 ID:
													${review.memberId} </span>
											</td>

											<td><span class="rating">★ ${review.rating}</span></td>

											<td class="content-cell">${review.content}</td>

											<td><c:choose>
													<c:when test="${not empty review.image}">
														<span style="font-size: 13px; color: #b45309;">첨부
															있음</span>
													</c:when>
													<c:otherwise>
														<span style="font-size: 13px; color: #9b7b64;">없음</span>
													</c:otherwise>
												</c:choose></td>

											<td><c:choose>
													<c:when test="${review.status == 'ACTIVE'}">
														<span class="status-badge status-active">ACTIVE</span>
													</c:when>
													<c:otherwise>
														<span class="status-badge status-blocked">BLOCKED</span>
													</c:otherwise>
												</c:choose></td>

											<td>${review.createdAt}</td>

											<td><c:choose>
													<c:when test="${not empty review.updatedAt}">
                                                    ${review.updatedAt}
                                                </c:when>
													<c:otherwise>
                                                    -
                                                </c:otherwise>
												</c:choose></td>

											<td>
												<form class="action-form"
													action="${contextPath}/admin/status" method="post">

													<input type="hidden" name="reviewId"
														value="${review.reviewId}"> <input type="hidden"
														name="page" value="${pageDTO.page}"> <input
														type="hidden" name="size" value="${pageDTO.size}">
													<input type="hidden" name="restaurantName"
														value="${restaurantName}">

													<c:choose>
														<c:when test="${review.status == 'ACTIVE'}">
															<input type="hidden" name="status" value="BLOCKED">
															<button type="submit" class="btn btn-blocked"
																onclick="return confirm('이 리뷰를 차단하시겠습니까?');">
																차단</button>
														</c:when>

														<c:otherwise>
															<input type="hidden" name="status" value="ACTIVE">
															<button type="submit" class="btn btn-active"
																onclick="return confirm('이 리뷰를 다시 활성화하시겠습니까?');">
																활성화</button>
														</c:otherwise>
													</c:choose>

													<input type="hidden" name="${_csrf.parameterName}"
														value="${_csrf.token}">
												</form>
											</td>
											<td><a class="btn btn-soft"
												href="${contextPath}/admin/reviewDetail?reviewId=${review.reviewId}">
													상세보기 </a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<div class="pagination">

							<c:if test="${pageDTO.prev}">
								<a class="page-link"
									href="${contextPath}/admin/reviewList?page=${pageDTO.startPage - 1}&size=${pageDTO.size}&restaurantName=${restaurantName}">
									이전 </a>
							</c:if>

							<c:forEach var="num" begin="${pageDTO.startPage}"
								end="${pageDTO.endPage}">
								<a class="page-link ${pageDTO.page == num ? 'active' : ''}"
									href="${contextPath}/admin/reviewList?page=${num}&size=${pageDTO.size}&restaurantName=${restaurantName}">
									${num} </a>
							</c:forEach>

							<c:if test="${pageDTO.next}">
								<a class="page-link"
									href="${contextPath}/admin/reviewList?page=${pageDTO.endPage + 1}&size=${pageDTO.size}&restaurantName=${restaurantName}">
									다음 </a>
							</c:if>

						</div>

						<div class="page-info">총 ${pageDTO.totalCount}개 리뷰 / 현재
							${pageDTO.page}페이지 / 총 ${pageDTO.totalPage}페이지</div>
					</c:otherwise>
				</c:choose>

			</section>

		</main>
	</div>

</body>
</html>