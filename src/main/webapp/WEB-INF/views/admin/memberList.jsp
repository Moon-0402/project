<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 관리자 | 회원 목록</title>

<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Pretendard', 'Noto Sans KR', Arial, sans-serif;
	background: linear-gradient(135deg, #fff7ed 0%, #fff1e6 45%, #fef3c7 100%);
	color: #2f241d;
	min-height: 100vh;
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
	margin-bottom: 34px;
	gap: 20px;
}

.page-title h1 {
	font-size: 32px;
	color: #2f241d;
	margin-bottom: 8px;
}

.page-title p {
	color: #7a6a5d;
	font-size: 15px;
}

.summary-badge {
	background: rgba(255, 255, 255, 0.8);
	border: 1px solid rgba(255, 184, 107, 0.45);
	color: #a15c22;
	padding: 10px 16px;
	border-radius: 999px;
	font-size: 13px;
	font-weight: 900;
	white-space: nowrap;
}

/* 검색 영역 추가 */
.search-card {
	background: rgba(255, 255, 255, 0.82);
	border: 1px solid rgba(255, 184, 107, 0.35);
	border-radius: 24px;
	box-shadow: 0 14px 35px rgba(90, 64, 43, 0.1);
	padding: 20px;
	margin-bottom: 20px;
}

.search-form {
	display: flex;
	align-items: center;
	gap: 10px;
	flex-wrap: wrap;
}

.search-input {
	flex: 1;
	min-width: 260px;
	height: 46px;
	border: 1px solid #ffd7a8;
	border-radius: 16px;
	padding: 0 16px;
	font-size: 14px;
	font-weight: 700;
	color: #3f3027;
	background: #fffaf3;
	outline: none;
	font-family: inherit;
	transition: 0.2s;
}

.search-input:focus {
	border-color: #ff914d;
	background: #fff;
	box-shadow: 0 0 0 4px rgba(255, 145, 77, 0.16);
}

.search-input::placeholder {
	color: #b79b83;
}

.search-btn {
	border: none;
	height: 46px;
	padding: 0 20px;
	border-radius: 16px;
	background: #ff914d;
	color: #fff;
	font-size: 14px;
	font-weight: 900;
	cursor: pointer;
	font-family: inherit;
	transition: 0.2s;
}

.search-btn:hover {
	transform: translateY(-1px);
	box-shadow: 0 8px 18px rgba(255, 145, 77, 0.3);
}

.reset-btn {
	height: 46px;
	padding: 0 18px;
	border-radius: 16px;
	background: #fff3df;
	color: #b45309;
	font-size: 14px;
	font-weight: 900;
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px solid #ffd7a8;
	transition: 0.2s;
}

.reset-btn:hover {
	background: #ffedd5;
	transform: translateY(-1px);
}

.search-result-text {
	margin-top: 12px;
	color: #8a7666;
	font-size: 13px;
	font-weight: 800;
}

.search-result-text strong {
	color: #d97706;
}

.table-card {
	background: rgba(255, 255, 255, 0.86);
	border: 1px solid rgba(255, 184, 107, 0.35);
	border-radius: 28px;
	box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
	padding: 28px;
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 980px;
}

thead {
	background: #fff3df;
}

th {
	padding: 16px 14px;
	text-align: left;
	color: #9a521e;
	font-size: 13px;
	border-bottom: 1px solid #f4d7b7;
}

td {
	padding: 16px 14px;
	border-bottom: 1px solid #f5dfc9;
	color: #3f3027;
	font-size: 14px;
}

tbody tr:hover {
	background: #fffaf3;
}

.member-name {
	font-weight: 900;
	color: #2f241d;
}

.login-id {
	color: #8a7666;
	font-weight: 700;
}

.role-badge {
	display: inline-block;
	padding: 7px 12px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 900;
}

.role-user {
	background: #fff3df;
	color: #d97706;
}

.role-admin {
	background: #ede9fe;
	color: #6d28d9;
}

.btn-group {
	display: flex;
	gap: 8px;
	align-items: center;
}

.btn {
	border: none;
	border-radius: 12px;
	padding: 9px 13px;
	font-size: 13px;
	font-weight: 900;
	cursor: pointer;
	text-decoration: none;
	display: inline-block;
	transition: 0.2s;
	white-space: nowrap;
	font-family: inherit;
}

.btn-detail {
	background: #ff914d;
	color: #fff;
}

.btn-edit {
	background: #fff3df;
	color: #b45309;
}

.btn-delete {
	background: #fee2e2;
	color: #b91c1c;
}

.btn-detail:hover, .btn-edit:hover, .btn-delete:hover {
	transform: translateY(-1px);
}

.btn-delete:hover {
	background: #fecaca;
}

.delete-form {
	display: inline;
}

.empty-box {
	background: #fff;
	border-radius: 24px;
	padding: 50px;
	text-align: center;
	color: #8a7666;
	box-shadow: 0 14px 35px rgba(90, 64, 43, 0.12);
}

.pagination-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	margin-top: 30px;
	flex-wrap: wrap;
}

.pagination-wrap a, .pagination-wrap span {
	min-width: 38px;
	height: 38px;
	padding: 0 13px;
	border-radius: 999px;
	background: #fff7ed;
	color: #8a4b16;
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 900;
	font-size: 14px;
	border: 1px solid #ffd7a8;
	transition: 0.2s;
}

.pagination-wrap a:hover {
	background: #ffedd5;
	transform: translateY(-1px);
}

.pagination-wrap a.active {
	background: #f97316;
	color: white;
	border-color: #f97316;
	box-shadow: 0 8px 18px rgba(249, 115, 22, 0.28);
}

.pagination-wrap span.disabled {
	opacity: 0.45;
	cursor: default;
}

.page-info {
	text-align: center;
	margin-top: 16px;
	color: #8a7666;
	font-size: 13px;
	font-weight: 700;
}

.alert-msg {
	background: #ecfdf5;
	color: #047857;
	border: 1px solid #a7f3d0;
	padding: 14px 18px;
	border-radius: 18px;
	margin-bottom: 20px;
	font-size: 14px;
	font-weight: 800;
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
	.summary-badge {
		display: inline-block;
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
	.search-btn, .reset-btn {
		width: 100%;
		margin-bottom: 8px;
	}
}
</style>
</head>

<body>

	<div class="admin-layout">

		<aside class="sidebar">
			<div class="logo-box">
				<a href="${pageContext.request.contextPath}/" class="logo-link">
					<div class="logo">
						Pick<span>Eat</span>
					</div>
				</a>
				<div class="logo-desc">날씨와 상황에 맞는 맛집 추천 서비스</div>
			</div>

			<div class="menu-title">Admin Menu</div>
			<ul class="menu-list">
				<li><a href="${pageContext.request.contextPath}/admin">대시보드</a></li>
				<li>
					<a href="${pageContext.request.contextPath}/admin/members?page=1&size=10"
					   class="active">회원 관리</a>
				</li>
				<li><a href="${pageContext.request.contextPath}/admin/inquiries">문의 관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/restaurants">맛집 관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/reviewList">리뷰 관리</a></li>
			</ul>
		</aside>

		<main class="main">

			<div class="top-bar">
				<div class="page-title">
					<h1>회원 관리</h1>
					<p>PickEat 회원의 기본 정보를 조회하고 수정합니다.</p>
				</div>

				<div class="summary-badge">전체 회원 ${pageDTO.totalCount}명</div>
			</div>

			<c:if test="${not empty msg}">
				<div class="alert-msg">${msg}</div>
			</c:if>

			<!-- 검색 영역 -->
			<section class="search-card">
				<form action="${pageContext.request.contextPath}/admin/members"
				      method="get"
				      class="search-form">

					<input type="hidden" name="page" value="1">
					<input type="hidden" name="size" value="${pageDTO.size}">

					<input type="text"
					       name="keyword"
					       class="search-input"
					       value="${keyword}"
					       placeholder="이름 또는 사용자 아이디를 입력하세요">

					<button type="submit" class="search-btn">검색</button>

					<a href="${pageContext.request.contextPath}/admin/members?page=1&size=${pageDTO.size}"
					   class="reset-btn">초기화</a>
				</form>

				<c:if test="${not empty keyword}">
					<div class="search-result-text">
						<strong>${keyword}</strong> 검색 결과입니다.
					</div>
				</c:if>
			</section>

			<c:choose>
				<c:when test="${not empty memberList}">
					<section class="table-card">
						<table>
							<thead>
								<tr>
									<th>회원번호</th>
									<th>로그인 ID</th>
									<th>이름</th>
									<th>이메일</th>
									<th>전화번호</th>
									<th>권한</th>
									<th>가입일</th>
									<th>관리</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach var="member" items="${memberList}">
									<tr>
										<td>${member.memberId}</td>
										<td class="login-id">${member.loginId}</td>
										<td class="member-name">${member.name}</td>
										<td>${member.email}</td>

										<td>
											<c:choose>
												<c:when test="${empty member.phone}">-</c:when>
												<c:otherwise>${member.phone}</c:otherwise>
											</c:choose>
										</td>

										<td>
											<c:choose>
												<c:when test="${member.role == 'ADMIN'}">
													<span class="role-badge role-admin">ADMIN</span>
												</c:when>
												<c:otherwise>
													<span class="role-badge role-user">USER</span>
												</c:otherwise>
											</c:choose>
										</td>

										<td>${member.created_at}</td>

										<td>
											<div class="btn-group">
												<a href="${pageContext.request.contextPath}/admin/member/detail?memberId=${member.memberId}"
												   class="btn btn-detail">상세</a>

												<a href="${pageContext.request.contextPath}/admin/member/update?memberId=${member.memberId}"
												   class="btn btn-edit">수정</a>

												<form action="${pageContext.request.contextPath}/admin/member/delete?memberId=${member.memberId}"
												      method="post"
												      class="delete-form"
												      onsubmit="return confirm('정말 이 회원을 삭제하시겠습니까? 삭제 후 복구할 수 없습니다.');">

													<input type="hidden" name="_method" value="delete">

													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
														       value="${_csrf.token}">
													</c:if>

													<button type="submit" class="btn btn-delete">삭제</button>
												</form>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</section>

					<c:if test="${pageDTO.totalPage > 0}">
						<div class="pagination-wrap">

							<c:choose>
								<c:when test="${pageDTO.page > 1}">
									<a href="${pageContext.request.contextPath}/admin/members?page=${pageDTO.page - 1}&size=${pageDTO.size}&keyword=${keyword}">
										이전
									</a>
								</c:when>
								<c:otherwise>
									<span class="disabled">이전</span>
								</c:otherwise>
							</c:choose>

							<c:forEach var="num" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
								<c:if test="${num <= pageDTO.totalPage}">
									<a href="${pageContext.request.contextPath}/admin/members?page=${num}&size=${pageDTO.size}&keyword=${keyword}"
									   class="${pageDTO.page == num ? 'active' : ''}">
										${num}
									</a>
								</c:if>
							</c:forEach>

							<c:choose>
								<c:when test="${pageDTO.page < pageDTO.totalPage}">
									<a href="${pageContext.request.contextPath}/admin/members?page=${pageDTO.page + 1}&size=${pageDTO.size}&keyword=${keyword}">
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
				</c:when>

				<c:otherwise>
					<div class="empty-box">
						<c:choose>
							<c:when test="${not empty keyword}">
								<h2>검색 결과가 없습니다.</h2>
								<p style="margin-top: 12px;">
									<strong>${keyword}</strong>에 해당하는 회원을 찾을 수 없습니다.
								</p>
							</c:when>
							<c:otherwise>
								<h2>회원 목록이 없습니다.</h2>
								<p style="margin-top: 12px;">아직 등록된 PickEat 회원이 없습니다.</p>
							</c:otherwise>
						</c:choose>
					</div>
				</c:otherwise>
			</c:choose>

		</main>
	</div>

</body>
</html>