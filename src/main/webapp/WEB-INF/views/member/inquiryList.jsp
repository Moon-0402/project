<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat | 문의 내역</title>

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
    grid-template-columns: minmax(520px, 1fr) 320px;
    gap: 24px;
    align-items: start;
}

.list-card,
.summary-card,
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

.card-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 16px;
    margin-bottom: 24px;
}

.card-desc {
    color: #7a6a5d;
    font-size: 14px;
    line-height: 1.6;
}

.top-btn-area {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.btn {
    border: none;
    border-radius: 14px;
    padding: 12px 18px;
    font-size: 14px;
    font-weight: 900;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
    font-family: inherit;
    transition: 0.2s;
    white-space: nowrap;
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

.btn-detail {
    background: #ff914d;
    color: #fff;
    box-shadow: 0 6px 14px rgba(255, 145, 77, 0.22);
}

.btn-detail:hover {
    background: #f97316;
}

.btn-detail.done {
    background: #22c55e;
    color: #fff;
    box-shadow: 0 6px 14px rgba(34, 197, 94, 0.22);
}

.btn-detail.done:hover {
    background: #16a34a;
}

.btn-delete {
    background: #ef4444;
    color: #fff;
    box-shadow: 0 6px 14px rgba(239, 68, 68, 0.22);
}

.btn-delete:hover {
    background: #dc2626;
}

.table-wrap {
    max-height: 585px;
    overflow-y: auto;
    overflow-x: auto;
    border-radius: 20px;
    border: 1px solid #f4d7b7;
    background: #fffaf3;
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 760px;
}

th {
    background: #fff7ed;
    padding: 16px 15px;
    color: #a27755;
    text-align: left;
    font-size: 13px;
    font-weight: 900;
    white-space: nowrap;
    border-bottom: 1px solid #f4d7b7;
}

td {
    padding: 17px 15px;
    border-bottom: 1px solid #f4d7b7;
    color: #2f241d;
    vertical-align: middle;
    font-size: 14px;
}

tbody tr:last-child td {
    border-bottom: none;
}

tbody tr:hover {
    background: #fff7ed;
}

.num-cell {
    font-weight: 900;
    color: #a27755;
}

.title-cell {
    font-weight: 900;
    color: #2f241d;
    max-width: 380px;
    word-break: break-all;
}

.date-cell {
    color: #7a6a5d;
    font-size: 13px;
    font-weight: 700;
    white-space: nowrap;
}

.badge {
    display: inline-block;
    padding: 8px 13px;
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

.manage-area {
    display: flex;
    gap: 8px;
    align-items: center;
    flex-wrap: wrap;
}

form {
    margin: 0;
}

.empty {
    padding: 70px 20px;
    text-align: center;
    color: #9a521e;
    background: #fff7ed;
    border: 1px solid #fed7aa;
    border-radius: 20px;
    font-weight: 900;
    line-height: 1.7;
}

/* 오른쪽 카드 */
.summary-card {
    padding: 28px;
    margin-bottom: 18px;
}

.summary-icon {
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

.summary-title {
    font-size: 23px;
    font-weight: 900;
    color: #2f241d;
    margin-bottom: 8px;
}

.summary-desc {
    font-size: 14px;
    color: #7a6a5d;
    line-height: 1.6;
}

.summary-info {
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

    .card-top {
        flex-direction: column;
        align-items: flex-start;
    }

    .top-btn-area {
        width: 100%;
        flex-direction: column;
    }

    .btn {
        width: 100%;
        text-align: center;
    }

    .manage-area .btn {
        width: auto;
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
                <h1>문의 내역</h1>
                <p>내가 작성한 문의 목록과 답변 상태를 확인할 수 있습니다.</p>
            </div>
        </div>

        <div class="content-grid">

            <section class="list-card">
                <div class="card-top">
                    <div>
                        <h2 class="section-title">나의 문의 내역</h2>
                        <div class="card-desc">
                            문의 제목을 확인하고 상세 내용을 볼 수 있습니다.
                        </div>
                    </div>

                    <div class="top-btn-area">
                        <a class="btn btn-list"
                           href="${pageContext.request.contextPath}/member/mypage">
                            마이페이지
                        </a>

                        <a class="btn btn-write"
                           href="${pageContext.request.contextPath}/member/inquiry/write">
                            문의 작성
                        </a>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty inquiryList}">
                        <div class="empty">
                            아직 작성한 문의가 없습니다.<br>
                            궁금한 점이 있다면 문의를 작성해보세요.
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="table-wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>상태</th>
                                        <th>작성일</th>
                                        <th>관리</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach var="inquiry" items="${inquiryList}">
                                        <tr>
                                            <td class="num-cell">
                                                ${inquiry.inquiryId}
                                            </td>

                                            <td class="title-cell">
                                                ${inquiry.title}
                                            </td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${inquiry.status == 'ANSWERED'}">
                                                        <span class="badge answered">답변 완료</span>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <span class="badge waiting">답변 대기</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td class="date-cell">
                                                ${inquiry.createdAt}
                                            </td>

                                            <td>
                                                <div class="manage-area">

                                                    <c:choose>
                                                        <c:when test="${inquiry.status == 'ANSWERED'}">
                                                            <a class="btn btn-detail done"
                                                               href="${pageContext.request.contextPath}/member/inquiry/${inquiry.inquiryId}">
                                                                답변 보기
                                                            </a>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <a class="btn btn-detail"
                                                               href="${pageContext.request.contextPath}/member/inquiry/${inquiry.inquiryId}">
                                                                상세보기
                                                            </a>

                                                            <form action="${pageContext.request.contextPath}/member/inquiry/${inquiry.inquiryId}/delete"
                                                                  method="post"
                                                                  onsubmit="return confirm('문의글을 삭제하시겠습니까? 삭제 후에는 복구할 수 없습니다.');">

                                                                <input type="hidden"
                                                                       name="${_csrf.parameterName}"
                                                                       value="${_csrf.token}">

                                                                <button class="btn btn-delete" type="submit">
                                                                    삭제
                                                                </button>
                                                            </form>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <aside>
                <section class="summary-card">
                    <div class="summary-icon">📮</div>

                    <div class="summary-title">
                        문의함
                    </div>

                    <div class="summary-desc">
                        작성한 문의와 관리자 답변 상태를 이곳에서 관리할 수 있습니다.
                    </div>

                    <div class="summary-info">
                        <div class="info-row">
                            <span class="info-label">페이지</span>
                            <span class="info-value">문의 내역</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">삭제 가능</span>
                            <span class="info-value">답변 대기 문의</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">답변 확인</span>
                            <span class="info-value">상세보기</span>
                        </div>
                    </div>
                </section>

                <section class="quick-card">
                    <div class="quick-title">빠른 메뉴</div>
                    <div class="quick-desc">
                        자주 사용하는 메뉴로 바로 이동할 수 있습니다.
                    </div>

                    <a href="${pageContext.request.contextPath}/member/inquiry/write" class="quick-link">
                        문의하기
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