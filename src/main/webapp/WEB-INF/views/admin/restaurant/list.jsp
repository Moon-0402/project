<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 관리자 | 맛집 관리</title>

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

/* 왼쪽 배너 */
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

.menu-list a:hover,
.menu-list a.active {
	background: #ff914d;
	color: #fff;
	box-shadow: 0 8px 18px rgba(255, 145, 77, 0.35);
}

/* 오른쪽 본문 */
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

/* 상단 안내 카드 */
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

/* 검색 카드 */
.search-area {
	background: rgba(255, 255, 255, 0.86);
	border: 1px solid rgba(255, 184, 107, 0.35);
	border-radius: 24px;
	padding: 22px;
	margin-bottom: 24px;
	box-shadow: 0 14px 34px rgba(90, 64, 43, 0.1);
}

.search-form {
	display: flex;
	gap: 10px;
	align-items: center;
	flex-wrap: wrap;
}

.search-input {
	flex: 1;
	min-width: 260px;
	height: 48px;
	padding: 0 16px;
	border-radius: 15px;
	border: 1px solid #f4d7b7;
	background: #fffaf3;
	color: #2f241d;
	font-size: 14px;
	font-weight: 700;
	outline: none;
	font-family: inherit;
}

.search-input::placeholder {
	color: #b49376;
}

.search-input:focus {
	border-color: #ff914d;
	box-shadow: 0 0 0 4px rgba(255, 145, 77, 0.16);
}

.search-btn,
.reset-btn,
.add-btn {
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

.search-btn,
.add-btn {
	border: none;
	background: #ff914d;
	color: #fff;
	box-shadow: 0 8px 20px rgba(255, 145, 77, 0.32);
}

.search-btn:hover,
.add-btn:hover {
	background: #f97316;
	transform: translateY(-1px);
}

.reset-btn {
	border: 1px solid #f4d7b7;
	background: #fff3df;
	color: #b45309;
}

.reset-btn:hover {
	background: #fed7aa;
}

.search-info {
	margin-top: 14px;
	color: #7a6a5d;
	font-size: 13px;
	font-weight: 800;
}

.search-info strong {
	color: #f97316;
}

/* 목록 카드 */
.content-card {
	background: rgba(255, 255, 255, 0.86);
	border: 1px solid rgba(255, 184, 107, 0.35);
	border-radius: 28px;
	box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
	padding: 28px;
}

.table-wrap {
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	overflow: hidden;
	border-radius: 20px;
	background: #fffaf3;
}

th {
	background: #fff3df;
	padding: 16px;
	color: #a15c22;
	text-align: left;
	font-size: 14px;
	border-bottom: 1px solid #f3dcc5;
	white-space: nowrap;
}

td {
	padding: 16px;
	border-bottom: 1px solid #f3dcc5;
	color: #2f241d;
	vertical-align: middle;
	font-size: 14px;
}

tbody tr:hover {
	background: #fff7ed;
}

.id-cell {
	font-weight: 900;
	color: #a15c22;
	white-space: nowrap;
}

.name-cell {
	font-weight: 900;
	color: #2f241d;
	max-width: 340px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.category {
	display: inline-block;
	background: #fff3df;
	color: #b45309;
	padding: 8px 12px;
	border-radius: 999px;
	font-weight: 900;
	font-size: 13px;
	max-width: 260px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	vertical-align: middle;
	border: 1px solid #f4d7b7;
}

.rating-cell {
	color: #f97316;
	font-weight: 900;
	white-space: nowrap;
}

.actions {
	display: flex;
	align-items: center;
	gap: 8px;
	flex-wrap: nowrap;
}

.action-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 40px;
	padding: 0 15px;
	border-radius: 13px;
	font-weight: 900;
	font-size: 14px;
	text-decoration: none;
	white-space: nowrap;
	cursor: pointer;
	transition: 0.2s;
	font-family: inherit;
}

.view-btn {
	background: #ff914d;
	color: #fff;
	border: none;
	box-shadow: 0 8px 20px rgba(255, 145, 77, 0.26);
}

.view-btn:hover {
	background: #f97316;
	transform: translateY(-1px);
}

.edit-btn {
	background: #fff3df;
	color: #b45309;
	border: 1px solid #f4d7b7;
}

.edit-btn:hover {
	background: #fed7aa;
}

.delete-btn {
	background: #fff;
	color: #dc2626;
	border: 1px solid #fecaca;
}

.delete-btn:hover {
	background: #fee2e2;
}

.delete-form {
	margin: 0;
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

/* 페이징 */
.pagination-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	margin-top: 30px;
	flex-wrap: wrap;
}

.pagination-wrap a,
.pagination-wrap span {
	min-width: 38px;
	height: 38px;
	padding: 0 13px;
	border-radius: 999px;
	background: #fff3df;
	color: #b45309;
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 900;
	font-size: 14px;
	border: 1px solid #f4d7b7;
	transition: 0.2s;
}

.pagination-wrap a:hover {
	background: #fed7aa;
	transform: translateY(-1px);
}

.pagination-wrap a.active {
	background: #ff914d;
	color: #fff;
	border-color: #ff914d;
	box-shadow: 0 8px 18px rgba(255, 145, 77, 0.28);
}

.pagination-wrap span.disabled {
	opacity: 0.45;
	cursor: default;
}

.page-info {
	text-align: center;
	margin-top: 16px;
	color: #7a6a5d;
	font-size: 13px;
	font-weight: 800;
}

/* 반응형 */
@media (max-width: 900px) {
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
		min-width: 100%;
		margin-bottom: 10px;
	}

	.search-btn,
	.reset-btn,
	.add-btn {
		width: 100%;
		margin-bottom: 8px;
	}

	.content-card {
		padding: 20px;
	}
}
</style>
</head>

<body>

<div class="admin-layout">

	<!-- 왼쪽 배너 -->
	<aside class="sidebar">
		<div class="logo-box">
			<a href="${contextPath}/" class="logo-link">
				<div class="logo">Pick<span>Eat</span></div>
			</a>
			<div class="logo-desc">날씨와 상황에 맞는 맛집 추천 서비스</div>
		</div>

		<div class="menu-title">Admin Menu</div>

		<ul class="menu-list">
			<li>
				<a href="${contextPath}/admin">대시보드</a>
			</li>
			<li>
				<a href="${contextPath}/admin/members">회원 관리</a>
			</li>
			<li>
				<a href="${contextPath}/admin/inquiries">문의 관리</a>
			</li>
			<li>
				<a href="${contextPath}/admin/restaurants" class="active">맛집 관리</a>
			</li>
			<li>
				<a href="${contextPath}/admin/reviewList">리뷰 관리</a>
			</li>
		</ul>
	</aside>

	<!-- 오른쪽 본문 -->
	<main class="main">

		<div class="top-bar">
			<div class="page-title">
				<h1>맛집 관리</h1>
				<p>등록된 맛집을 확인하고 수정하거나 삭제할 수 있습니다.</p>
			</div>

			<div class="admin-badge">RESTAURANT MODE</div>
		</div>

		<section class="summary-card">
			<div class="summary-title">맛집 데이터 관리 센터</div>
			<p class="summary-text">
				등록된 맛집 정보를 확인하고, 필요한 경우 수정하거나 삭제할 수 있습니다.
				검색 기능을 사용하면 원하는 맛집을 빠르게 찾을 수 있습니다.
			</p>
		</section>

		<section class="search-area">
			<form class="search-form"
				  action="${contextPath}/admin/restaurants"
				  method="get">

				<input type="text"
					   name="keyword"
					   class="search-input"
					   placeholder="맛집명을 검색하세요"
					   value="${keyword}">

				<input type="hidden" name="size" value="${pageDTO.size}">

				<button type="submit" class="search-btn">
					검색
				</button>

				<a href="${contextPath}/admin/restaurants"
				   class="reset-btn">
					초기화
				</a>

				<a href="${contextPath}/admin/restaurants/add"
				   class="add-btn">
					+ 맛집 등록
				</a>
			</form>

			<c:if test="${not empty keyword}">
				<div class="search-info">
					<strong>${keyword}</strong> 검색 결과입니다.
				</div>
			</c:if>
		</section>

		<section class="content-card">

			<c:choose>
				<c:when test="${empty restaurantList}">
					<div class="empty">
						<c:choose>
							<c:when test="${not empty keyword}">
								<strong>${keyword}</strong>에 해당하는 맛집이 없습니다.
							</c:when>

							<c:otherwise>
								등록된 맛집이 없습니다.
							</c:otherwise>
						</c:choose>
					</div>
				</c:when>

				<c:otherwise>
					<div class="table-wrap">
						<table>
							<thead>
								<tr>
									<th>ID</th>
									<th>맛집명</th>
									<th>카테고리</th>
									<th>평점</th>
									<th>관리</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach var="restaurant" items="${restaurantList}">
									<tr>
										<td class="id-cell">
											${restaurant.restaurantId}
										</td>

										<td>
											<div class="name-cell">
												${restaurant.name}
											</div>
										</td>

										<td>
											<span class="category" title="${restaurant.categoryName}">
												${restaurant.categoryName}
											</span>
										</td>

										<td class="rating-cell">
											★ ${restaurant.rating}
										</td>

										<td>
											<div class="actions">
												<a class="action-btn view-btn"
												   href="${contextPath}/restaurants/${restaurant.restaurantId}">
													보기
												</a>

												<a class="action-btn edit-btn"
												   href="${contextPath}/admin/restaurants/update?restaurantId=${restaurant.restaurantId}">
													수정
												</a>

												<form class="delete-form"
													  action="${contextPath}/admin/restaurants/delete"
													  method="post"
													  onsubmit="return confirm('정말 삭제하시겠습니까?');">

													<input type="hidden"
														   name="${_csrf.parameterName}"
														   value="${_csrf.token}">

													<input type="hidden"
														   name="restaurantId"
														   value="${restaurant.restaurantId}">

													<button type="submit"
															class="action-btn delete-btn">
														삭제
													</button>
												</form>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<c:if test="${pageDTO.totalPage > 0}">
						<div class="pagination-wrap">

							<c:choose>
								<c:when test="${pageDTO.page > 1}">
									<a href="${contextPath}/admin/restaurants?page=${pageDTO.page - 1}&size=${pageDTO.size}&keyword=${keyword}">
										이전
									</a>
								</c:when>

								<c:otherwise>
									<span class="disabled">이전</span>
								</c:otherwise>
							</c:choose>

							<c:forEach var="num"
									   begin="${pageDTO.startPage}"
									   end="${pageDTO.endPage}">
								<a href="${contextPath}/admin/restaurants?page=${num}&size=${pageDTO.size}&keyword=${keyword}"
								   class="${pageDTO.page == num ? 'active' : ''}">
									${num}
								</a>
							</c:forEach>

							<c:choose>
								<c:when test="${pageDTO.page < pageDTO.totalPage}">
									<a href="${contextPath}/admin/restaurants?page=${pageDTO.page + 1}&size=${pageDTO.size}&keyword=${keyword}">
										다음
									</a>
								</c:when>

								<c:otherwise>
									<span class="disabled">다음</span>
								</c:otherwise>
							</c:choose>

						</div>

						<div class="page-info">
							현재 ${pageDTO.page}페이지 / 전체 ${pageDTO.totalPage}페이지
						</div>
					</c:if>

				</c:otherwise>
			</c:choose>

		</section>

	</main>

</div>

</body>
</html>