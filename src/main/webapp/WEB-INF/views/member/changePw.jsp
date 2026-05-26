<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 비밀번호 재설정</title>

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: 'Noto Sans KR', Arial, sans-serif;
	color: #111827;
	background:
		radial-gradient(circle at 12% 18%, rgba(255, 101, 0, 0.16), transparent 30%),
		radial-gradient(circle at 86% 12%, rgba(255, 197, 98, 0.24), transparent 28%),
		radial-gradient(circle at 50% 100%, rgba(255, 238, 213, 0.9), transparent 36%),
		linear-gradient(135deg, #fffaf4 0%, #fff2df 44%, #f8fbff 100%);
	min-height: 100vh;
}

a {
	text-decoration: none;
	color: inherit;
}

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

.reset-page {
	min-height: calc(100vh - 64px);
	padding: 42px 24px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.reset-container {
	width: 100%;
	max-width: 980px;
	min-height: 540px;
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

.reset-container::before {
	content: "";
	position: absolute;
	inset: 0;
	background-image: radial-gradient(rgba(255, 101, 0, 0.13) 1px, transparent 1px);
	background-size: 26px 26px;
	opacity: 0.32;
	pointer-events: none;
}

.reset-visual {
	position: relative;
	z-index: 1;
	padding: 70px 54px;
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

.reset-visual h1 {
	font-size: 42px;
	line-height: 1.22;
	letter-spacing: -1.8px;
	font-weight: 950;
	margin: 0 0 22px;
}

.reset-visual h1 span {
	color: #ff6500;
}

.reset-visual p {
	font-size: 16px;
	line-height: 1.85;
	color: #6b7280;
	margin: 0;
}

.food-orbit {
	position: absolute;
	width: 460px;
	height: 460px;
	right: -160px;
	bottom: -160px;
	border-radius: 50%;
	background:
		radial-gradient(circle at 50% 52%, #ff7a00 0 16%, #fff 17% 29%, #ffd9aa 30% 58%, rgba(255, 217, 170, 0.25) 59% 100%);
	opacity: 0.85;
	z-index: -1;
}

.reset-form-area {
	position: relative;
	z-index: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 54px;
	background: linear-gradient(135deg, rgba(255, 245, 235, 0.76), rgba(255, 255, 255, 0.38));
}

.reset-card {
	width: 100%;
	max-width: 400px;
	padding: 38px 34px 34px;
	border-radius: 26px;
	background: rgba(255, 255, 255, 0.94);
	border: 1px solid rgba(229, 231, 235, 0.9);
	box-shadow: 0 22px 58px rgba(17, 24, 39, 0.12);
}

.reset-card h2 {
	margin: 0 0 8px;
	font-size: 28px;
	font-weight: 950;
	letter-spacing: -1px;
}

.reset-subtitle {
	margin: 0 0 24px;
	color: #6b7280;
	font-size: 13px;
	font-weight: 700;
	line-height: 1.6;
}

.message {
	padding: 12px 14px;
	margin-bottom: 16px;
	border-radius: 12px;
	font-size: 13px;
	font-weight: 800;
	line-height: 1.6;
}

.error-message {
	background: #fff1f2;
	color: #e11d48;
	border: 1px solid #fecdd3;
}

.form-group {
	margin-bottom: 15px;
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
	height: 45px;
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
	margin-top: 7px;
	font-size: 11px;
	color: #9ca3af;
	font-weight: 700;
	line-height: 1.5;
}

.reset-btn {
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
	margin-top: 4px;
}

.reset-btn:hover {
	background: #f05f00;
	transform: translateY(-1px);
}

.link-row {
	margin-top: 22px;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 12px;
	font-size: 13px;
	font-weight: 850;
	color: #6b7280;
}

.link-row a {
	color: #ff6500;
	font-weight: 950;
}

@media (max-width: 980px) {
	.nav {
		display: none;
	}

	.reset-container {
		grid-template-columns: 1fr;
	}

	.reset-visual {
		padding: 48px 34px 28px;
	}

	.reset-visual h1 {
		font-size: 36px;
	}

	.food-orbit {
		width: 360px;
		height: 360px;
		right: -120px;
		bottom: -140px;
	}

	.reset-form-area {
		padding: 30px;
	}
}

@media (max-width: 560px) {
	.header {
		padding: 0 18px;
	}

	.header-actions {
		display: none;
	}

	.reset-page {
		padding: 24px 14px;
	}

	.reset-visual {
		padding: 38px 24px 20px;
	}

	.reset-visual h1 {
		font-size: 30px;
	}

	.reset-form-area {
		padding: 22px;
	}

	.reset-card {
		padding: 28px 22px;
	}
}
</style>
</head>

<body>

<%@ include file = "/WEB-INF/views/header.jsp" %>

<main class="reset-page">

	<section class="reset-container">

		<div class="reset-visual">
			<div class="visual-badge">
				🔑 Reset PickEat Password
			</div>

			<h1>
				새 비밀번호로<br>
				계정을 다시<br>
				<span>열어볼까요?</span>
			</h1>

			<p>
				새 비밀번호를 입력하면 기존 비밀번호가 변경됩니다.<br>
				변경 후에는 다시 로그인해주세요.
			</p>

			<div class="food-orbit"></div>
		</div>

		<div class="reset-form-area">
			<div class="reset-card">

				<h2>비밀번호 재설정</h2>
				<p class="reset-subtitle">
					앞으로 사용할 새 비밀번호를 입력해주세요.
				</p>

				<c:if test="${not empty errorMessage}">
					<div class="message error-message">
						${errorMessage}
					</div>
				</c:if>

				<form action="${contextPath}/member/changePw" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

					<div class="form-group">
						<label for="pw">새 비밀번호</label>
						<div class="input-wrap">
							<span class="input-icon">🔒</span>
							<input type="password" id="pw" name="pw" placeholder="새 비밀번호를 입력해주세요" required>
						</div>
						<div class="helper-text">
							영문, 숫자 조합을 권장합니다.
						</div>
					</div>

					<div class="form-group">
						<label for="pwCheck">새 비밀번호 확인</label>
						<div class="input-wrap">
							<span class="input-icon">✅</span>
							<input type="password" id="pwCheck" name="pwCheck" placeholder="새 비밀번호를 다시 입력해주세요" required>
						</div>
					</div>

					<button type="submit" class="reset-btn">비밀번호 변경</button>
				</form>

				<div class="link-row">
					<a href="${contextPath}/member/login">로그인으로 돌아가기</a>
				</div>

			</div>
		</div>

	</section>

</main>
	<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>