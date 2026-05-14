<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat | 문의 작성</title>

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

/* 왼쪽 배너 / 사이드바 */
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

/* 오른쪽 메인 */
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

.content-grid {
    display: grid;
    grid-template-columns: minmax(420px, 720px) 320px;
    gap: 24px;
    align-items: start;
}

.form-wrap {
    max-width: 720px;
}

.form-card,
.guide-card,
.quick-card {
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

.form-input,
.form-textarea {
    width: 100%;
    border: 1px solid #e8c7a6;
    background: #fff;
    border-radius: 13px;
    padding: 13px 14px;
    font-size: 15px;
    color: #2f241d;
    outline: none;
    font-family: inherit;
}

.form-input:focus,
.form-textarea:focus {
    border-color: #ff914d;
    box-shadow: 0 0 0 4px rgba(255, 145, 77, 0.16);
}

.form-textarea {
    min-height: 260px;
    resize: vertical;
    line-height: 1.7;
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

.btn-submit {
    background: #ff914d;
    color: #fff;
    box-shadow: 0 8px 20px rgba(255, 145, 77, 0.32);
}

.btn-submit:hover {
    background: #f97316;
    transform: translateY(-1px);
}

/* 오른쪽 카드 */
.guide-card {
    padding: 28px;
    margin-bottom: 18px;
}

.guide-icon {
    width: 72px;
    height: 72px;
    border-radius: 24px;
    background: linear-gradient(135deg, #ff914d, #ffb86b);
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 34px;
    box-shadow: 0 12px 24px rgba(255, 145, 77, 0.24);
    margin-bottom: 18px;
}

.guide-title {
    font-size: 23px;
    font-weight: 900;
    color: #2f241d;
    margin-bottom: 8px;
}

.guide-desc {
    font-size: 14px;
    color: #7a6a5d;
    line-height: 1.6;
}

.guide-info {
    margin-top: 20px;
    border-top: 1px solid #f1d4b7;
    padding-top: 18px;
}

.info-row {
    display: flex;
    justify-content: space-between;
    gap: 12px;
    margin-bottom: 12px;
    font-size: 13px;
}

.info-label {
    color: #a27755;
    font-weight: 900;
}

.info-value {
    color: #2f241d;
    font-weight: 800;
    text-align: right;
    word-break: break-all;
}

.quick-card {
    padding: 24px;
}

.quick-title {
    font-size: 18px;
    font-weight: 900;
    color: #2f241d;
    margin-bottom: 10px;
}

.quick-desc {
    color: #7a6a5d;
    font-size: 13px;
    line-height: 1.6;
    margin-bottom: 16px;
}

.quick-link {
    display: block;
    text-align: center;
    text-decoration: none;
    background: #fffaf3;
    border: 1px solid #f4d7b7;
    color: #a27755;
    border-radius: 14px;
    padding: 12px 14px;
    font-size: 14px;
    font-weight: 900;
    transition: 0.2s;
    margin-top: 10px;
}

.quick-link:hover {
    background: #ff914d;
    color: #fff;
    box-shadow: 0 8px 18px rgba(255, 145, 77, 0.28);
}

@media (max-width: 1100px) {
    .content-grid {
        grid-template-columns: 1fr;
    }

    .form-wrap {
        max-width: 100%;
    }
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
            <li>
                <a href="${pageContext.request.contextPath}/">
                    메인 페이지
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/member/mypage">
                    내 정보 수정
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/member/mypage/changePw">
                    비밀번호 변경
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/member/inquiry/write" class="active">
                    문의하기
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/member/inquiries">
                    문의 내역
                </a>
            </li>

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
                <h1>문의 작성</h1>
                <p>서비스 이용 중 궁금한 점이나 불편한 점을 남겨주세요.</p>
            </div>
        </div>

        <div class="content-grid">

            <div class="form-wrap">
                <section class="form-card">
                    <h2 class="section-title">새 문의 등록</h2>

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

                    <form action="${pageContext.request.contextPath}/member/inquiry/write"
                          method="post"
                          onsubmit="return confirm('문의글을 등록하시겠습니까?');">

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                        <div class="form-item">
                            <label for="title" class="form-label">제목</label>
                            <input type="text"
                                   id="title"
                                   name="title"
                                   class="form-input"
                                   placeholder="문의 제목을 입력하세요"
                                   required>
                            <div class="help-text">
                                문의 내용을 한눈에 알 수 있도록 제목을 작성해주세요.
                            </div>
                        </div>

                        <div class="form-item">
                            <label for="content" class="form-label">문의 내용</label>
                            <textarea id="content"
                                      name="content"
                                      class="form-textarea"
                                      placeholder="문의 내용을 자세히 입력하세요"
                                      required></textarea>
                            <div class="help-text">
                                오류 상황, 이용 환경, 궁금한 점을 자세히 적어주면 답변에 도움이 됩니다.
                            </div>
                        </div>

                        <div class="notice-box">
                            문의를 등록하면 관리자 확인 후 답변이 작성됩니다.<br>
                            답변이 완료된 문의는 문의 상세 페이지에서 확인할 수 있습니다.
                        </div>

                        <div class="button-area">
                            <a href="${pageContext.request.contextPath}/member/inquiries" class="btn btn-list">
                                문의 내역
                            </a>

                            <button type="submit" class="btn btn-submit">
                                문의 등록
                            </button>
                        </div>

                    </form>
                </section>
            </div>

            <aside>
                <section class="guide-card">
                    <div class="guide-icon">✍️</div>

                    <div class="guide-title">
                        문의 안내
                    </div>

                    <div class="guide-desc">
                        PickEat 이용 중 생긴 문제나 궁금한 점을 남겨주세요.
                    </div>

                    <div class="guide-info">
                        <div class="info-row">
                            <span class="info-label">작성 항목</span>
                            <span class="info-value">제목 / 내용</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">답변 확인</span>
                            <span class="info-value">문의 내역</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">삭제 가능</span>
                            <span class="info-value">답변 대기 문의</span>
                        </div>
                    </div>
                </section>

                <section class="quick-card">
                    <div class="quick-title">빠른 메뉴</div>
                    <div class="quick-desc">
                        문의 작성 후 내역에서 답변 상태를 확인할 수 있습니다.
                    </div>

                    <a href="${pageContext.request.contextPath}/member/inquiries" class="quick-link">
                        문의 내역
                    </a>

                    <a href="${pageContext.request.contextPath}/member/mypage" class="quick-link">
                        마이페이지
                    </a>

                    <a href="${pageContext.request.contextPath}/" class="quick-link">
                        메인 페이지
                    </a>
                </section>
            </aside>

        </div>

    </main>
</div>

</body>
</html>