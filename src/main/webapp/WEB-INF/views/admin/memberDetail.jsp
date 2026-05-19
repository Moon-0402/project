<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 관리자 | 회원 상세</title>

<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: 'Pretendard', 'Noto Sans KR', Arial, sans-serif;
    background: linear-gradient(135deg, #fff7ed 0%, #fff1e6 45%, #fef3c7 100%);
    color: #2f241d;
    min-height: 100vh;
}

.admin-layout {
    display: flex;
    min-height: 100vh;
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
    padding: 38px 48px;
}

.page-title {
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
}

.detail-wrap {
    display: grid;
    grid-template-columns: 320px 1fr;
    gap: 28px;
}

.profile-card,
.info-card {
    background: rgba(255, 255, 255, 0.84);
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
    font-size: 24px;
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

.info-card {
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

.info-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 18px;
}

.info-item {
    background: #fffaf3;
    border: 1px solid #f4d7b7;
    border-radius: 18px;
    padding: 18px 20px;
}

.info-label {
    font-size: 13px;
    color: #a27755;
    margin-bottom: 9px;
    font-weight: 900;
}

.info-value {
    font-size: 16px;
    color: #2f241d;
    font-weight: 800;
    word-break: break-all;
}

.full {
    grid-column: 1 / 3;
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
}

.btn-list {
    background: #f3e7dc;
    color: #5f4a3a;
}

.btn-edit {
    background: #ff914d;
    color: #fff;
}

.btn-delete {
    background: #fee2e2;
    color: #b91c1c;
}

.btn-delete:hover {
    background: #fecaca;
}

.delete-form {
    display: inline;
}

.empty-box {
    background: #fff;
    border-radius: 24px;
    padding: 50px;
    text-align: center;
    color: #8a7666;
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

    .detail-wrap,
    .info-grid {
        grid-template-columns: 1fr;
    }

    .full {
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
/* Admin dark mode: compact, non-invasive override */
body.dark-mode {
    background: linear-gradient(135deg, #111827 0%, #1f2937 55%, #0f172a 100%) !important;
    color: #f9fafb !important;
}

body.dark-mode .admin-layout,
body.dark-mode .main,
body.dark-mode .container,
body.dark-mode .content {
    color: #f9fafb !important;
}

body.dark-mode .sidebar,
body.dark-mode .side,
body.dark-mode .admin-sidebar {
    background: #0f172a !important;
    border-color: #334155 !important;
    color: #f9fafb !important;
}

body.dark-mode .logo,
body.dark-mode .sidebar .logo {
    color: #ffb86b !important;
    background: transparent !important;
    box-shadow: none !important;
}

body.dark-mode .logo span,
body.dark-mode .sidebar .logo span {
    color: #ffffff !important;
}

body.dark-mode .logo-box,
body.dark-mode .logo-link,
body.dark-mode .menu-list,
body.dark-mode .top-bar,
body.dark-mode .button-area,
body.dark-mode .btn-area,
body.dark-mode .actions,
body.dark-mode .card-actions,
body.dark-mode .pagination-wrap {
    background: transparent !important;
    box-shadow: none !important;
}

body.dark-mode .card,
body.dark-mode .panel,
body.dark-mode .content-box,
body.dark-mode .content-card,
body.dark-mode .detail-card,
body.dark-mode .form-card,
body.dark-mode .table-card,
body.dark-mode .reply-card,
body.dark-mode .search-box,
body.dark-mode .search-area,
body.dark-mode .summary-card,
body.dark-mode .stat-card,
body.dark-mode .feature-item,
body.dark-mode .inquiry-card {
    background: #1f2937 !important;
    border-color: #374151 !important;
    color: #f9fafb !important;
    box-shadow: 0 16px 38px rgba(0,0,0,0.28) !important;
}

body.dark-mode h1,
body.dark-mode h2,
body.dark-mode h3,
body.dark-mode h4,
body.dark-mode .title,
body.dark-mode .page-title,
body.dark-mode .section-title,
body.dark-mode .panel-title,
body.dark-mode .card-title,
body.dark-mode .task-title,
body.dark-mode .feature-title,
body.dark-mode .stat-value,
body.dark-mode .inquiry-title,
body.dark-mode .member-name,
body.dark-mode .restaurant-name {
    color: #f9fafb !important;
}

body.dark-mode p,
body.dark-mode label,
body.dark-mode small,
body.dark-mode .desc,
body.dark-mode .description,
body.dark-mode .page-title p,
body.dark-mode .section-subtitle,
body.dark-mode .task-desc,
body.dark-mode .feature-desc,
body.dark-mode .stat-desc,
body.dark-mode .info-label,
body.dark-mode .info-value,
body.dark-mode .meta,
body.dark-mode .date-cell,
body.dark-mode .page-info,
body.dark-mode .empty-message {
    color: #d1d5db !important;
}

body.dark-mode input,
body.dark-mode textarea,
body.dark-mode select {
    background: #111827 !important;
    border-color: #4b5563 !important;
    color: #f9fafb !important;
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

body.dark-mode thead th {
    background: #111827 !important;
    color: #f9fafb !important;
}

body.dark-mode .btn,
body.dark-mode .btn-primary,
body.dark-mode .search-btn,
body.dark-mode .add-btn,
body.dark-mode .answer-btn,
body.dark-mode .btn-save,
body.dark-mode .btn-submit {
    background: #fb923c !important;
    border-color: #fb923c !important;
    color: #111827 !important;
}

body.dark-mode .btn-soft,
body.dark-mode .back-btn,
body.dark-mode .reset-btn,
body.dark-mode .btn-list,
body.dark-mode .btn-detail,
body.dark-mode .btn-edit,
body.dark-mode .btn-delete {
    background: #111827 !important;
    border-color: #4b5563 !important;
    color: #f9fafb !important;
}

body.dark-mode .menu-list a {
    color: #e5e7eb !important;
}

body.dark-mode .menu-list a:hover,
body.dark-mode .menu-list a.active {
    background: #fb923c !important;
    color: #111827 !important;
}

body.dark-mode .pagination a,
body.dark-mode .page-link,
body.dark-mode .page-btn,
body.dark-mode .page-num,
body.dark-mode .pagination-wrap a,
body.dark-mode .pagination-wrap span {
    background: #111827 !important;
    border-color: #4b5563 !important;
    color: #f9fafb !important;
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
<script id="pke-theme-init">
(function () {
    if (localStorage.getItem("theme") === "dark") {
        document.body.classList.add("dark-mode");
    }
})();
</script>

<div class="admin-layout">

    <c:set var="activeAdminMenu" value="members" />
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <main class="main">

        <c:choose>
            <c:when test="${not empty member}">

                <div class="page-title">
                    <h1>회원 상세 정보</h1>
                    <p>PickEat 회원의 기본 정보를 확인합니다.</p>
                </div>

                <div class="detail-wrap">

                    <section class="profile-card">
                        <div class="member-name">${member.name}</div>
                        <div class="member-login-id">@${member.loginId}</div>

                        <div class="role-badge">${member.role}</div>

                        <div class="mini-info">
                            <p><strong>회원번호</strong><br>${member.memberId}</p>
                            <p><strong>가입일</strong><br>${member.created_at}</p>
                        </div>
                    </section>

                    <section class="info-card">
                        <h2 class="section-title">기본 정보</h2>

                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-label">회원 번호</div>
                                <div class="info-value">${member.memberId}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-label">로그인 ID</div>
                                <div class="info-value">${member.loginId}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-label">이름</div>
                                <div class="info-value">${member.name}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-label">이메일</div>
                                <div class="info-value">${member.email}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-label">전화번호</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${empty member.phone}">등록된 전화번호 없음</c:when>
                                        <c:otherwise>${member.phone}</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="info-item">
                                <div class="info-label">권한</div>
                                <div class="info-value">${member.role}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-label">가입일</div>
                                <div class="info-value">${member.created_at}</div>
                            </div>

                            <div class="info-item full">
                                <div class="info-label">관리 안내</div>
                                <div class="info-value">
                                    이 페이지는 memberId 기준으로 회원 정보를 조회합니다.
                                </div>
                            </div>
                        </div>

                        <div class="button-area">
                            <a href="${pageContext.request.contextPath}/admin/members" class="btn btn-list">
                                목록으로
                            </a>

                            <a href="${pageContext.request.contextPath}/admin/member/update?memberId=${member.memberId}" class="btn btn-edit">
                                회원 수정
                            </a>

                            <form action="${pageContext.request.contextPath}/admin/member/delete?memberId=${member.memberId}"
                                  method="post"
                                  class="delete-form"
                                  onsubmit="return confirm('정말 이 회원을 삭제하시겠습니까? 삭제 후 복구할 수 없습니다.');">

                                <input type="hidden" name="_method" value="delete">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                                <button type="submit" class="btn btn-delete">
                                    회원 삭제
                                </button>
                            </form>
                        </div>
                    </section>

                </div>

            </c:when>

            <c:otherwise>
                <div class="empty-box">
                    <h2>회원 정보를 찾을 수 없습니다.</h2>
                    <p style="margin-top: 12px;">memberId 값으로 조회된 회원 데이터가 없습니다.</p>

                    <div style="margin-top: 28px;">
                        <a href="${pageContext.request.contextPath}/admin/members" class="btn btn-list">
                            목록으로 돌아가기
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </main>
</div>

</body>
</html>