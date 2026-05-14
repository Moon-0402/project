<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat | 마이페이지 정보 수정</title>

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
    line-height: 1.6;
}

.badge {
    background: rgba(255, 255, 255, 0.75);
    border: 1px solid rgba(255, 184, 107, 0.45);
    color: #a15c22;
    padding: 10px 15px;
    border-radius: 999px;
    font-size: 13px;
    font-weight: 900;
    white-space: nowrap;
}

.content-grid {
    display: grid;
    grid-template-columns: 320px 1fr;
    gap: 28px;
}

.profile-card,
.form-card {
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 28px;
    box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
}

.profile-card {
    padding: 32px 26px;
    text-align: center;
    height: fit-content;
}

.member-name {
    font-size: 25px;
    font-weight: 900;
    color: #2f241d;
    margin-bottom: 8px;
}

.member-login-id {
    font-size: 14px;
    color: #8a7666;
    margin-bottom: 18px;
}

.role-badge {
    display: inline-block;
    padding: 8px 16px;
    border-radius: 999px;
    background: #fff3df;
    color: #d97706;
    font-weight: 900;
    font-size: 13px;
    margin-bottom: 22px;
}

.mini-info {
    border-top: 1px dashed #e7c9a8;
    padding-top: 20px;
    margin-top: 10px;
    text-align: left;
}

.mini-info p {
    font-size: 14px;
    color: #6f5f52;
    margin-bottom: 12px;
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
    text-align: left;
}

.form-card {
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

.form-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 18px;
}

.form-item {
    background: #fffaf3;
    border: 1px solid #f4d7b7;
    border-radius: 18px;
    padding: 18px 20px;
}

.form-item.full {
    grid-column: 1 / 3;
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

.readonly-input,
.readonly-box {
    width: 100%;
    border: 1px solid #e8c7a6;
    background: #f5eee7;
    border-radius: 13px;
    padding: 13px 14px;
    font-size: 15px;
    color: #7a6a5d;
    font-weight: 900;
}

.help-text {
    margin-top: 8px;
    font-size: 12px;
    color: #9b8170;
    line-height: 1.5;
}

.button-area {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    margin-top: 32px;
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

.empty-box {
    background: #fff;
    border-radius: 24px;
    padding: 50px;
    text-align: center;
    color: #8a7666;
    box-shadow: 0 14px 35px rgba(90, 64, 43, 0.12);
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

    .top-bar {
        display: block;
    }

    .badge {
        display: inline-block;
        margin-top: 16px;
    }

    .content-grid,
    .form-grid {
        grid-template-columns: 1fr;
    }

    .form-item.full {
        grid-column: 1;
    }

    .button-area {
        flex-direction: column;
    }

    .btn {
        text-align: center;
        width: 100%;
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
            <li><a href="${pageContext.request.contextPath}/member/mypage?memberId=${member.memberId}" class="active">내 정보 수정</a></li>
            <li><a href="${pageContext.request.contextPath}/member/mypage/changePw">비밀번호 변경</a></li>
            <li><a href="${pageContext.request.contextPath}/member/inquiry/write">문의하기</a></li>
            <li><a href="${pageContext.request.contextPath}/member/inquiries">문의 내역</a></li>
            <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
        </ul>
    </aside>

    <main class="main">

        <c:choose>
            <c:when test="${not empty member}">

                <div class="top-bar">
                    <div class="page-title">
                        <h1>내 정보 수정</h1>
                    </div>

                    <div class="badge">
                        회원번호 ${member.memberId}
                    </div>
                </div>

                <div class="content-grid">

                    <section class="profile-card">
                        <div class="member-name">${member.name}</div>
                        <div class="member-login-id">@${member.loginId}</div>

                        <div class="role-badge">${member.role}</div>

                        <div class="mini-info">
                            <p><strong>회원번호</strong><br>${member.memberId}</p>
                            <p><strong>가입일</strong><br>${member.created_at}</p>
                        </div>

                    </section>

                    <section class="form-card">
                        <h2 class="section-title">수정 정보 입력</h2>

                        <form action="${pageContext.request.contextPath}/member/mypage?memberId=${member.memberId}"
                              method="post"
                              onsubmit="return confirm('회원 정보를 수정하시겠습니까?');">

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                            <div class="form-grid">

                                <div class="form-item">
                                    <label class="form-label">회원번호</label>
                                    <input type="text" class="readonly-input" value="${member.memberId}" readonly>
                                </div>

                                <div class="form-item">
                                    <label class="form-label">로그인 ID</label>
                                    <input type="text" class="readonly-input" value="${member.loginId}" readonly>
                                </div>

                                <div class="form-item">
                                    <label class="form-label">권한</label>
                                    <div class="readonly-box">${member.role}</div>
                                </div>

                                <div class="form-item">
                                    <label class="form-label">가입일</label>
                                    <input type="text" class="readonly-input" value="${member.created_at}" readonly>
                                </div>

                                <div class="form-item">
                                    <label for="name" class="form-label">이름</label>
                                    <input type="text"
                                           id="name"
                                           name="name"
                                           class="form-input"
                                           value="${member.name}"
                                           required>
                                </div>

                                <div class="form-item">
                                    <label for="email" class="form-label">이메일</label>
                                    <input type="email"
                                           id="email"
                                           name="email"
                                           class="form-input"
                                           value="${member.email}"
                                           required>
                                </div>

                                <div class="form-item full">
                                    <label for="phone" class="form-label">전화번호</label>
                                    <input type="text"
                                           id="phone"
                                           name="phone"
                                           class="form-input"
                                           value="${member.phone}"
                                           placeholder="010-0000-0000">
                                </div>

                            </div>

                            <div class="button-area">
                                <a href="${pageContext.request.contextPath}/" class="btn btn-list">
                                    홈으로
                                </a>

                                <button type="submit" class="btn btn-save">
                                    수정 완료
                                </button>
                            </div>

                        </form>
                    </section>

                </div>

            </c:when>

            <c:otherwise>
                <div class="empty-box">
                    <h2>회원 정보를 찾을 수 없습니다.</h2>
                    <p style="margin-top: 12px;">memberId 값으로 조회된 회원 데이터가 없습니다.</p>

                    <div style="margin-top: 28px;">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-list">
                            홈으로 돌아가기
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </main>
</div>

</body>
</html>