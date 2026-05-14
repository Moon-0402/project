<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>픽잇 로그인</title>

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: 'Noto Sans KR', Arial, sans-serif;
	color: #111827;
	background: radial-gradient(circle at 12% 20%, rgba(255, 122, 0, 0.18),
		transparent 28%),
		radial-gradient(circle at 85% 15%, rgba(255, 183, 77, 0.24),
		transparent 26%),
		radial-gradient(circle at 50% 100%, rgba(255, 238, 213, 0.95),
		transparent 34%),
		linear-gradient(135deg, #fffaf4 0%, #fff3e4 45%, #f8fbff 100%);
}

a {
	text-decoration: none;
	color: inherit;
}

.header {
	height: 58px;
	background: rgba(255, 255, 255, 0.88);
	border-bottom: 1px solid #e5e7eb;
	display: flex;
	align-items: center;
	padding: 0 32px;
	backdrop-filter: blur(12px);
	position: sticky;
	top: 0;
	z-index: 20;
}

.logo {
	font-size: 27px;
	font-weight: 900;
	letter-spacing: -1px;
	color: #111827;
	display: flex;
	align-items: center;
	gap: 6px;
}

.logo-icon {
	width: 24px;
	height: 30px;
	background: #ff6500;
	border-radius: 50% 50% 50% 0;
	transform: rotate(-45deg);
	display: inline-block;
}

.nav {
	flex: 1;
	display: flex;
	justify-content: center;
	gap: 52px;
	font-size: 14px;
	font-weight: 800;
}

.nav a {
	color: #111827;
}

.nav a:hover {
	color: #ff6500;
}

.header-actions {
	display: flex;
	gap: 10px;
	align-items: center;
}

.header-btn {
	border: none;
	border-radius: 8px;
	padding: 10px 17px;
	font-weight: 800;
	font-size: 13px;
	cursor: pointer;
}

.login-header-btn {
	background: #111827;
	color: white;
}

.join-header-btn {
	background: #ff6500;
	color: white;
}

.login-page {
	min-height: calc(100vh - 58px);
	padding: 28px 24px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.login-container {
	width: 100%;
	max-width: 1160px;
	min-height: 620px;
	display: grid;
	grid-template-columns: 1.1fr 0.9fr;
	overflow: hidden;
	border-radius: 28px;
	background: rgba(255, 255, 255, 0.72);
	border: 1px solid rgba(255, 255, 255, 0.9);
	box-shadow: 0 24px 70px rgba(255, 112, 0, 0.13);
	backdrop-filter: blur(18px);
	position: relative;
}

.login-container::before {
	content: "";
	position: absolute;
	inset: 0;
	background-image: radial-gradient(rgba(255, 112, 0, 0.16) 1px,
		transparent 1px);
	background-size: 26px 26px;
	opacity: 0.32;
	pointer-events: none;
}

.login-visual {
	position: relative;
	padding: 88px 64px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	overflow: hidden;
	z-index: 1;
}

.login-visual h1 {
	font-size: 43px;
	line-height: 1.25;
	margin: 0 0 22px;
	font-weight: 900;
	letter-spacing: -1.6px;
}

.login-visual h1 span {
	color: #ff6500;
}

.login-visual p {
	font-size: 17px;
	line-height: 1.8;
	color: #6b7280;
	margin: 0;
}

.food-glow {
	position: absolute;
	width: 520px;
	height: 520px;
	right: -80px;
	bottom: -120px;
	border-radius: 50%;
	background: radial-gradient(circle at 50% 52%, #ff7a00 0 18%, #fff 19% 31%, #ffd9aa
		32% 58%, rgba(255, 217, 170, 0.28) 59% 100%);
	opacity: 0.9;
	z-index: -1;
}

.food-glow::before {
	content: "";
	position: absolute;
	width: 28px;
	height: 28px;
	top: 210px;
	left: 205px;
	border-radius: 50%;
	background: #ffb84d;
	box-shadow: 70px 24px 0 #ff6500, 140px -8px 0 #3b2a20;
}

.mini-card {
	position: absolute;
	left: 64px;
	bottom: 72px;
	padding: 14px 18px;
	border-radius: 18px;
	background: rgba(255, 255, 255, 0.78);
	box-shadow: 0 14px 34px rgba(31, 41, 55, 0.08);
	border: 1px solid rgba(255, 255, 255, 0.85);
	color: #374151;
	font-size: 14px;
}

.mini-card strong {
	color: #ff6500;
}

.login-form-area {
	position: relative;
	z-index: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 56px;
	background: linear-gradient(135deg, rgba(255, 245, 235, 0.75),
		rgba(255, 255, 255, 0.35));
}

.login-card {
	width: 100%;
	max-width: 370px;
	padding: 36px 32px 30px;
	border-radius: 22px;
	background: rgba(255, 255, 255, 0.93);
	box-shadow: 0 20px 55px rgba(17, 24, 39, 0.12);
	border: 1px solid rgba(229, 231, 235, 0.9);
}

.login-card h2 {
	margin: 0 0 20px;
	font-size: 26px;
	font-weight: 900;
	letter-spacing: -1px;
}

.input-group {
	position: relative;
	margin-bottom: 12px;
}

.input-group input {
	width: 100%;
	height: 44px;
	border: 1px solid #d1d5db;
	border-radius: 8px;
	padding: 0 14px 0 40px;
	font-size: 13px;
	outline: none;
	background: white;
}

.input-group input:focus {
	border-color: #ff6500;
	box-shadow: 0 0 0 3px rgba(255, 101, 0, 0.12);
}

.input-icon {
	position: absolute;
	left: 14px;
	top: 50%;
	transform: translateY(-50%);
	color: #9ca3af;
	font-size: 15px;
}

.remember-row {
	display: flex;
	align-items: center;
	gap: 6px;
	margin: 6px 0 20px;
	color: #6b7280;
	font-size: 12px;
}

.remember-row input {
	width: 13px;
	height: 13px;
}

.login-btn {
	width: 100%;
	height: 44px;
	border: none;
	border-radius: 8px;
	background: #ff6500;
	color: white;
	font-size: 14px;
	font-weight: 900;
	cursor: pointer;
}

.login-btn:hover {
	background: #f05f00;
}

.find-links {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 14px;
	margin: 16px 0 24px;
	font-size: 12px;
	font-weight: 800;
	color: #2563eb;
}

.find-links span {
	color: #d1d5db;
}

.line {
	height: 1px;
	background: #e5e7eb;
	margin: 0 0 20px;
}

.join-row {
	text-align: center;
	font-size: 12px;
	color: #6b7280;
	margin-bottom: 24px;
}

.join-row a {
	color: #ff6500;
	font-weight: 900;
	margin-left: 6px;
}

.or-box {
	display: flex;
	align-items: center;
	gap: 14px;
	color: #9ca3af;
	font-size: 12px;
	margin-bottom: 18px;
}

.or-box::before, .or-box::after {
	content: "";
	flex: 1;
	height: 1px;
	background: #e5e7eb;
}

.kakao-btn {
	width: 100%;
	height: 42px;
	border: 1px solid #d1d5db;
	border-radius: 8px;
	background: #ffffff;
	color: #111827;
	font-size: 13px;
	font-weight: 900;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 9px;
}

.kakao-btn:hover {
	background: #fff7d6;
	border-color: #fee500;
}

.kakao-icon {
	width: 20px;
	height: 20px;
	border-radius: 50%;
	background: #fee500;
	color: #111827;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	font-size: 11px;
	font-weight: 900;
}

.message {
	padding: 10px 12px;
	margin-bottom: 14px;
	border-radius: 8px;
	font-size: 13px;
	background: #fff1f2;
	color: #e11d48;
	border: 1px solid #fecdd3;
}

@media ( max-width : 900px) {
	.header {
		padding: 0 18px;
	}
	.nav {
		display: none;
	}
	.login-container {
		grid-template-columns: 1fr;
	}
	.login-visual {
		padding: 52px 32px 34px;
	}
	.login-visual h1 {
		font-size: 34px;
	}
	.food-glow {
		width: 360px;
		height: 360px;
		right: -90px;
		bottom: -120px;
	}
	.mini-card {
		display: none;
	}
	.login-form-area {
		padding: 28px;
	}
}
</style>
</head>

<body>

	<%@ include file = "/WEB-INF/views/header.jsp" %>

	<main class="login-page">
		<section class="login-container">

			<div class="login-visual">
				<h1>
					오늘 뭐 먹지?<br> <span>픽잇이</span><br> 골라드릴게요!
				</h1>

				<p>
					날씨와 취향을 분석해<br> 지금 딱 맞는 맛집을 추천해드려요.
				</p>

				<div class="mini-card">
					☀️ 오늘 날씨 기준 <strong>추천 맛집</strong> 준비 완료
				</div>

				<div class="food-glow"></div>
			</div>

			<div class="login-form-area">
				<div class="login-card">
					<h2>로그인</h2>

					<c:if test="${not empty errorMessage}">
						<div class="message">${errorMessage}</div>
					</c:if>

					<form action="${contextPath}/member/login" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />

						<div class="input-group">
							<span class="input-icon">✉</span> <input type="text" name="id"
								placeholder="아이디를 입력해주세요" required>
						</div>

						<div class="input-group">
							<span class="input-icon">🔒</span> <input type="password"
								name="pw" placeholder="비밀번호를 입력해주세요" required>
						</div>

						<button type="submit" class="login-btn">로그인</button>
					</form>

					<div class="find-links">
						<a href="${contextPath}/member/findId">아이디 찾기</a> <span>|</span> <a
							href="${contextPath}/member/findPw">비밀번호 찾기</a>
					</div>

					<div class="line"></div>

					<div class="join-row">
						계정이 없으신가요? <a href="${contextPath}/member/signup">회원가입</a>
					</div>

					<div class="or-box">또는</div>

					<a class="kakao-login-btn"
						href="${pageContext.request.contextPath}/member/kakao/login">
						카카오 로그인 </a>
				</div>
			</div>

		</section>
	</main>
	<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>