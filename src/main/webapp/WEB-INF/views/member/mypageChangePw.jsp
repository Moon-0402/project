<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat | 마이페이지 비밀번호 변경</title>

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

.page-wrap {
    min-height: 100vh;
    display: flex;
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

.menu-list a:hover,
.menu-list a.active {
    background: #ff914d;
    color: #fff;
    box-shadow: 0 8px 18px rgba(255, 145, 77, 0.35);
}

.main {
    flex: 1;
    padding: 42px 54px;
}

.top-bar {
    margin-bottom: 34px;
}

.page-title h1 {
    font-size: 32px;
    color: #2f241d;
    margin-bottom: 8px;
}

.page-title p {
    color: #7a6a5d;
    font-size: 15px;
    line-height: 1.6;
}

.form-wrap {
    max-width: 650px;
}

.form-card {
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 28px;
    box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
    padding: 34px;
}

.section-title {
    font-size: 21px;
    color: #2f241d;
    margin-bottom: 24px;
    display: flex;
    align-items: center;
    gap: 10px;
}

.section-title::before {
    content: "";
    width: 8px;
    height: 24px;
    background: #ff914d;
    border-radius: 999px;
}

.message {
    border-radius: 16px;
    padding: 14px 16px;
    margin-bottom: 18px;
    font-size: 14px;
    font-weight: 800;
}

.error-message {
    background: #fee2e2;
    color: #b91c1c;
    border: 1px solid #fecaca;
}

.success-message {
    background: #dcfce7;
    color: #15803d;
    border: 1px solid #bbf7d0;
}

.form-item {
    background: #fffaf3;
    border: 1px solid #f4d7b7;
    border-radius: 18px;
    padding: 18px 20px;
    margin-bottom: 16px;
}

.form-label {
    display: block;
    font-size: 13px;
    color: #a27755;
    margin-bottom: 9px;
    font-weight: 900;
}

.form-input {
    width: 100%;
    border: 1px solid #e8c7a6;
    background: #fff;
    border-radius: 13px;
    padding: 13px 14px;
    font-size: 15px;
    color: #2f241d;
    outline: none;
}

.form-input:focus {
    border-color: #ff914d;
    box-shadow: 0 0 0 4px rgba(255, 145, 77, 0.16);
}

.help-text {
    margin-top: 8px;
    font-size: 12px;
    color: #9b8170;
    line-height: 1.5;
}

.notice-box {
    margin-top: 20px;
    padding: 16px;
    border-radius: 18px;
    background: #fff7ed;
    border: 1px solid #fed7aa;
    color: #9a521e;
    font-size: 13px;
    line-height: 1.6;
}

.button-area {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    margin-top: 28px;
    padding-top: 24px;
    border-top: 1px solid #f1d4b7;
}

.btn {
    border: none;
    border-radius: 14px;
    padding: 13px 20px;
    font-size: 14px;
    font-weight: 900;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
    font-family: inherit;
    transition: 0.2s;
}

.btn-list {
    background: #f3e7dc;
    color: #5f4a3a;
}

.btn-list:hover {
    background: #e7d2bd;
}

.btn-save {
    background: #ff914d;
    color: #fff;
    box-shadow: 0 8px 20px rgba(255, 145, 77, 0.32);
}

.btn-save:hover {
    background: #f97316;
    transform: translateY(-1px);
}

@media (max-width: 900px) {
    .page-wrap {
        display: block;
    }

    .sidebar {
        width: 100%;
    }

    .main {
        padding: 28px 20px;
    }

    .button-area {
        flex-direction: column;
    }

    .btn {
        width: 100%;
        text-align: center;
    }
}
</style>
</head>

<body>

<div class="page-wrap">

    <aside class="sidebar">
        <div class="logo-box">
            <a href="${pageContext.request.contextPath}/" class="logo-link">
                <div class="logo">Pick<span>Eat</span></div>
            </a>
            <div class="logo-desc">날씨와 상황에 맞는 맛집 추천 서비스</div>
        </div>

        <div class="menu-title">My Menu</div>
        <ul class="menu-list">
            <li><a href="${pageContext.request.contextPath}/">메인 페이지</a></li>
            <li><a href="${pageContext.request.contextPath}/member/mypage">내 정보 수정</a></li>
            <li><a href="${pageContext.request.contextPath}/member/mypage/changePw" class="active">비밀번호 변경</a></li>
            <li><a href="${pageContext.request.contextPath}/member/inquiry/write">문의하기</a></li>
            <li><a href="${pageContext.request.contextPath}/member/inquiries">문의 내역</a></li>
            <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
        </ul>
    </aside>

    <main class="main">

        <div class="top-bar">
            <div class="page-title">
                <h1>비밀번호 변경</h1>
            </div>
        </div>

        <div class="form-wrap">
            <section class="form-card">
                <h2 class="section-title">비밀번호 정보 입력</h2>

                <c:if test="${not empty errorMessage}">
                    <div class="message error-message">
                        ${errorMessage}
                    </div>
                </c:if>

                <c:if test="${not empty successMessage}">
                    <div class="message success-message">
                        ${successMessage}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/member/mypage/changePw"
                      method="post"
                      onsubmit="return confirm('비밀번호를 변경하시겠습니까?');">

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                    <div class="form-item">
                        <label for="currentPw" class="form-label">현재 비밀번호</label>
                        <input type="password"
                               id="currentPw"
                               name="currentPw"
                               class="form-input"
                               placeholder="현재 비밀번호를 입력하세요"
                               required>
                    </div>

                    <div class="form-item">
                        <label for="newPw" class="form-label">새 비밀번호</label>
                        <input type="password"
                               id="newPw"
                               name="newPw"
                               class="form-input"
                               placeholder="새 비밀번호를 입력하세요"
                               required>
                    </div>

                    <div class="form-item">
                        <label for="newPwCheck" class="form-label">새 비밀번호 확인</label>
                        <input type="password"
                               id="newPwCheck"
                               name="newPwCheck"
                               class="form-input"
                               placeholder="새 비밀번호를 한 번 더 입력하세요"
                               required>
                    </div>

                    <div class="button-area">
                        <a href="${pageContext.request.contextPath}/member/mypage" class="btn btn-list">
                            내 정보로
                        </a>

                        <button type="submit" class="btn btn-save">
                            비밀번호 변경
                        </button>
                    </div>

                </form>
            </section>
        </div>

    </main>
</div>

</body>
</html>