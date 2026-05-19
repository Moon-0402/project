<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 관리자 | 맛집 등록/수정</title>

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

.menu-list a:hover, .menu-list a.active {
	background: #ff914d;
	color: #fff;
	box-shadow: 0 8px 18px rgba(255, 145, 77, 0.35);
}

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
	content: "🍽️";
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

.content-card {
	background: rgba(255, 255, 255, 0.86);
	border: 1px solid rgba(255, 184, 107, 0.35);
	border-radius: 28px;
	box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
	padding: 28px;
}

.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 18px;
}

.form-grid .full {
	grid-column: 1/3;
}

.input-group label {
	display: block;
	margin-bottom: 8px;
	color: #a15c22;
	font-size: 14px;
	font-weight: 900;
}

.input-group input,
.input-group textarea,
.input-group select {
	width: 100%;
	border-radius: 15px;
	border: 1px solid #f4d7b7;
	background: #fffaf3;
	color: #2f241d;
	font-size: 14px;
	font-weight: 700;
	outline: none;
	font-family: inherit;
	padding: 14px 16px;
}

.input-group input::placeholder,
.input-group textarea::placeholder {
	color: #b49376;
}

.input-group input:focus,
.input-group textarea:focus,
.input-group select:focus {
	border-color: #ff914d;
	box-shadow: 0 0 0 4px rgba(255, 145, 77, 0.16);
}

.input-group textarea {
	min-height: 150px;
	resize: vertical;
	line-height: 1.7;
}

.map-box {
	width: 100%;
	height: 320px;
	margin-top: 24px;
	border-radius: 24px;
	overflow: hidden;
	border: 1px solid #f4d7b7;
	background: #fffaf3;
	box-shadow: 0 14px 34px rgba(90, 64, 43, 0.08);
}

.help-text {
	margin-top: 14px;
	color: #7a6a5d;
	font-size: 13px;
	font-weight: 800;
	line-height: 1.6;
}

.btn-area {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 10px;
	margin-top: 24px;
}

.submit-btn,
.back-btn {
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

.submit-btn {
	border: none;
	background: #ff914d;
	color: #fff;
	box-shadow: 0 8px 20px rgba(255, 145, 77, 0.32);
}

.submit-btn:hover {
	background: #f97316;
	transform: translateY(-1px);
}

.back-btn {
	border: 1px solid #f4d7b7;
	background: #fff3df;
	color: #b45309;
}

.back-btn:hover {
	background: #fed7aa;
}

@media ( max-width : 900px) {
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

	.content-card {
		padding: 20px;
	}

	.form-grid {
		grid-template-columns: 1fr;
	}

	.form-grid .full {
		grid-column: 1;
	}

	.btn-area {
		flex-direction: column;
		align-items: stretch;
	}

	.submit-btn,
	.back-btn {
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

		<c:set var="activeAdminMenu" value="restaurants" />
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

		<main class="main">

			<div class="top-bar">
				<div class="page-title">
					<h1>
						<c:choose>
							<c:when test="${edit}">
								맛집 수정
							</c:when>
							<c:otherwise>
								맛집 등록
							</c:otherwise>
						</c:choose>
					</h1>
					<p>맛집 정보를 입력하고 지도에서 위치를 선택할 수 있습니다.</p>
				</div>

				<div class="admin-badge">RESTAURANT MODE</div>
			</div>

			<section class="summary-card">
				<div class="summary-title">맛집 데이터 입력 센터</div>
				<p class="summary-text">
					맛집 이름, 주소, 카카오 카테고리, 상세 URL, 위치 정보를 등록할 수 있습니다.
					지도에서 원하는 위치를 클릭하면 위도와 경도가 자동으로 입력됩니다.
				</p>
			</section>

			<section class="content-card">

				<form
					action="${contextPath}/admin/restaurants/${empty restaurant.restaurantId ? 'add' : 'update'}"
					method="post">

					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<input type="hidden" name="restaurantId" value="${restaurant.restaurantId}">

					<div class="form-grid">

						<div class="input-group">
							<label>이름</label>
							<input type="text" name="name"
								value="${restaurant.name}"
								placeholder="맛집 이름을 입력하세요"
								required>
						</div>

						<div class="input-group">
							<label>전화번호</label>
							<input type="text" name="phone"
								value="${restaurant.phone}"
								placeholder="전화번호를 입력하세요">
						</div>

						<div class="input-group full">
							<label>주소</label>
							<input type="text" name="address"
								value="${restaurant.address}"
								placeholder="주소를 입력하세요"
								required>
						</div>

						<div class="input-group">
							<label>카카오 카테고리명</label>

							<c:choose>
								<c:when test="${edit}">
									<input type="text" name="kakaoCategoryName"
										value="${restaurant.kakaoCategoryName}"
										placeholder="예: 음식점 > 한식"
										readonly>
								</c:when>

								<c:otherwise>
									<input type="text" name="kakaoCategoryName"
										value="${restaurant.kakaoCategoryName}"
										placeholder="예: 음식점 > 한식">
								</c:otherwise>
							</c:choose>
						</div>

						<div class="input-group">
							<label>가격대</label>
							<input type="text" name="priceRange"
								value="${restaurant.priceRange}"
								placeholder="예: 보통">
						</div>

						<div class="input-group full">
							<label>카카오맵 상세 URL</label>

							<c:choose>
								<c:when test="${edit}">
									<input type="text" name="placeUrl"
										value="${restaurant.placeUrl}"
										placeholder="카카오맵 place_url"
										readonly>
								</c:when>

								<c:otherwise>
									<input type="text" name="placeUrl"
										value="${restaurant.placeUrl}"
										placeholder="카카오맵 place_url">
								</c:otherwise>
							</c:choose>
						</div>

						<div class="input-group">
							<label>영업시간</label>
							<input type="text" name="openingHours"
								value="${restaurant.openingHours}"
								placeholder="예: 매일 10:00 - 22:00">
						</div>

						<div class="input-group">
							<label>상태</label>
							<select name="status" required>
								<option value="ACTIVE"
									${restaurant.status == 'ACTIVE' || empty restaurant.status ? 'selected' : ''}>
									ACTIVE
								</option>
								<option value="INACTIVE"
									${restaurant.status == 'INACTIVE' ? 'selected' : ''}>
									INACTIVE
								</option>
							</select>
						</div>

						<div class="input-group full">
							<label>설명</label>
							<textarea name="description" placeholder="맛집 설명을 입력하세요">${restaurant.description}</textarea>
						</div>

						<div class="input-group">
							<label>위도</label>

							<c:choose>
								<c:when test="${edit}">
									<input type="text" id="lat" name="latitude"
										value="${restaurant.latitude}"
										placeholder="지도를 클릭하면 자동 입력됩니다"
										readonly>
								</c:when>

								<c:otherwise>
									<input type="text" id="lat" name="latitude"
										value="${restaurant.latitude}"
										placeholder="지도를 클릭하면 자동 입력됩니다">
								</c:otherwise>
							</c:choose>
						</div>

						<div class="input-group">
							<label>경도</label>

							<c:choose>
								<c:when test="${edit}">
									<input type="text" id="lng" name="longitude"
										value="${restaurant.longitude}"
										placeholder="지도를 클릭하면 자동 입력됩니다"
										readonly>
								</c:when>

								<c:otherwise>
									<input type="text" id="lng" name="longitude"
										value="${restaurant.longitude}"
										placeholder="지도를 클릭하면 자동 입력됩니다">
								</c:otherwise>
							</c:choose>
						</div>

					</div>

					<div id="map" class="map-box"></div>

					<div class="help-text">지도를 클릭하면 위도와 경도가 자동으로 입력됩니다.</div>

					<div class="btn-area">
						<a class="back-btn" href="${contextPath}/admin/restaurants">목록으로</a>
						<button class="submit-btn" type="submit">저장</button>
					</div>

				</form>

			</section>

		</main>

	</div>

	<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=2a87f90deda3136d9524a194c121dcf1"></script>

	<script>
		var lat = ${restaurant.latitude != null ? restaurant.latitude : 37.5665};
		var lng = ${restaurant.longitude != null ? restaurant.longitude : 126.9780};

		var mapContainer = document.getElementById('map');

		var mapOption = {
			center: new kakao.maps.LatLng(lat, lng),
			level: 3
		};

		var map = new kakao.maps.Map(mapContainer, mapOption);

		var markerPosition = new kakao.maps.LatLng(lat, lng);

		var marker = new kakao.maps.Marker({
			position: markerPosition
		});

		marker.setMap(map);

		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			var latlng = mouseEvent.latLng;

			document.getElementById("lat").value = latlng.getLat();
			document.getElementById("lng").value = latlng.getLng();

			marker.setPosition(latlng);
		});
	</script>

</body>
</html>