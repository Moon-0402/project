<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 회원가입</title>

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: 'Noto Sans KR', Arial, sans-serif;
	color: #111827;
	background: radial-gradient(circle at 12% 18%, rgba(255, 101, 0, 0.16),
		transparent 30%),
		radial-gradient(circle at 86% 12%, rgba(255, 197, 98, 0.24),
		transparent 28%),
		radial-gradient(circle at 50% 100%, rgba(255, 238, 213, 0.9),
		transparent 36%),
		linear-gradient(135deg, #fffaf4 0%, #fff2df 44%, #f8fbff 100%);
	min-height: 100vh;
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
}

.nav a:hover {
	color: #ff6500;
}

.header-actions {
	display: flex;
	align-items: center;
	gap: 10px;
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
}

.header-login {
	background: #111827;
	color: #ffffff;
}

.header-join {
	background: #ff6500;
	color: #ffffff;
}

.header-btn:hover {
	transform: translateY(-1px);
}

/* =========================
   Signup Page
========================= */
.signup-page {
	min-height: calc(100vh - 64px);
	padding: 42px 24px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.signup-container {
	width: 100%;
	max-width: 1120px;
	min-height: 650px;
	display: grid;
	grid-template-columns: 0.95fr 1.05fr;
	border-radius: 32px;
	overflow: hidden;
	background: rgba(255, 255, 255, 0.74);
	border: 1px solid rgba(255, 255, 255, 0.95);
	box-shadow: 0 28px 80px rgba(255, 101, 0, 0.15);
	backdrop-filter: blur(18px);
	position: relative;
}

.signup-container::before {
	content: "";
	position: absolute;
	inset: 0;
	background-image: radial-gradient(rgba(255, 101, 0, 0.13) 1px,
		transparent 1px);
	background-size: 26px 26px;
	opacity: 0.32;
	pointer-events: none;
}

/* 왼쪽 설명 영역 */
.signup-visual {
	position: relative;
	z-index: 1;
	padding: 72px 56px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	overflow: hidden;
}

.visual-badge {
	display: inline-flex;
	width: fit-content;
	align-items: center;
	gap: 8px;
	padding: 9px 14px;
	border-radius: 999px;
	background: rgba(255, 255, 255, 0.82);
	border: 1px solid rgba(255, 101, 0, 0.18);
	color: #ff6500;
	font-size: 13px;
	font-weight: 950;
	box-shadow: 0 12px 30px rgba(255, 101, 0, 0.08);
	margin-bottom: 24px;
}

.signup-visual h1 {
	font-size: 44px;
	line-height: 1.22;
	letter-spacing: -1.8px;
	font-weight: 950;
	margin: 0 0 22px;
}

.signup-visual h1 span {
	color: #ff6500;
}

.signup-visual p {
	font-size: 16px;
	line-height: 1.85;
	color: #6b7280;
	margin: 0;
}

.visual-card {
	margin-top: 34px;
	padding: 18px;
	border-radius: 24px;
	background: rgba(255, 255, 255, 0.82);
	border: 1px solid rgba(255, 255, 255, 0.95);
	box-shadow: 0 18px 45px rgba(17, 24, 39, 0.07);
	width: 310px;
}

.visual-card-title {
	font-size: 14px;
	font-weight: 950;
	margin-bottom: 12px;
	color: #111827;
}

.visual-list {
	display: grid;
	gap: 10px;
}

.visual-item {
	display: flex;
	align-items: center;
	gap: 10px;
	font-size: 13px;
	font-weight: 800;
	color: #4b5563;
}

.visual-icon {
	width: 32px;
	height: 32px;
	border-radius: 12px;
	background: #fff3e8;
	display: inline-flex;
	align-items: center;
	justify-content: center;
}

.food-orbit {
	position: absolute;
	width: 500px;
	height: 500px;
	right: -150px;
	bottom: -150px;
	border-radius: 50%;
	background: radial-gradient(circle at 50% 52%, #ff7a00 0 16%, #fff 17% 29%, #ffd9aa
		30% 58%, rgba(255, 217, 170, 0.25) 59% 100%);
	opacity: 0.85;
	z-index: -1;
}

/* 오른쪽 폼 영역 */
.signup-form-area {
	position: relative;
	z-index: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 54px;
	background: linear-gradient(135deg, rgba(255, 245, 235, 0.76),
		rgba(255, 255, 255, 0.38));
}

.signup-card {
	width: 100%;
	max-width: 430px;
	padding: 36px 34px 32px;
	border-radius: 26px;
	background: rgba(255, 255, 255, 0.94);
	border: 1px solid rgba(229, 231, 235, 0.9);
	box-shadow: 0 22px 58px rgba(17, 24, 39, 0.12);
}

.signup-card h2 {
	margin: 0 0 8px;
	font-size: 28px;
	font-weight: 950;
	letter-spacing: -1px;
}

.signup-subtitle {
	margin: 0 0 24px;
	color: #6b7280;
	font-size: 13px;
	font-weight: 700;
	line-height: 1.6;
}

.message {
	padding: 11px 13px;
	margin-bottom: 15px;
	border-radius: 10px;
	font-size: 13px;
	font-weight: 800;
}

.error-message {
	background: #fff1f2;
	color: #e11d48;
	border: 1px solid #fecdd3;
}

.success-message {
	background: #ecfdf5;
	color: #15803d;
	border: 1px solid #bbf7d0;
}

.form-row {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 12px;
}

.form-group {
	margin-bottom: 14px;
}

.form-group label {
	display: block;
	margin-bottom: 7px;
	font-size: 12px;
	font-weight: 950;
	color: #374151;
}

.input-wrap {
	position: relative;
}

.input-icon {
	position: absolute;
	left: 14px;
	top: 50%;
	transform: translateY(-50%);
	color: #9ca3af;
	font-size: 14px;
}

.input-wrap input {
	width: 100%;
	height: 44px;
	border: 1px solid #d1d5db;
	border-radius: 11px;
	padding: 0 14px 0 40px;
	font-size: 13px;
	font-weight: 700;
	outline: none;
	background: #ffffff;
	transition: 0.2s;
}

.input-wrap input:focus {
	border-color: #ff6500;
	box-shadow: 0 0 0 4px rgba(255, 101, 0, 0.11);
}

.helper-text {
	margin-top: 6px;
	font-size: 11px;
	color: #9ca3af;
	font-weight: 700;
	line-height: 1.5;
}

.terms-box {
	margin: 4px 0 20px;
	padding: 13px 14px;
	border-radius: 14px;
	background: #f9fafb;
	border: 1px solid #eef2f7;
}

.check-label {
	display: flex;
	align-items: flex-start;
	gap: 8px;
	font-size: 12px;
	font-weight: 800;
	color: #4b5563;
	line-height: 1.5;
	cursor: pointer;
}

.check-label input {
	margin-top: 3px;
	accent-color: #ff6500;
}

.signup-btn {
	width: 100%;
	height: 46px;
	border: none;
	border-radius: 12px;
	background: #ff6500;
	color: white;
	font-size: 14px;
	font-weight: 950;
	cursor: pointer;
	box-shadow: 0 16px 34px rgba(255, 101, 0, 0.24);
	transition: 0.2s;
}

.signup-btn:hover {
	background: #f05f00;
	transform: translateY(-1px);
}

.login-link {
	margin-top: 20px;
	text-align: center;
	font-size: 13px;
	color: #6b7280;
	font-weight: 700;
}

.login-link a {
	color: #ff6500;
	font-weight: 950;
	margin-left: 5px;
}

/* =========================
   Responsive
========================= */
@media ( max-width : 980px) {
	.nav {
		display: none;
	}
	.signup-container {
		grid-template-columns: 1fr;
	}
	.signup-visual {
		padding: 48px 34px 28px;
	}
	.signup-visual h1 {
		font-size: 36px;
	}
	.visual-card {
		width: 100%;
		max-width: 360px;
	}
	.food-orbit {
		width: 360px;
		height: 360px;
		right: -120px;
		bottom: -140px;
	}
	.signup-form-area {
		padding: 30px;
	}
}

@media ( max-width : 560px) {
	.header {
		padding: 0 18px;
	}
	.header-actions {
		display: none;
	}
	.signup-page {
		padding: 24px 14px;
	}
	.signup-visual {
		padding: 38px 24px 20px;
	}
	.signup-visual h1 {
		font-size: 30px;
	}
	.signup-form-area {
		padding: 22px;
	}
	.signup-card {
		padding: 28px 22px;
	}
	.form-row {
		grid-template-columns: 1fr;
		gap: 0;
	}
}
</style>
</head>

<body>

	<%@ include file = "/WEB-INF/views/header.jsp" %>

	<main class="signup-page">

		<section class="signup-container">

			<div class="signup-visual">
				<div class="visual-badge">🍽️ Join PickEat</div>

				<h1>
					취향을 담으면<br> 오늘의 맛집이<br> <span>더 정확해져요.</span>
				</h1>

				<p>
					회원가입 후 선호 음식, 가격대, 상황 정보를 바탕으로<br> 날씨에 딱 맞는 맛집 추천을 받아보세요.
				</p>

				<div class="visual-card">
					<div class="visual-card-title">PickEat 회원 혜택</div>

					<div class="visual-list">
						<div class="visual-item">
							<span class="visual-icon">🌦️</span> <span>날씨 기반 맞춤 추천</span>
						</div>

						<div class="visual-item">
							<span class="visual-icon">📍</span> <span>현재 위치 주변 맛집 탐색</span>
						</div>

						<div class="visual-item">
							<span class="visual-icon">🧡</span> <span>취향 저장 및 개인화 추천</span>
						</div>
					</div>
				</div>

				<div class="food-orbit"></div>
			</div>

			<div class="signup-form-area">
				<div class="signup-card">

					<h2>회원가입</h2>
					<p class="signup-subtitle">PickEat 계정을 만들고 오늘의 맛집을 추천받아보세요.</p>

					<c:if test="${not empty errorMessage}">
						<div class="message error-message">${errorMessage}</div>
					</c:if>

					<c:if test="${not empty successMessage}">
						<div class="message success-message">${successMessage}</div>
					</c:if>

					<form action="${contextPath}/member/signup" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />

						<div class="form-group">
							<label for="id">아이디</label>
							<div class="input-wrap">
								<span class="input-icon">👤</span> <input type="text" id="id"
									name="id" placeholder="아이디를 입력해주세요" required>
							</div>
							<div class="helper-text">영문, 숫자 조합으로 입력해주세요.</div>
						</div>

						<div class="form-group">
							<label for="pw">비밀번호</label>
							<div class="input-wrap">
								<span class="input-icon">🔒</span> <input type="password"
									id="pw" name="pw" placeholder="비밀번호를 입력해주세요" required>
							</div>
						</div>

						<div class="form-group">
							<label for="pwCheck">비밀번호 확인</label>
							<div class="input-wrap">
								<span class="input-icon">✅</span> <input type="password"
									id="pwCheck" name="pwCheck" placeholder="비밀번호를 다시 입력해주세요"
									required>
							</div>
						</div>

						<div class="form-row">
							<div class="form-group">
								<label for="name">이름</label>
								<div class="input-wrap">
									<span class="input-icon">📝</span> <input type="text" id="name"
										name="name" placeholder="이름" required>
								</div>
							</div>

							<div class="form-group">
								<label for="phone">전화번호</label>
								<div class="input-wrap">
									<span class="input-icon">📱</span> <input type="text"
										id="phone" name="phone" placeholder="010-0000-0000" required>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="email">이메일</label>
							<div class="input-wrap">
								<span class="input-icon">✉️</span> <input type="email"
									id="email" name="email" placeholder="example@email.com"
									required>
							</div>
						</div>

						<div class="terms-box">
							<label class="check-label" for="termsAgree"> <input
								type="checkbox" id="termsAgree" name="termsAgree" value="true"
								required> <span>PickEat 서비스 이용약관 및 개인정보 처리방침에
									동의합니다.</span>
							</label>
						</div>

						<button type="submit" class="signup-btn">회원가입</button>
					</form>

					<div class="login-link">
						이미 계정이 있으신가요? <a href="${contextPath}/member/login">로그인</a>
					</div>

				</div>
			</div>

		</section>

	</main>
	<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>