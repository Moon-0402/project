<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat | 문의 상세</title>

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
    grid-template-columns: minmax(420px, 760px) 320px;
    gap: 24px;
    align-items: start;
}

.detail-wrap {
    max-width: 760px;
}

.detail-card,
.reply-card,
.info-card,
.quick-card {
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 28px;
    box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
    padding: 34px;
}

.detail-card {
    margin-bottom: 22px;
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

.inquiry-title {
    font-size: 26px;
    font-weight: 900;
    color: #2f241d;
    line-height: 1.4;
    word-break: break-all;
    margin-bottom: 18px;
}

.meta-box {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 24px;
}

.meta-item {
    background: #fffaf3;
    border: 1px solid #f4d7b7;
    color: #7a4a18;
    border-radius: 999px;
    padding: 9px 14px;
    font-size: 13px;
    font-weight: 900;
}

.badge {
    display: inline-block;
    padding: 9px 14px;
    border-radius: 999px;
    font-size: 13px;
    font-weight: 900;
    white-space: nowrap;
}

.waiting {
    background: #fff1ce;
    color: #b36b00;
    border: 1px solid #f8d98b;
}

.answered {
    background: #dcfce7;
    color: #15803d;
    border: 1px solid #bbf7d0;
}

.content-box {
    white-space: pre-line;
    line-height: 1.8;
    background: #fffaf3;
    border: 1px solid #f4d7b7;
    border-radius: 20px;
    padding: 24px;
    color: #2f241d;
    word-break: break-all;
    min-height: 180px;
}

.reply-card {
    margin-bottom: 22px;
}

.reply-box {
    white-space: pre-line;
    line-height: 1.8;
    background: #f0fdf4;
    border: 1px solid #bbf7d0;
    border-radius: 20px;
    padding: 22px;
    color: #284b31;
    word-break: break-all;
    margin-bottom: 14px;
}

.reply-box:last-child {
    margin-bottom: 0;
}

.reply-head {
    display: flex;
    justify-content: space-between;
    gap: 10px;
    flex-wrap: wrap;
    margin-bottom: 12px;
    color: #15803d;
    font-weight: 900;
}

.reply-date {
    color: #6b8f73;
    font-size: 13px;
    font-weight: 800;
}

.empty-reply {
    padding: 42px 20px;
    text-align: center;
    color: #9a521e;
    background: #fff7ed;
    border: 1px solid #fed7aa;
    border-radius: 20px;
    font-weight: 900;
    line-height: 1.6;
}

.button-area {
    display: flex;
    justify-content: space-between;
    gap: 12px;
    margin-top: 24px;
    padding-top: 24px;
    border-top: 1px solid #f1d4b7;
}

.left-btn-area,
.right-btn-area {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
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

.btn-write {
    background: #ff914d;
    color: #fff;
    box-shadow: 0 8px 20px rgba(255, 145, 77, 0.32);
}

.btn-write:hover {
    background: #f97316;
    transform: translateY(-1px);
}

.btn-delete {
    background: #ef4444;
    color: #fff;
    box-shadow: 0 8px 20px rgba(239, 68, 68, 0.25);
}

.btn-delete:hover {
    background: #dc2626;
    transform: translateY(-1px);
}

form {
    margin: 0;
}

/* 오른쪽 정보 카드 */
.info-card {
    padding: 28px;
    margin-bottom: 18px;
}

.info-icon {
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

.info-title {
    font-size: 23px;
    font-weight: 900;
    color: #2f241d;
    margin-bottom: 8px;
}

.info-desc {
    font-size: 14px;
    color: #7a6a5d;
    line-height: 1.6;
}

.info-list {
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

    .detail-wrap {
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

    .left-btn-area,
    .right-btn-area {
        width: 100%;
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
                <a href="${pageContext.request.contextPath}/member/inquiry/write">
                    문의하기
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/member/inquiries" class="active">
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
                <h1>문의 상세</h1>
                <p>내가 작성한 문의 내용과 관리자 답변을 확인할 수 있습니다.</p>
            </div>
        </div>

        <div class="content-grid">

            <div class="detail-wrap">

                <section class="detail-card">
                    <h2 class="section-title">문의 내용</h2>

                    <div class="inquiry-title">
                        ${inquiry.title}
                    </div>

                    <div class="meta-box">
                        <div class="meta-item">
                            작성자: ${inquiry.name}
                        </div>

                        <div class="meta-item">
                            작성일: ${inquiry.createdAt}
                        </div>

                        <c:choose>
                            <c:when test="${inquiry.status == 'ANSWERED'}">
                                <span class="badge answered">답변 완료</span>
                            </c:when>

                            <c:otherwise>
                                <span class="badge waiting">답변 대기</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="content-box">${inquiry.content}</div>

                    <div class="button-area">
                        <div class="left-btn-area">
                            <a class="btn btn-list"
                               href="${pageContext.request.contextPath}/member/inquiries">
                                문의 내역
                            </a>

                            <a class="btn btn-write"
                               href="${pageContext.request.contextPath}/member/inquiry/write">
                                문의 작성
                            </a>
                        </div>

                        <div class="right-btn-area">
                            <c:if test="${inquiry.status != 'ANSWERED'}">
                                <form action="${pageContext.request.contextPath}/member/inquiry/${inquiry.inquiryId}/delete"
                                      method="post"
                                      onsubmit="return confirm('문의글을 삭제하시겠습니까? 삭제 후에는 복구할 수 없습니다.');">

                                    <input type="hidden"
                                           name="${_csrf.parameterName}"
                                           value="${_csrf.token}">

                                    <button class="btn btn-delete" type="submit">
                                        문의 삭제
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </section>

                <section class="reply-card">
                    <h2 class="section-title">관리자 답변</h2>

                    <c:choose>
                        <c:when test="${empty replyList}">
                            <div class="empty-reply">
                                아직 등록된 답변이 없습니다.<br>
                                관리자가 확인 후 답변을 등록하면 이곳에 표시됩니다.
                            </div>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="reply" items="${replyList}">
                                <div class="reply-box">
                                    <div class="reply-head">
                                        <span>관리자: ${reply.adminName}</span>
                                        <span class="reply-date">${reply.createdAt}</span>
                                    </div>

                                    ${reply.content}
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </section>

            </div>

            <aside>
                <section class="info-card">
                    <div class="info-icon">💬</div>

                    <div class="info-title">
                        문의 상태
                    </div>

                    <div class="info-desc">
                        문의 답변 여부와 작성 정보를 한눈에 확인할 수 있습니다.
                    </div>

                    <div class="info-list">
                        <div class="info-row">
                            <span class="info-label">문의 번호</span>
                            <span class="info-value">${inquiry.inquiryId}</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">작성자</span>
                            <span class="info-value">${inquiry.name}</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">상태</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${inquiry.status == 'ANSWERED'}">
                                        답변 완료
                                    </c:when>
                                    <c:otherwise>
                                        답변 대기
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </section>

                <section class="quick-card">
                    <div class="quick-title">빠른 메뉴</div>
                    <div class="quick-desc">
                        문의 관련 메뉴로 바로 이동할 수 있습니다.
                    </div>

                    <a href="${pageContext.request.contextPath}/member/inquiries" class="quick-link">
                        문의 내역
                    </a>

                    <a href="${pageContext.request.contextPath}/member/inquiry/write" class="quick-link">
                        문의하기
                    </a>

                    <a href="${pageContext.request.contextPath}/member/mypage" class="quick-link">
                        마이페이지
                    </a>
                </section>
            </aside>

        </div>

    </main>
</div>

</body>
</html>