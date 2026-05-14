<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:choose>
	<c:when test="${not empty requestScope['jakarta.servlet.forward.request_uri']}">
		<c:set var="currentURI" value="${requestScope['jakarta.servlet.forward.request_uri']}" />
	</c:when>
	<c:otherwise>
		<c:set var="currentURI" value="${pageContext.request.requestURI}" />
	</c:otherwise>
</c:choose>

<c:set var="homeURI" value="${contextPath}/" />
<c:set var="recommendURI" value="${contextPath}/recommend" />
<c:set var="restaurantsURI" value="${contextPath}/restaurants" />
<c:set var="bookmarkURI" value="${contextPath}/bookmark/list" />
<c:set var="reviewURI" value="${contextPath}/review" />
<c:set var="loginURI" value="${contextPath}/member/login" />
<style>
* {
	box-sizing: border-box;
}

html {
	scroll-behavior: smooth;
}

body {
	margin: 0;
	font-family: 'Noto Sans KR', Arial, sans-serif;
	color: #111827;
	background: radial-gradient(circle at 10% 12%, rgba(255, 122, 0, 0.18),
		transparent 28%),
		radial-gradient(circle at 86% 8%, rgba(255, 197, 98, 0.25),
		transparent 30%),
		radial-gradient(circle at 48% 50%, rgba(255, 241, 219, 0.85),
		transparent 42%),
		linear-gradient(135deg, #fffaf4 0%, #fff2df 44%, #f8fbff 100%);
}

a {
	text-decoration: none;
	color: inherit;
}

/* =========================
   Header
========================= */
.header {
	height: 64px;
	background: rgba(255, 255, 255, 0.88);
	border-bottom: 1px solid #e5e7eb;
	display: flex;
	align-items: center;
	padding: 0 36px;
	backdrop-filter: blur(12px);
	position: sticky;
	top: 0;
	z-index: 100;
}

.logo {
	font-size: 29px;
	font-weight: 900;
	letter-spacing: -1px;
	display: flex;
	align-items: center;
	gap: 7px;
	color: #111827;
}

.logo-icon {
	width: 25px;
	height: 31px;
	background: #ff6500;
	border-radius: 50% 50% 50% 0;
	transform: rotate(-45deg);
	display: inline-block;
	box-shadow: 0 8px 18px rgba(255, 101, 0, 0.25);
}

.nav {
	flex: 1;
	display: flex;
	justify-content: center;
	gap: 46px;
	font-size: 14px;
	font-weight: 800;
}

.nav a {
	color: #111827;
	transition: 0.2s;
	position: relative;
	padding: 21px 0;
}

.nav a:hover {
	color: #ff6500;
}

.nav a.active {
	color: #ff6500;
}

.nav a.active::after {
	content: "";
	position: absolute;
	left: 0;
	right: 0;
	bottom: 13px;
	height: 3px;
	border-radius: 999px;
	background: #ff6500;
	box-shadow: 0 5px 12px rgba(255, 101, 0, 0.24);
}

.header-actions {
	display: flex;
	align-items: center;
	justify-content: flex-end;
	gap: 10px;
	min-width: 260px;
}

.user-box {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	height: 40px;
	padding: 4px 6px 4px 12px;
	border-radius: 999px;
	background: rgba(255, 255, 255, 0.86);
	border: 1px solid rgba(229, 231, 235, 0.95);
	box-shadow: 0 10px 24px rgba(17, 24, 39, 0.06);
	white-space: nowrap;
}

.user-name {
	display: inline-flex;
	align-items: center;
	height: 28px;
	font-size: 13px;
	font-weight: 950;
	color: #111827;
	letter-spacing: -0.2px;
}

.role-badge {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 28px;
	padding: 0 11px;
	border-radius: 999px;
	font-size: 11px;
	font-weight: 950;
	letter-spacing: -0.2px;
	border: 1px solid transparent;
	line-height: 1;
}

.role-badge.admin {
	color: #ff6500;
	background: #fff3e8;
	border-color: rgba(255, 101, 0, 0.25);
	box-shadow: 0 7px 16px rgba(255, 101, 0, 0.10);
}

.role-badge.user {
	color: #374151;
	background: #f3f4f6;
	border-color: #e5e7eb;
}

.header-btn {
	height: 40px;
	border-radius: 12px;
	padding: 0 16px;
	font-weight: 900;
	font-size: 13px;
	transition: 0.2s;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	white-space: nowrap;
}

.header-login {
	background: #111827;
	color: #ffffff;
	box-shadow: 0 10px 22px rgba(17, 24, 39, 0.13);
}

.header-join {
	background: #ff6500;
	color: #ffffff;
	box-shadow: 0 10px 22px rgba(255, 101, 0, 0.18);
}

.header-admin {
	background: #fff3e8;
	color: #ff6500;
	border: 1px solid rgba(255, 101, 0, 0.26);
	box-shadow: 0 10px 22px rgba(255, 101, 0, 0.10);
}

.header-btn:hover {
	transform: translateY(-1px);
}

.main {
	min-height: calc(100vh - 64px);
}
</style>

<header class="header">

	<a href="${contextPath}/" class="logo"> PickEat <span
		class="logo-icon"></span>
	</a>

	<nav class="nav">

	<a href="${contextPath}/"
		class="${currentURI eq homeURI or currentURI eq contextPath ? 'active' : ''}">
		홈
	</a>

	<a href="${not empty sessionScope.loginMember ? recommendURI : loginURI}"
		class="${fn:contains(currentURI, '/recommend') ? 'active' : ''}">
		추천
	</a>

	<a href="${not empty sessionScope.loginMember ? restaurantsURI : loginURI}"
		class="${fn:contains(currentURI, '/restaurants') or fn:contains(currentURI, '/restaurant') ? 'active' : ''}">
		맛집 리스트
	</a>

	<a href="${not empty sessionScope.loginMember ? bookmarkURI : loginURI}"
		class="${fn:contains(currentURI, '/bookmark') ? 'active' : ''}">
		즐겨찾기
	</a>

	<a href="${not empty sessionScope.loginMember ? reviewURI : loginURI}"
		class="${fn:contains(currentURI, '/review') ? 'active' : ''}">
		리뷰
	</a>

	<c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.role ne 'ADMIN'}">
		<a href="${contextPath}/member/mypage?memberId=${sessionScope.loginMember.memberId}"
			class="${fn:contains(currentURI, '/member/mypage') ? 'active' : ''}">
			마이페이지
		</a>
	</c:if>

</nav>

	<div class="header-actions">

		<c:choose>

			<c:when test="${not empty sessionScope.loginMember}">

				<div class="user-box">
					<span class="user-name"> ${sessionScope.loginMember.name}님 </span>

					<c:choose>
						<c:when test="${sessionScope.loginMember.role eq 'ADMIN'}">
							<span class="role-badge admin"> 관리자 </span>
						</c:when>

						<c:otherwise>
							<span class="role-badge user"> 회원 </span>
						</c:otherwise>
					</c:choose>
				</div>

				<c:choose>
					<c:when test="${sessionScope.loginMember.role eq 'ADMIN'}">
						<a href="${contextPath}/admin" class="header-btn header-admin">
							관리자 </a>
					</c:when>

					<c:otherwise>
						<a href="${contextPath}/member/mypage"
							class="header-btn header-login"> 마이페이지 </a>
					</c:otherwise>
				</c:choose>

				<a href="${contextPath}/member/logout"
					class="header-btn header-join"> 로그아웃 </a>

			</c:when>

			<c:otherwise>

				<a href="${contextPath}/member/login"
					class="header-btn header-login"> 로그인 </a>

				<a href="${contextPath}/member/signup"
					class="header-btn header-join"> 회원가입 </a>

			</c:otherwise>

		</c:choose>

	</div>

</header>