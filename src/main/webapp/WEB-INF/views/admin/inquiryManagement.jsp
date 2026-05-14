<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 관리자 | 문의 관리</title>

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

.admin-layout {
    display: flex;
    min-height: 100vh;
}

/* 왼쪽 배너 */
.sidebar {
    width: 250px;
    background: #2f241d;
    color: #fff;
    padding: 30px 24px;
    box-shadow: 8px 0 24px rgba(47, 36, 29, 0.15);
    flex-shrink: 0;
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
    letter-spacing: -1px;
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
    text-transform: uppercase;
    font-weight: 900;
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
    font-weight: 700;
}

.menu-list a:hover,
.menu-list a.active {
    background: #ff914d;
    color: #fff;
    box-shadow: 0 8px 18px rgba(255, 145, 77, 0.35);
}

/* 오른쪽 본문 */
.main {
    flex: 1;
    padding: 38px 48px;
    overflow-x: hidden;
}

.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 20px;
    margin-bottom: 28px;
}

.page-title h1 {
    font-size: 34px;
    color: #2f241d;
    margin-bottom: 8px;
}

.page-title p {
    color: #7a6a5d;
    font-size: 15px;
    line-height: 1.6;
}

.admin-badge {
    display: inline-block;
    background: rgba(255, 255, 255, 0.78);
    border: 1px solid rgba(255, 184, 107, 0.45);
    color: #a15c22;
    padding: 10px 16px;
    border-radius: 999px;
    font-size: 13px;
    font-weight: 900;
    white-space: nowrap;
}

/* 상단 안내 카드 */
.summary-card {
    position: relative;
    overflow: hidden;
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 28px;
    box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
    padding: 30px 32px;
    margin-bottom: 24px;
}

.summary-card::after {
    content: "💬";
    position: absolute;
    right: 32px;
    bottom: 14px;
    font-size: 86px;
    opacity: 0.11;
}

.summary-title {
    font-size: 25px;
    font-weight: 900;
    color: #2f241d;
    margin-bottom: 10px;
}

.summary-text {
    color: #7a6a5d;
    line-height: 1.7;
    font-size: 15px;
    max-width: 720px;
}

/* 검색 카드 */
.search-area {
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 24px;
    padding: 22px;
    margin-bottom: 24px;
    box-shadow: 0 14px 34px rgba(90, 64, 43, 0.1);
}

.search-form {
    display: flex;
    gap: 10px;
    align-items: center;
    flex-wrap: wrap;
}

.search-input {
    flex: 1;
    min-width: 260px;
    height: 48px;
    padding: 0 16px;
    border-radius: 15px;
    border: 1px solid #f4d7b7;
    background: #fffaf3;
    color: #2f241d;
    font-size: 14px;
    font-weight: 700;
    outline: none;
    font-family: inherit;
}

.search-input::placeholder {
    color: #b49376;
}

.search-input:focus {
    border-color: #ff914d;
    box-shadow: 0 0 0 4px rgba(255, 145, 77, 0.16);
}

.search-btn,
.reset-btn {
    height: 48px;
    padding: 0 20px;
    border-radius: 15px;
    font-size: 14px;
    font-weight: 900;
    font-family: inherit;
    cursor: pointer;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    transition: 0.2s;
}

.search-btn {
    border: none;
    background: #ff914d;
    color: #fff;
    box-shadow: 0 8px 20px rgba(255, 145, 77, 0.32);
}

.search-btn:hover {
    background: #f97316;
    transform: translateY(-1px);
}

.reset-btn {
    border: 1px solid #f4d7b7;
    background: #fff3df;
    color: #b45309;
}

.reset-btn:hover {
    background: #fed7aa;
}

.search-info {
    margin-top: 14px;
    color: #7a6a5d;
    font-size: 13px;
    font-weight: 800;
}

.search-info strong {
    color: #f97316;
}

/* 목록 카드 */
.content-card {
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 28px;
    box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
    padding: 28px;
}

.table-wrap {
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
    overflow: hidden;
    border-radius: 20px;
    background: #fffaf3;
}

th {
    background: #fff3df;
    padding: 16px;
    color: #a15c22;
    text-align: left;
    font-size: 14px;
    border-bottom: 1px solid #f3dcc5;
    white-space: nowrap;
}

td {
    padding: 16px;
    border-bottom: 1px solid #f3dcc5;
    color: #2f241d;
    vertical-align: middle;
    font-size: 14px;
}

tbody tr:hover {
    background: #fff7ed;
}

.title-cell {
    font-weight: 900;
    color: #2f241d;
    max-width: 380px;
    word-break: break-all;
}

.member-cell {
    color: #5b4030;
    font-weight: 900;
}

.member-cell span {
    display: inline-block;
    margin-top: 4px;
    font-size: 13px;
    color: #a27755;
    font-weight: 700;
}

.date-cell {
    color: #7a6a5d;
    font-size: 14px;
    white-space: nowrap;
}

.badge {
    display: inline-block;
    padding: 8px 12px;
    border-radius: 999px;
    font-size: 13px;
    font-weight: 900;
    white-space: nowrap;
}

.waiting {
    background: #fff3cd;
    color: #9a6200;
}

.answered {
    background: #dcfce7;
    color: #15803d;
}

.answer-btn {
    display: inline-block;
    padding: 10px 15px;
    border-radius: 13px;
    background: #ff914d;
    color: #fff;
    font-weight: 900;
    text-decoration: none;
    white-space: nowrap;
    box-shadow: 0 8px 20px rgba(255, 145, 77, 0.26);
    transition: 0.2s;
}

.answer-btn:hover {
    background: #f97316;
    transform: translateY(-1px);
}

.answer-btn.done {
    background: #22c55e;
    color: #fff;
    box-shadow: 0 8px 20px rgba(34, 197, 94, 0.24);
}

.answer-btn.done:hover {
    background: #16a34a;
}

.empty {
    padding: 70px 20px;
    text-align: center;
    color: #7a6a5d;
    background: #fffaf3;
    border: 1px dashed #f4c999;
    border-radius: 22px;
    font-weight: 800;
}

/* 페이징 */
.pagination-wrap {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin-top: 30px;
    flex-wrap: wrap;
}

.pagination-wrap a,
.pagination-wrap span {
    min-width: 38px;
    height: 38px;
    padding: 0 13px;
    border-radius: 999px;
    background: #fff3df;
    color: #b45309;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 900;
    font-size: 14px;
    border: 1px solid #f4d7b7;
    transition: 0.2s;
}

.pagination-wrap a:hover {
    background: #fed7aa;
    transform: translateY(-1px);
}

.pagination-wrap a.active {
    background: #ff914d;
    color: #fff;
    border-color: #ff914d;
    box-shadow: 0 8px 18px rgba(255, 145, 77, 0.28);
}

.pagination-wrap span.disabled {
    opacity: 0.45;
    cursor: default;
}

.page-info {
    text-align: center;
    margin-top: 16px;
    color: #7a6a5d;
    font-size: 13px;
    font-weight: 800;
}

/* 반응형 */
@media (max-width: 900px) {
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

    .admin-badge {
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

    .search-btn,
    .reset-btn {
        width: 100%;
        margin-bottom: 8px;
    }

    .content-card {
        padding: 20px;
    }
}
</style>
</head>

<body>

<div class="admin-layout">

    <!-- 왼쪽 배너 -->
    <aside class="sidebar">
        <div class="logo-box">
            <a href="${pageContext.request.contextPath}/" class="logo-link">
                <div class="logo">Pick<span>Eat</span></div>
            </a>
            <div class="logo-desc">날씨와 상황에 맞는 맛집 추천 서비스</div>
        </div>

        <div class="menu-title">Admin Menu</div>
        <ul class="menu-list">
            <li>
                <a href="${pageContext.request.contextPath}/admin">대시보드</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/members">회원 관리</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/inquiries" class="active">문의 관리</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/restaurants">맛집 관리</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/reviewList">리뷰 관리</a>
            </li>
            <li>
            </li>
        </ul>
    </aside>

    <!-- 오른쪽 본문 -->
    <main class="main">

        <div class="top-bar">
            <div class="page-title">
                <h1>문의 관리</h1>
                <p>회원 문의를 확인하고 답변 상태를 관리합니다.</p>
            </div>

            <div class="admin-badge">INQUIRY MODE</div>
        </div>

        <section class="summary-card">
            <div class="summary-title">회원 문의 응답 센터</div>
            <p class="summary-text">
                사용자가 남긴 문의를 확인하고 답변을 등록할 수 있습니다.
                답변 대기 상태의 문의를 우선적으로 확인하면 서비스 운영 흐름이 훨씬 깔끔해집니다.
            </p>
        </section>

        <!-- 검색 영역 -->
        <section class="search-area">
            <form class="search-form"
                  action="${pageContext.request.contextPath}/admin/inquiries"
                  method="get">

                <input type="hidden" name="page" value="1">
                <input type="hidden" name="size" value="${pageDTO.size}">

                <input type="text"
                       name="keyword"
                       class="search-input"
                       value="${keyword}"
                       placeholder="회원 이름 또는 사용자 아이디를 입력하세요">

                <button type="submit" class="search-btn">검색</button>

                <a class="reset-btn"
                   href="${pageContext.request.contextPath}/admin/inquiries?page=1&size=${pageDTO.size}">
                    초기화
                </a>
            </form>

            <c:if test="${not empty keyword}">
                <div class="search-info">
                    <strong>${keyword}</strong> 검색 결과입니다.
                </div>
            </c:if>
        </section>

        <!-- 문의 목록 영역 -->
        <section class="content-card">

            <c:choose>
                <c:when test="${empty inquiryList}">
                    <div class="empty">
                        <c:choose>
                            <c:when test="${not empty keyword}">
                                <strong>${keyword}</strong>에 해당하는 문의가 없습니다.
                            </c:when>
                            <c:otherwise>
                                등록된 문의가 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="table-wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>회원</th>
                                    <th>제목</th>
                                    <th>상태</th>
                                    <th>작성일</th>
                                    <th>관리</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="inquiry" items="${inquiryList}">
                                    <tr>
                                        <td>${inquiry.inquiryId}</td>

                                        <td class="member-cell">
                                            ${inquiry.name}
                                            <br>
                                            <span>${inquiry.loginId}</span>
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
                                            <c:choose>
                                                <c:when test="${inquiry.status == 'ANSWERED'}">
                                                    <a class="answer-btn done"
                                                       href="${pageContext.request.contextPath}/admin/inquiry/${inquiry.inquiryId}">
                                                        답변 보기
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a class="answer-btn"
                                                       href="${pageContext.request.contextPath}/admin/inquiry/${inquiry.inquiryId}">
                                                        답변
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- 페이징 영역 -->
                    <c:if test="${pageDTO.totalPage > 0}">
                        <div class="pagination-wrap">

                            <c:choose>
                                <c:when test="${pageDTO.page > 1}">
                                    <a href="${pageContext.request.contextPath}/admin/inquiries?page=${pageDTO.page - 1}&size=${pageDTO.size}&keyword=${keyword}">
                                        이전
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span class="disabled">이전</span>
                                </c:otherwise>
                            </c:choose>

                            <c:forEach var="num" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
                                <c:if test="${num <= pageDTO.totalPage}">
                                    <a href="${pageContext.request.contextPath}/admin/inquiries?page=${num}&size=${pageDTO.size}&keyword=${keyword}"
                                       class="${pageDTO.page == num ? 'active' : ''}">
                                        ${num}
                                    </a>
                                </c:if>
                            </c:forEach>

                            <c:choose>
                                <c:when test="${pageDTO.page < pageDTO.totalPage}">
                                    <a href="${pageContext.request.contextPath}/admin/inquiries?page=${pageDTO.page + 1}&size=${pageDTO.size}&keyword=${keyword}">
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
                </c:otherwise>
            </c:choose>

        </section>

    </main>
</div>

</body>
</html>