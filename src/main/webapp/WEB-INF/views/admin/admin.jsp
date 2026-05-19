<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 관리자 | 대시보드</title>

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

body.dark-mode {
    background: linear-gradient(135deg, #111827 0%, #1f2937 55%, #0f172a 100%);
    color: #f9fafb;
}

.admin-layout {
    display: flex;
    min-height: 100vh;
}

.sidebar {
    width: 250px;
    background: #2f241d;
    color: #ffffff;
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
    letter-spacing: -1px;
    transition: 0.2s;
}

.logo span {
    color: #ffffff;
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
    color: #ffffff;
    box-shadow: 0 8px 18px rgba(255, 145, 77, 0.35);
}

.main {
    flex: 1;
    padding: 38px 48px;
}

.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 20px;
    margin-bottom: 34px;
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

.admin-badge,
.theme-toggle {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    background: rgba(255, 255, 255, 0.78);
    border: 1px solid rgba(255, 184, 107, 0.45);
    color: #a15c22;
    padding: 10px 16px;
    border-radius: 999px;
    font-size: 13px;
    font-weight: 900;
    white-space: nowrap;
}

.top-actions {
    display: flex;
    gap: 10px;
    align-items: center;
}

.theme-toggle {
    cursor: pointer;
}

.hero-card {
    display: grid;
    grid-template-columns: 1.4fr 0.8fr;
    gap: 24px;
    margin-bottom: 28px;
}

.welcome-card,
.inquiry-card,
.stat-card,
.panel {
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 28px;
    box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
}

.welcome-card,
.inquiry-card {
    padding: 32px;
}

.welcome-card {
    position: relative;
    overflow: hidden;
}

.welcome-card::after {
    content: "🍜";
    position: absolute;
    right: 28px;
    bottom: 18px;
    font-size: 88px;
    opacity: 0.12;
}

.welcome-title {
    font-size: 27px;
    font-weight: 900;
    color: #2f241d;
    margin-bottom: 12px;
}

.welcome-text {
    color: #7a6a5d;
    line-height: 1.8;
    font-size: 15px;
    max-width: 650px;
}

.quick-actions {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    margin-top: 26px;
}

.btn {
    border: none;
    outline: none;
    border-radius: 14px;
    padding: 13px 18px;
    font-size: 14px;
    font-weight: 900;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
    transition: 0.2s;
}

.btn-primary {
    background: #ff914d;
    color: #ffffff;
    box-shadow: 0 8px 20px rgba(255, 145, 77, 0.32);
}

.btn-primary:hover {
    background: #f97316;
    transform: translateY(-1px);
}

.btn-soft {
    background: #fff3df;
    color: #b45309;
}

.btn-soft:hover {
    background: #fed7aa;
}

.inquiry-icon {
    width: 72px;
    height: 72px;
    border-radius: 24px;
    background: linear-gradient(135deg, #ff914d, #ffc971);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 34px;
    box-shadow: 0 14px 30px rgba(255, 145, 77, 0.28);
    margin-bottom: 18px;
}

.inquiry-card h2 {
    font-size: 22px;
    color: #2f241d;
    margin-bottom: 10px;
}

.inquiry-card p {
    color: #7a6a5d;
    font-size: 14px;
    line-height: 1.7;
}

.dashboard-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    margin-bottom: 28px;
}

.stat-card {
    padding: 24px;
}

.stat-icon {
    width: 50px;
    height: 50px;
    border-radius: 18px;
    background: #fff3df;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 25px;
    margin-bottom: 16px;
}

.stat-label {
    font-size: 13px;
    color: #a27755;
    font-weight: 900;
    margin-bottom: 8px;
}

.stat-value {
    font-size: 28px;
    font-weight: 900;
    color: #2f241d;
}

.stat-desc {
    margin-top: 8px;
    color: #8a7666;
    font-size: 13px;
    line-height: 1.5;
}

.content-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 24px;
}

.panel {
    padding: 30px;
}

.panel-title {
    font-size: 21px;
    color: #2f241d;
    margin-bottom: 22px;
    display: flex;
    align-items: center;
    gap: 10px;
}

.panel-title::before {
    content: "";
    width: 8px;
    height: 24px;
    background: #ff914d;
    border-radius: 999px;
}

.task-list {
    list-style: none;
}

.task-list li {
    display: flex;
    align-items: flex-start;
    gap: 14px;
    padding: 16px 0;
    border-bottom: 1px solid #f3dcc5;
}

.task-list li:last-child {
    border-bottom: none;
}

.task-icon {
    width: 38px;
    height: 38px;
    border-radius: 14px;
    background: #fff3df;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    font-size: 18px;
    font-weight: 900;
}

.task-title {
    font-size: 15px;
    color: #2f241d;
    font-weight: 900;
    margin-bottom: 5px;
}

.task-desc {
    font-size: 13px;
    color: #7a6a5d;
    line-height: 1.5;
}

.feature-list {
    display: grid;
    gap: 14px;
}

.feature-item {
    display: block;
    text-decoration: none;
    background: #fffaf3;
    border: 1px solid #f4d7b7;
    border-radius: 18px;
    padding: 18px 20px;
    transition: 0.2s;
}

.feature-item:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 24px rgba(90, 64, 43, 0.12);
    border-color: #ffb86b;
}

.feature-title {
    display: block;
    color: #2f241d;
    font-size: 16px;
    font-weight: 900;
    margin-bottom: 6px;
}

.feature-desc {
    display: block;
    color: #7a6a5d;
    font-size: 13px;
    line-height: 1.5;
}

body.dark-mode .sidebar {
    background: #0f172a;
    box-shadow: 8px 0 24px rgba(0, 0, 0, 0.25);
}

body.dark-mode .logo {
    color: #ffb86b;
}

body.dark-mode .logo span {
    color: #ffffff;
}

body.dark-mode .logo-desc,
body.dark-mode .menu-title {
    color: #cbd5e1;
}

body.dark-mode .menu-list a {
    color: #e5e7eb;
}

body.dark-mode .menu-list a:hover,
body.dark-mode .menu-list a.active {
    background: #fb923c;
    color: #111827;
}

body.dark-mode .page-title h1,
body.dark-mode .welcome-title,
body.dark-mode .inquiry-card h2,
body.dark-mode .stat-value,
body.dark-mode .panel-title,
body.dark-mode .task-title,
body.dark-mode .feature-title {
    color: #f9fafb;
}

body.dark-mode .page-title p,
body.dark-mode .welcome-text,
body.dark-mode .inquiry-card p,
body.dark-mode .stat-desc,
body.dark-mode .task-desc,
body.dark-mode .feature-desc {
    color: #d1d5db;
}

body.dark-mode .welcome-card,
body.dark-mode .inquiry-card,
body.dark-mode .stat-card,
body.dark-mode .panel,
body.dark-mode .feature-item {
    background: #1f2937;
    border-color: #374151;
    box-shadow: 0 18px 45px rgba(0, 0, 0, 0.28);
}

body.dark-mode .stat-icon,
body.dark-mode .task-icon,
body.dark-mode .btn-soft {
    background: #111827;
    color: #f9fafb;
    border: 1px solid #4b5563;
}

body.dark-mode .stat-label,
body.dark-mode .admin-badge,
body.dark-mode .theme-toggle {
    color: #fed7aa;
}

body.dark-mode .admin-badge,
body.dark-mode .theme-toggle {
    background: rgba(251, 146, 60, 0.16);
    border-color: rgba(251, 146, 60, 0.36);
}

body.dark-mode .task-list li {
    border-bottom-color: #374151;
}

body.dark-mode .btn-primary {
    background: #fb923c;
    color: #111827;
}

body.dark-mode .btn-primary:hover {
    background: #fdba74;
}

@media (max-width: 1100px) {
    .hero-card,
    .content-grid {
        grid-template-columns: 1fr;
    }

    .dashboard-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

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

    .top-actions {
        margin-top: 16px;
        flex-wrap: wrap;
    }

    .dashboard-grid {
        grid-template-columns: 1fr;
    }
}


/* ===== PickEat admin common sidebar / dark-mode fix ===== */
.admin-layout,
.page-wrap {
    min-height: 100vh;
}

.admin-layout > .sidebar,
.page-wrap > .sidebar,
.sidebar.admin-sidebar {
    width: 250px !important;
    min-width: 250px !important;
    background: #2f241d !important;
    color: #ffffff !important;
    padding: 30px 24px !important;
    box-shadow: 8px 0 24px rgba(47, 36, 29, 0.15) !important;
    border-right: 0 !important;
    display: block !important;
}

.sidebar .logo-box,
.admin-sidebar .logo-box {
    margin-bottom: 38px !important;
}

.sidebar .logo-link,
.admin-sidebar .logo-link {
    display: inline-block !important;
    text-decoration: none !important;
    color: inherit !important;
    background: transparent !important;
    box-shadow: none !important;
}

.sidebar .logo,
.admin-sidebar .logo {
    font-size: 30px !important;
    line-height: 1 !important;
    font-weight: 950 !important;
    color: #ffb86b !important;
    letter-spacing: -1px !important;
    background: transparent !important;
}

.sidebar .logo span,
.admin-sidebar .logo span {
    color: #ffffff !important;
}

.sidebar .logo-desc,
.admin-sidebar .logo-desc {
    font-size: 13px !important;
    color: #d6c7b8 !important;
    margin-top: 10px !important;
    line-height: 1.5 !important;
}

.sidebar .menu-title,
.admin-sidebar .menu-title {
    font-size: 12px !important;
    color: #a99584 !important;
    margin: 0 0 12px !important;
    text-transform: uppercase !important;
    font-weight: 900 !important;
    letter-spacing: 0.04em !important;
}

.sidebar .admin-menu-subtitle,
.admin-sidebar .admin-menu-subtitle {
    margin-top: 28px !important;
}

.sidebar .menu-list,
.admin-sidebar .menu-list {
    list-style: none !important;
    margin: 0 !important;
    padding: 0 !important;
    display: block !important;
}

.sidebar .menu-list li,
.admin-sidebar .menu-list li {
    margin: 0 0 10px !important;
    padding: 0 !important;
}

.sidebar .menu-list a,
.sidebar .admin-side-theme-toggle,
.admin-sidebar .menu-list a,
.admin-sidebar .admin-side-theme-toggle {
    width: 100% !important;
    display: flex !important;
    align-items: center !important;
    min-height: 46px !important;
    text-decoration: none !important;
    color: #eee2d6 !important;
    padding: 13px 15px !important;
    border-radius: 14px !important;
    border: 1px solid transparent !important;
    background: transparent !important;
    box-shadow: none !important;
    transition: 0.2s !important;
    font-size: 15px !important;
    font-weight: 850 !important;
    font-family: inherit !important;
    text-align: left !important;
    cursor: pointer !important;
}

.sidebar .menu-list a:hover,
.sidebar .menu-list a.active,
.sidebar .admin-side-theme-toggle:hover,
.admin-sidebar .menu-list a:hover,
.admin-sidebar .menu-list a.active,
.admin-sidebar .admin-side-theme-toggle:hover {
    background: #ff914d !important;
    color: #ffffff !important;
    border-color: rgba(255, 255, 255, 0.12) !important;
    box-shadow: 0 8px 18px rgba(255, 145, 77, 0.35) !important;
}

body.dark-mode {
    background: linear-gradient(135deg, #111827 0%, #1f2937 55%, #0f172a 100%) !important;
    color: #f9fafb !important;
}

body.dark-mode .admin-layout > .sidebar,
body.dark-mode .page-wrap > .sidebar,
body.dark-mode .sidebar.admin-sidebar {
    background: #0f172a !important;
    color: #f9fafb !important;
    box-shadow: 8px 0 24px rgba(0, 0, 0, 0.28) !important;
}

body.dark-mode .sidebar .logo,
body.dark-mode .admin-sidebar .logo {
    color: #ffb86b !important;
}

body.dark-mode .sidebar .logo span,
body.dark-mode .admin-sidebar .logo span {
    color: #ffffff !important;
}

body.dark-mode .sidebar .logo-desc,
body.dark-mode .sidebar .menu-title,
body.dark-mode .admin-sidebar .logo-desc,
body.dark-mode .admin-sidebar .menu-title {
    color: #cbd5e1 !important;
}

body.dark-mode .sidebar .menu-list a,
body.dark-mode .sidebar .admin-side-theme-toggle,
body.dark-mode .admin-sidebar .menu-list a,
body.dark-mode .admin-sidebar .admin-side-theme-toggle {
    color: #e5e7eb !important;
    background: transparent !important;
}

body.dark-mode .sidebar .menu-list a:hover,
body.dark-mode .sidebar .menu-list a.active,
body.dark-mode .sidebar .admin-side-theme-toggle:hover,
body.dark-mode .admin-sidebar .menu-list a:hover,
body.dark-mode .admin-sidebar .menu-list a.active,
body.dark-mode .admin-sidebar .admin-side-theme-toggle:hover {
    background: #fb923c !important;
    color: #111827 !important;
}

body.dark-mode .main,
body.dark-mode main,
body.dark-mode .content,
body.dark-mode .main-content {
    color: #f9fafb !important;
}

body.dark-mode h1,
body.dark-mode h2,
body.dark-mode h3,
body.dark-mode h4,
body.dark-mode .page-title h1,
body.dark-mode .section-title,
body.dark-mode .panel-title,
body.dark-mode .card-title,
body.dark-mode .detail-title,
body.dark-mode .list-title,
body.dark-mode .form-title,
body.dark-mode .stat-value,
body.dark-mode .feature-title,
body.dark-mode .task-title {
    color: #f9fafb !important;
}

body.dark-mode p,
body.dark-mode label,
body.dark-mode small,
body.dark-mode li,
body.dark-mode .page-title p,
body.dark-mode .desc,
body.dark-mode .description,
body.dark-mode .sub-text,
body.dark-mode .muted,
body.dark-mode .meta,
body.dark-mode .date,
body.dark-mode .address,
body.dark-mode .help-text,
body.dark-mode .feature-desc,
body.dark-mode .task-desc,
body.dark-mode .stat-desc,
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
body.dark-mode .detail-card,
body.dark-mode .list-card,
body.dark-mode .table-card,
body.dark-mode .search-box,
body.dark-mode .search-area,
body.dark-mode .search-card,
body.dark-mode .stat-card,
body.dark-mode .welcome-card,
body.dark-mode .inquiry-card,
body.dark-mode .feature-item,
body.dark-mode .form-item,
body.dark-mode .info-box,
body.dark-mode .info-card,
body.dark-mode .reply-card,
body.dark-mode .empty-box,
body.dark-mode .pagination,
body.dark-mode .filter-box {
    background: #1f2937 !important;
    color: #f9fafb !important;
    border-color: #374151 !important;
    box-shadow: 0 18px 45px rgba(0, 0, 0, 0.28) !important;
}

body.dark-mode input,
body.dark-mode textarea,
body.dark-mode select,
body.dark-mode .form-input,
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
body.dark-mode .btn-primary,
body.dark-mode .primary-btn,
body.dark-mode .submit-btn,
body.dark-mode .search-btn,
body.dark-mode .save-btn,
body.dark-mode .btn-save,
body.dark-mode .answer-btn,
body.dark-mode .add-btn {
    background: #fb923c !important;
    border-color: #fb923c !important;
    color: #111827 !important;
}

body.dark-mode .btn-soft,
body.dark-mode .btn-list,
body.dark-mode .btn-detail,
body.dark-mode .btn-edit,
body.dark-mode .btn-delete,
body.dark-mode .back-btn,
body.dark-mode .reset-btn,
body.dark-mode .cancel-btn,
body.dark-mode .secondary-btn,
body.dark-mode .detail-btn,
body.dark-mode .edit-btn,
body.dark-mode .delete-btn {
    background: #111827 !important;
    border-color: #4b5563 !important;
    color: #f9fafb !important;
}

body.dark-mode .pagination a,
body.dark-mode .pagination span,
body.dark-mode .page-link,
body.dark-mode .page-btn,
body.dark-mode .page-num {
    background: #1f2937 !important;
    border-color: #4b5563 !important;
    color: #e5e7eb !important;
}

body.dark-mode .pagination a.active,
body.dark-mode .pagination a:hover,
body.dark-mode .page-link.active,
body.dark-mode .page-link:hover,
body.dark-mode .page-btn.active,
body.dark-mode .page-btn:hover,
body.dark-mode .page-num.active,
body.dark-mode .page-num:hover {
    background: #fb923c !important;
    border-color: #fb923c !important;
    color: #111827 !important;
}

@media (max-width: 900px) {
    .admin-layout,
    .page-wrap {
        display: block !important;
    }

    .admin-layout > .sidebar,
    .page-wrap > .sidebar,
    .sidebar.admin-sidebar {
        width: 100% !important;
        min-width: 0 !important;
    }
}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pickeat-final-fix.css?v=20260519fix4">
<script src="${pageContext.request.contextPath}/resources/js/pickeat-theme-fix.js?v=20260519fix4"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pickeat-hard-fix.css?v=20260519hard3">
</head>

<body>
<script>
(function () {
    if (localStorage.getItem("theme") === "dark") {
        document.body.classList.add("dark-mode");
    }
})();
</script>

<div class="admin-layout">
    <c:set var="activeAdminMenu" value="dashboard" />
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <main class="main">
        <div class="top-bar">
            <div class="page-title">
                <h1>PickEat 관리자 대시보드</h1>
                <p>회원, 맛집, 리뷰, 문의 흐름을 한눈에 관리합니다.</p>
            </div>

            <div class="top-actions">
                <button type="button" id="adminThemeToggle" class="theme-toggle">🌙 다크모드</button>
                <div class="admin-badge">ADMIN MODE</div>
            </div>
        </div>

        <section class="hero-card">
            <div class="welcome-card">
                <div class="welcome-title">오늘도 맛있는 운영을 시작합니다</div>
                <p class="welcome-text">
                    PickEat은 날씨와 사용자 상황을 바탕으로 맛집을 추천하는 서비스입니다.
                    관리자 페이지에서는 회원 정보와 서비스 데이터를 관리하고,
                    사용자의 문의와 리뷰를 확인해 서비스 흐름을 안정적으로 운영할 수 있습니다.
                </p>

                <div class="quick-actions">
                    <a href="${contextPath}/admin/members" class="btn btn-primary">회원 관리 바로가기</a>
                    <a href="${contextPath}/admin/restaurants" class="btn btn-soft">맛집 관리</a>
                    <a href="${contextPath}/admin/reviewList" class="btn btn-soft">리뷰 관리</a>
                </div>
            </div>

            <div class="inquiry-card">
                <div>
                    <div class="inquiry-icon">💬</div>
                    <h2>문의 관리</h2>
                    <p>
                        사용자가 남긴 문의를 확인하고 답변을 등록하는 영역입니다.
                        처리 상태를 확인하면서 답변을 관리할 수 있습니다.
                    </p>
                </div>

                <div style="margin-top: 22px;">
                    <a href="${contextPath}/admin/inquiries" class="btn btn-primary">문의 관리 이동</a>
                </div>
            </div>
        </section>

        <section class="dashboard-grid">
            <div class="stat-card">
                <div class="stat-icon">👥</div>
                <div class="stat-label">회원 관리</div>
                <div class="stat-value">USER</div>
                <div class="stat-desc">가입 회원의 기본 정보를 조회하고 수정합니다.</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">🍱</div>
                <div class="stat-label">맛집 관리</div>
                <div class="stat-value">FOOD</div>
                <div class="stat-desc">맛집 데이터와 추천 대상 정보를 관리합니다.</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">⭐</div>
                <div class="stat-label">리뷰 관리</div>
                <div class="stat-value">REVIEW</div>
                <div class="stat-desc">사용자가 작성한 리뷰와 평점을 확인합니다.</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">💬</div>
                <div class="stat-label">문의 관리</div>
                <div class="stat-value">Q&amp;A</div>
                <div class="stat-desc">문의 내용을 확인하고 답변을 등록합니다.</div>
            </div>
        </section>

        <section class="content-grid">
            <div class="panel">
                <h2 class="panel-title">관리자 작업 순서</h2>

                <ul class="task-list">
                    <li>
                        <div class="task-icon">1</div>
                        <div>
                            <div class="task-title">회원 정보 확인</div>
                            <div class="task-desc">회원 목록에서 memberId 기준으로 상세 정보와 수정 화면에 접근합니다.</div>
                        </div>
                    </li>

                    <li>
                        <div class="task-icon">2</div>
                        <div>
                            <div class="task-title">문의 답변 처리</div>
                            <div class="task-desc">문의 관리에서 사용자의 질문을 확인하고 답변을 등록합니다.</div>
                        </div>
                    </li>

                    <li>
                        <div class="task-icon">3</div>
                        <div>
                            <div class="task-title">맛집 / 리뷰 데이터 관리</div>
                            <div class="task-desc">서비스 추천 품질을 위해 맛집과 리뷰 데이터를 점검합니다.</div>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="panel">
                <h2 class="panel-title">빠른 이동</h2>

                <div class="feature-list">
                    <a href="${contextPath}/admin/members" class="feature-item">
                        <span class="feature-title">회원 관리</span>
                        <span class="feature-desc">회원 목록, 상세 정보, 수정 페이지로 이동합니다.</span>
                    </a>

                    <a href="${contextPath}/admin/inquiries" class="feature-item">
                        <span class="feature-title">문의 관리</span>
                        <span class="feature-desc">사용자 문의 목록과 답변 등록 화면으로 이동합니다.</span>
                    </a>

                    <a href="${contextPath}/admin/restaurants" class="feature-item">
                        <span class="feature-title">맛집 관리</span>
                        <span class="feature-desc">추천에 사용될 맛집 데이터를 관리합니다.</span>
                    </a>

                    <a href="${contextPath}/admin/reviewList" class="feature-item">
                        <span class="feature-title">리뷰 관리</span>
                        <span class="feature-desc">회원들이 작성한 리뷰 데이터를 확인합니다.</span>
                    </a>
                </div>
            </div>
        </section>
    </main>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const toggle = document.getElementById("adminThemeToggle");

    if (!toggle) {
        return;
    }

    function syncText() {
        toggle.textContent = document.body.classList.contains("dark-mode") ? "☀️ 라이트모드" : "🌙 다크모드";
    }

    syncText();

    toggle.addEventListener("click", function () {
        document.body.classList.toggle("dark-mode");
        localStorage.setItem("theme", document.body.classList.contains("dark-mode") ? "dark" : "light");
        syncText();
    });
});
</script>
</body>
</html>
