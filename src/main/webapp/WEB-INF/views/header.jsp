<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pickeat-hard-fix.css?v=20260519hard3">
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

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pickeat-final-fix.css?v=20260519fix4">
<script src="${pageContext.request.contextPath}/resources/js/pickeat-theme-fix.js?v=20260519fix4"></script>
<style>
* {
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

:root {
    --bg-color: #fff7ed;
    --card-color: #ffffff;
    --text-color: #111827;
    --sub-text-color: #6b7280;
    --point-color: #ff6500;
    --point-soft-color: #fff3e8;
    --border-color: #e5e7eb;
    --header-bg: rgba(255, 255, 255, 0.90);
    --header-border: #e5e7eb;
    --nav-color: #111827;
    --nav-hover: #ff6500;
    --input-bg: #ffffff;
    --input-border: #d1d5db;
    --table-head-bg: #fff3e8;
    --table-row-hover: #fff7ed;
    --shadow-soft: 0 16px 38px rgba(90, 64, 43, 0.10);
}

body {
    margin: 0;
    font-family: 'Pretendard', 'Noto Sans KR', Arial, sans-serif;
    color: var(--text-color);
    background:
        radial-gradient(circle at 10% 12%, rgba(255, 122, 0, 0.18), transparent 28%),
        radial-gradient(circle at 86% 8%, rgba(255, 197, 98, 0.25), transparent 30%),
        radial-gradient(circle at 48% 50%, rgba(255, 241, 219, 0.85), transparent 42%),
        linear-gradient(135deg, #fffaf4 0%, #fff2df 44%, #f8fbff 100%);
}

body.dark-mode {
    --bg-color: #111827;
    --card-color: #1f2937;
    --text-color: #f9fafb;
    --sub-text-color: #d1d5db;
    --point-color: #fb923c;
    --point-soft-color: rgba(251, 146, 60, 0.16);
    --border-color: #374151;
    --header-bg: rgba(17, 24, 39, 0.94);
    --header-border: #374151;
    --nav-color: #e5e7eb;
    --nav-hover: #fb923c;
    --input-bg: #111827;
    --input-border: #4b5563;
    --table-head-bg: #111827;
    --table-row-hover: rgba(251, 146, 60, 0.08);
    --shadow-soft: 0 16px 38px rgba(0, 0, 0, 0.28);

    color: var(--text-color);
    background:
        radial-gradient(circle at 10% 12%, rgba(251, 146, 60, 0.14), transparent 28%),
        radial-gradient(circle at 86% 8%, rgba(249, 115, 22, 0.15), transparent 30%),
        radial-gradient(circle at 50% 80%, rgba(31, 41, 55, 0.75), transparent 42%),
        linear-gradient(135deg, #111827 0%, #1f2937 55%, #0f172a 100%);
}

body.dark-mode,
body.dark-mode main,
body.dark-mode .main,
body.dark-mode .container,
body.dark-mode .wrap,
body.dark-mode .page-wrap,
body.dark-mode .content,
body.dark-mode .page-content,
body.dark-mode .layout,
body.dark-mode .section {
    color: var(--text-color) !important;
}

a {
    text-decoration: none;
    color: inherit;
}

.header {
    height: 64px;
    background: var(--header-bg);
    border-bottom: 1px solid var(--header-border);
    display: flex;
    align-items: center;
    padding: 0 36px;
    backdrop-filter: blur(12px);
    position: sticky;
    top: 0;
    z-index: 100;
    transition: background 0.25s, border-color 0.25s, color 0.25s;
}

.logo {
    font-size: 29px;
    font-weight: 950;
    letter-spacing: -1px;
    display: flex;
    align-items: center;
    gap: 7px;
    color: var(--text-color) !important;
    white-space: nowrap;
}

.logo-icon {
    width: 25px;
    height: 31px;
    background: var(--point-color);
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
    font-weight: 850;
}

.nav a {
    color: var(--nav-color) !important;
    transition: 0.2s;
    position: relative;
    padding: 21px 0;
    background: transparent !important;
}

.nav a:hover,
.nav a.active {
    color: var(--nav-hover) !important;
}

.nav a.active::after {
    content: "";
    position: absolute;
    left: 0;
    right: 0;
    bottom: 13px;
    height: 3px;
    border-radius: 999px;
    background: var(--point-color);
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
    transition: 0.25s;
}

body.dark-mode .user-box {
    background: rgba(31, 41, 55, 0.96);
    border-color: #4b5563;
    box-shadow: 0 10px 24px rgba(0, 0, 0, 0.25);
}

.user-name {
    display: inline-flex;
    align-items: center;
    height: 28px;
    font-size: 13px;
    font-weight: 950;
    color: var(--text-color) !important;
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

body.dark-mode .role-badge.admin,
body.dark-mode .role-badge.user,
body.dark-mode .status-badge,
body.dark-mode .badge,
body.dark-mode .category,
body.dark-mode .tag {
    color: #fed7aa !important;
    background: rgba(251, 146, 60, 0.16) !important;
    border-color: rgba(251, 146, 60, 0.36) !important;
}

.header-btn,
.dark-toggle {
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
    border: 0;
    cursor: pointer;
}

.header-login {
    background: #111827;
    color: #ffffff !important;
    box-shadow: 0 10px 22px rgba(17, 24, 39, 0.13);
}

.header-join {
    background: #ff6500;
    color: #ffffff !important;
    box-shadow: 0 10px 22px rgba(255, 101, 0, 0.18);
}

.header-admin {
    background: #fff3e8;
    color: #ff6500 !important;
    border: 1px solid rgba(255, 101, 0, 0.26);
    box-shadow: 0 10px 22px rgba(255, 101, 0, 0.10);
}

.header-btn:hover,
.dark-toggle:hover {
    transform: translateY(-1px);
}

.dark-toggle {
    border: 1px solid #fed7aa;
    background: #fff7ed;
    color: #f97316;
}

body.dark-mode .header-login {
    background: #f9fafb;
    color: #111827 !important;
}

body.dark-mode .header-join,
body.dark-mode .dark-toggle {
    background: #fb923c;
    color: #111827 !important;
    border-color: #fb923c;
}

body.dark-mode .header-admin {
    background: rgba(251, 146, 60, 0.16);
    color: #fed7aa !important;
    border-color: rgba(251, 146, 60, 0.36);
}

.main {
    min-height: calc(100vh - 64px);
}

body.dark-mode h1,
body.dark-mode h2,
body.dark-mode h3,
body.dark-mode h4,
body.dark-mode h5,
body.dark-mode h6,
body.dark-mode .title,
body.dark-mode .page-title,
body.dark-mode .section-title,
body.dark-mode .card-title,
body.dark-mode .restaurant-name,
body.dark-mode .review-title,
body.dark-mode .inquiry-title,
body.dark-mode .feature-title,
body.dark-mode .welcome-title,
body.dark-mode .weather-title,
body.dark-mode .panel-title {
    color: #f9fafb !important;
}

body.dark-mode p,
body.dark-mode label,
body.dark-mode small,
body.dark-mode li,
body.dark-mode .desc,
body.dark-mode .description,
body.dark-mode .sub-text,
body.dark-mode .sub-title,
body.dark-mode .muted,
body.dark-mode .info-text,
body.dark-mode .empty-text,
body.dark-mode .help-text,
body.dark-mode .section-subtitle,
body.dark-mode .feature-desc,
body.dark-mode .task-desc,
body.dark-mode .review-text,
body.dark-mode .meta,
body.dark-mode .date,
body.dark-mode .address,
body.dark-mode .footer-text {
    color: #d1d5db !important;
}

body.dark-mode .card,
body.dark-mode .box,
body.dark-mode .content-box,
body.dark-mode .content-card,
body.dark-mode .form-card,
body.dark-mode .login-card,
body.dark-mode .signup-card,
body.dark-mode .mypage-card,
body.dark-mode .admin-card,
body.dark-mode .detail-card,
body.dark-mode .list-card,
body.dark-mode .review-card,
body.dark-mode .restaurant-card,
body.dark-mode .bookmark-card,
body.dark-mode .inquiry-card,
body.dark-mode .recommend-card,
body.dark-mode .result-card,
body.dark-mode .history-card,
body.dark-mode .search-area,
body.dark-mode .search-card,
body.dark-mode .table-card,
body.dark-mode .reply-card,
body.dark-mode .empty-box,
body.dark-mode .no-data {
    background: #1f2937 !important;
    color: #f9fafb !important;
    border-color: #374151 !important;
    box-shadow: var(--shadow-soft) !important;
}

body.dark-mode input,
body.dark-mode textarea,
body.dark-mode select,
body.dark-mode .form-input,
body.dark-mode .form-textarea,
body.dark-mode .search-input,
body.dark-mode .readonly-input {
    background: #111827 !important;
    color: #f9fafb !important;
    border-color: #4b5563 !important;
    box-shadow: none !important;
}

body.dark-mode input::placeholder,
body.dark-mode textarea::placeholder {
    color: #9ca3af !important;
}

body.dark-mode table,
body.dark-mode thead,
body.dark-mode tbody,
body.dark-mode tr {
    background: #1f2937 !important;
    color: #f9fafb !important;
    border-color: #374151 !important;
}

body.dark-mode th,
body.dark-mode td {
    border-color: #374151 !important;
    color: #e5e7eb !important;
}

body.dark-mode thead th,
body.dark-mode .table-card th {
    background: #111827 !important;
    color: #f9fafb !important;
}

body.dark-mode tbody tr:hover {
    background: rgba(251, 146, 60, 0.08) !important;
}

body.dark-mode .btn,
body.dark-mode .primary,
body.dark-mode .primary-btn,
body.dark-mode .btn-primary,
body.dark-mode .search-btn,
body.dark-mode .submit-btn,
body.dark-mode .add-btn,
body.dark-mode .write-btn,
body.dark-mode .answer-btn,
body.dark-mode .login-btn,
body.dark-mode .signup-btn,
body.dark-mode .btn-submit,
body.dark-mode .btn-save {
    background: #fb923c !important;
    border-color: #fb923c !important;
    color: #111827 !important;
}

body.dark-mode .secondary,
body.dark-mode .secondary-btn,
body.dark-mode .reset-btn,
body.dark-mode .back-btn,
body.dark-mode .back-link,
body.dark-mode .btn-outline,
body.dark-mode .btn-soft,
body.dark-mode .btn-sub,
body.dark-mode .btn-list,
body.dark-mode .clear-btn,
body.dark-mode .detail-btn,
body.dark-mode .view-btn,
body.dark-mode .edit-btn,
body.dark-mode .delete-btn,
body.dark-mode .btn-delete,
body.dark-mode .btn-edit,
body.dark-mode .btn-detail {
    background: #111827 !important;
    border-color: #4b5563 !important;
    color: #f9fafb !important;
}

body.dark-mode .pagination a,
body.dark-mode .page-link,
body.dark-mode .page-btn,
body.dark-mode .page-num,
body.dark-mode .pagination-wrap a,
body.dark-mode .pagination-wrap span {
    background: #1f2937 !important;
    border-color: #4b5563 !important;
    color: #e5e7eb !important;
    opacity: 1 !important;
}

body.dark-mode .pagination a.active,
body.dark-mode .pagination a:hover,
body.dark-mode .page-link.active,
body.dark-mode .page-link:hover,
body.dark-mode .page-btn.active,
body.dark-mode .page-btn:hover,
body.dark-mode .page-num.active,
body.dark-mode .page-num:hover,
body.dark-mode .pagination-wrap a.active,
body.dark-mode .pagination-wrap a:hover {
    background: #fb923c !important;
    border-color: #fb923c !important;
    color: #111827 !important;
}

body.dark-mode .sidebar,
body.dark-mode .admin-sidebar,
body.dark-mode .left-banner,
body.dark-mode .side-banner {
    background: #0f172a !important;
    color: #f9fafb !important;
    border-color: #334155 !important;
}

body.dark-mode .button-area,
body.dark-mode .btn-area,
body.dark-mode .button-row,
body.dark-mode .btn-row,
body.dark-mode .action-area,
body.dark-mode .actions,
body.dark-mode .card-actions,
body.dark-mode .form-actions,
body.dark-mode .review-actions,
body.dark-mode .pagination-wrap,
body.dark-mode .pagination-area,
body.dark-mode .logo-box,
body.dark-mode .logo-link {
    background: transparent !important;
    box-shadow: none !important;
}

@media (max-width: 1050px) {
    .header {
        height: auto;
        padding: 16px 20px;
        flex-wrap: wrap;
        gap: 14px;
    }

    .nav {
        order: 3;
        width: 100%;
        justify-content: flex-start;
        gap: 20px;
        overflow-x: auto;
    }

    .header-actions {
        min-width: auto;
        margin-left: auto;
        flex-wrap: wrap;
    }
}


/* ===== PickEat common dark-mode readability fix ===== */
body.dark-mode {
    background: linear-gradient(135deg, #111827 0%, #1f2937 55%, #0f172a 100%) !important;
    color: #f9fafb !important;
}

body.dark-mode .page-wrap,
body.dark-mode .main,
body.dark-mode main,
body.dark-mode .container,
body.dark-mode .content,
body.dark-mode .page-content,
body.dark-mode .section {
    color: #f9fafb !important;
}

body.dark-mode h1,
body.dark-mode h2,
body.dark-mode h3,
body.dark-mode h4,
body.dark-mode .title,
body.dark-mode .page-title,
body.dark-mode .section-title,
body.dark-mode .card-title,
body.dark-mode .restaurant-name,
body.dark-mode .review-title,
body.dark-mode .inquiry-title,
body.dark-mode .feature-title {
    color: #f9fafb !important;
}

body.dark-mode p,
body.dark-mode label,
body.dark-mode small,
body.dark-mode li,
body.dark-mode .desc,
body.dark-mode .description,
body.dark-mode .sub-text,
body.dark-mode .muted,
body.dark-mode .meta,
body.dark-mode .date,
body.dark-mode .address,
body.dark-mode .help-text,
body.dark-mode .section-subtitle,
body.dark-mode .feature-desc,
body.dark-mode .review-text,
body.dark-mode .footer-text,
body.dark-mode .form-label,
body.dark-mode .info-label,
body.dark-mode .info-value {
    color: #d1d5db !important;
}

body.dark-mode .card,
body.dark-mode .box,
body.dark-mode .panel,
body.dark-mode .content-box,
body.dark-mode .content-card,
body.dark-mode .form-card,
body.dark-mode .login-card,
body.dark-mode .signup-card,
body.dark-mode .mypage-card,
body.dark-mode .profile-card,
body.dark-mode .quick-card,
body.dark-mode .detail-card,
body.dark-mode .list-card,
body.dark-mode .review-card,
body.dark-mode .restaurant-card,
body.dark-mode .bookmark-card,
body.dark-mode .inquiry-card,
body.dark-mode .recommend-card,
body.dark-mode .result-card,
body.dark-mode .history-card,
body.dark-mode .search-area,
body.dark-mode .search-box,
body.dark-mode .search-card,
body.dark-mode .table-card,
body.dark-mode .reply-card,
body.dark-mode .empty-box,
body.dark-mode .no-data,
body.dark-mode .weather-card,
body.dark-mode .form-item,
body.dark-mode .info-box,
body.dark-mode .quick-link,
body.dark-mode .side-card {
    background: #1f2937 !important;
    color: #f9fafb !important;
    border-color: #374151 !important;
    box-shadow: 0 18px 45px rgba(0, 0, 0, 0.28) !important;
}

body.dark-mode input,
body.dark-mode textarea,
body.dark-mode select,
body.dark-mode .form-input,
body.dark-mode .form-textarea,
body.dark-mode .search-input,
body.dark-mode .readonly-input {
    background: #111827 !important;
    color: #f9fafb !important;
    border-color: #4b5563 !important;
}

body.dark-mode input::placeholder,
body.dark-mode textarea::placeholder {
    color: #9ca3af !important;
}

body.dark-mode table,
body.dark-mode thead,
body.dark-mode tbody,
body.dark-mode tr {
    background: #1f2937 !important;
    color: #f9fafb !important;
    border-color: #374151 !important;
}

body.dark-mode th,
body.dark-mode td {
    border-color: #374151 !important;
    color: #e5e7eb !important;
}

body.dark-mode thead th,
body.dark-mode .table-card th {
    background: #111827 !important;
    color: #f9fafb !important;
}

body.dark-mode tbody tr:hover {
    background: rgba(251, 146, 60, 0.08) !important;
}

body.dark-mode .btn,
body.dark-mode .primary,
body.dark-mode .primary-btn,
body.dark-mode .btn-primary,
body.dark-mode .search-btn,
body.dark-mode .submit-btn,
body.dark-mode .add-btn,
body.dark-mode .write-btn,
body.dark-mode .answer-btn,
body.dark-mode .login-btn,
body.dark-mode .signup-btn,
body.dark-mode .btn-submit,
body.dark-mode .btn-save {
    background: #fb923c !important;
    border-color: #fb923c !important;
    color: #111827 !important;
}

body.dark-mode .secondary,
body.dark-mode .secondary-btn,
body.dark-mode .reset-btn,
body.dark-mode .back-btn,
body.dark-mode .back-link,
body.dark-mode .btn-outline,
body.dark-mode .btn-soft,
body.dark-mode .btn-sub,
body.dark-mode .btn-list,
body.dark-mode .clear-btn,
body.dark-mode .detail-btn,
body.dark-mode .view-btn,
body.dark-mode .edit-btn,
body.dark-mode .delete-btn,
body.dark-mode .btn-delete,
body.dark-mode .btn-edit,
body.dark-mode .btn-detail {
    background: #111827 !important;
    border-color: #4b5563 !important;
    color: #f9fafb !important;
}

body.dark-mode .sidebar,
body.dark-mode .left-banner,
body.dark-mode .side-banner {
    background: #0f172a !important;
    color: #f9fafb !important;
    border-color: #334155 !important;
}

body.dark-mode .sidebar .logo,
body.dark-mode .left-banner .logo,
body.dark-mode .side-banner .logo {
    color: #ffb86b !important;
}

body.dark-mode .sidebar .logo span,
body.dark-mode .left-banner .logo span,
body.dark-mode .side-banner .logo span {
    color: #ffffff !important;
}

body.dark-mode .sidebar .menu-list a,
body.dark-mode .left-banner a,
body.dark-mode .side-banner a {
    color: #e5e7eb !important;
}

body.dark-mode .sidebar .menu-list a.active,
body.dark-mode .sidebar .menu-list a:hover,
body.dark-mode .left-banner a.active,
body.dark-mode .left-banner a:hover,
body.dark-mode .side-banner a.active,
body.dark-mode .side-banner a:hover {
    background: #fb923c !important;
    color: #111827 !important;
}

</style>
<!-- final-pass-after-header-style -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pickeat-final-fix.css?v=20260519fix4">
<script src="${pageContext.request.contextPath}/resources/js/pickeat-theme-fix.js?v=20260519fix4"></script>

<script>
(function () {
    if (localStorage.getItem("theme") === "dark") {
        document.body.classList.add("dark-mode");
    }
})();
</script>

<header class="header">
    <a href="${contextPath}/" class="logo">
        PickEat
        <span class="logo-icon"></span>
    </a>

    <nav class="nav">
        <a href="${contextPath}/" class="${currentURI eq homeURI or currentURI eq contextPath ? 'active' : ''}">홈</a>

        <a href="${not empty sessionScope.loginMember ? recommendURI : loginURI}"
           class="${fn:contains(currentURI, '/recommend') ? 'active' : ''}">추천</a>

        <a href="${not empty sessionScope.loginMember ? restaurantsURI : loginURI}"
           class="${currentURI eq restaurantsURI ? 'active' : ''}">맛집 리스트</a>

        <a href="${not empty sessionScope.loginMember ? bookmarkURI : loginURI}"
           class="${fn:contains(currentURI, '/bookmark') ? 'active' : ''}">즐겨찾기</a>

        <a href="${not empty sessionScope.loginMember ? reviewURI : loginURI}"
           class="${fn:contains(currentURI, '/review') ? 'active' : ''}">리뷰</a>

        <c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.role ne 'ADMIN'}">
            <a href="${contextPath}/member/mypage?memberId=${sessionScope.loginMember.memberId}"
               class="${fn:contains(currentURI, '/member/mypage') ? 'active' : ''}">마이페이지</a>
        </c:if>
    </nav>

    <div class="header-actions">
        <c:choose>
            <c:when test="${not empty sessionScope.loginMember}">
                <div class="user-box">
                    <span class="user-name">${sessionScope.loginMember.name}님</span>

                    <c:choose>
                        <c:when test="${sessionScope.loginMember.role eq 'ADMIN'}">
                            <span class="role-badge admin">관리자</span>
                        </c:when>
                        <c:otherwise>
                            <span class="role-badge user">회원</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:choose>
                    <c:when test="${sessionScope.loginMember.role eq 'ADMIN'}">
                        <a href="${contextPath}/admin" class="header-btn header-admin">관리자</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${contextPath}/member/mypage?memberId=${sessionScope.loginMember.memberId}"
                           class="header-btn header-login">마이페이지</a>
                    </c:otherwise>
                </c:choose>

                <a href="${contextPath}/member/logout" class="header-btn header-join">로그아웃</a>
            </c:when>

            <c:otherwise>
                <a href="${contextPath}/member/login" class="header-btn header-login">로그인</a>
                <a href="${contextPath}/member/signup" class="header-btn header-join">회원가입</a>
            </c:otherwise>
        </c:choose>

        <button type="button" id="darkModeToggle" class="dark-toggle">🌙 다크모드</button>
    </div>
</header>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const darkModeToggle = document.getElementById("darkModeToggle");

    if (!darkModeToggle) {
        return;
    }

    function syncToggleText() {
        darkModeToggle.textContent = document.body.classList.contains("dark-mode") ? "☀️ 라이트모드" : "🌙 다크모드";
    }

    syncToggleText();

    darkModeToggle.addEventListener("click", function () {
        document.body.classList.toggle("dark-mode");
        localStorage.setItem("theme", document.body.classList.contains("dark-mode") ? "dark" : "light");
        syncToggleText();
    });
});
</script>
