<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat 관리자 | 문의 상세</title>

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

/* 사이드바 */
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

/* 메인 */
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

/* 카드 */
.detail-grid {
    display: grid;
    grid-template-columns: minmax(0, 1fr) 360px;
    gap: 24px;
    align-items: start;
}

.card,
.side-card {
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 28px;
    box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
}

.card {
    padding: 34px;
    margin-bottom: 24px;
}

.side-card {
    padding: 28px;
    margin-bottom: 18px;
}

.section-title {
    font-size: 21px;
    color: #2f241d;
    margin-bottom: 22px;
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
    font-size: 28px;
    font-weight: 900;
    color: #2f241d;
    margin-bottom: 18px;
    line-height: 1.4;
}

.meta-box {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
    margin-bottom: 22px;
}

.meta-item {
    background: #fffaf3;
    border: 1px solid #f4d7b7;
    border-radius: 18px;
    padding: 15px 16px;
}

.meta-label {
    display: block;
    font-size: 12px;
    color: #a27755;
    font-weight: 900;
    margin-bottom: 7px;
}

.meta-value {
    display: block;
    font-size: 14px;
    color: #2f241d;
    font-weight: 800;
    word-break: break-all;
}

.status-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 74px;
    padding: 7px 12px;
    border-radius: 999px;
    background: #fff3df;
    color: #b45309;
    font-size: 13px;
    font-weight: 900;
}

.content-box {
    white-space: pre-line;
    line-height: 1.8;
    background: #fffaf3;
    border: 1px solid #f4d7b7;
    padding: 24px;
    border-radius: 20px;
    color: #4b392d;
    font-size: 15px;
}

/* 답변 */
.empty-reply {
    background: #fffaf3;
    border: 1px dashed #f0bf8a;
    border-radius: 20px;
    padding: 28px;
    text-align: center;
    color: #8a7666;
    font-size: 14px;
    line-height: 1.7;
}

.reply {
    white-space: pre-line;
    line-height: 1.8;
    background: #fffaf3;
    border: 1px solid #f4d7b7;
    padding: 22px;
    border-radius: 20px;
    margin-top: 15px;
}

.reply:first-of-type {
    margin-top: 0;
}

.reply-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 14px;
    padding-bottom: 14px;
    margin-bottom: 14px;
    border-bottom: 1px solid #f3dcc5;
}

.reply-admin {
    font-size: 15px;
    font-weight: 900;
    color: #2f241d;
}

.reply-date {
    font-size: 13px;
    color: #9b8170;
    font-weight: 700;
}

.reply-content {
    color: #4b392d;
    font-size: 15px;
}

/* 답변 작성 */
textarea {
    width: 100%;
    box-sizing: border-box;
    min-height: 180px;
    border-radius: 18px;
    border: 1px solid #e8c7a6;
    background: #fff;
    color: #2f241d;
    padding: 16px;
    font-size: 15px;
    resize: vertical;
    outline: none;
    font-family: inherit;
    line-height: 1.7;
}

textarea:focus {
    border-color: #ff914d;
    box-shadow: 0 0 0 4px rgba(255, 145, 77, 0.16);
}

.btn-area {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 18px;
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
    font-family: inherit;
}

.btn-primary {
    background: #ff914d;
    color: #fff;
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

.btn-delete {
    background: #ef4444;
    color: #fff;
    width: 100%;
    box-shadow: 0 8px 20px rgba(239, 68, 68, 0.2);
}

.btn-delete:hover {
    background: #dc2626;
    transform: translateY(-1px);
}

/* 오른쪽 사이드 정보 */
.info-icon {
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

.side-title {
    font-size: 21px;
    font-weight: 900;
    color: #2f241d;
    margin-bottom: 10px;
}

.side-desc {
    color: #7a6a5d;
    font-size: 14px;
    line-height: 1.7;
}

.quick-list {
    display: grid;
    gap: 12px;
    margin-top: 18px;
}

.quick-link {
    display: block;
    text-decoration: none;
    background: #fffaf3;
    border: 1px solid #f4d7b7;
    border-radius: 16px;
    padding: 14px 16px;
    color: #a27755;
    font-weight: 900;
    font-size: 14px;
    transition: 0.2s;
}

.quick-link:hover {
    background: #ff914d;
    color: #fff;
    box-shadow: 0 8px 18px rgba(255, 145, 77, 0.28);
}

.delete-form {
    margin-top: 10px;
}

.notice-box {
    margin-top: 18px;
    padding: 16px;
    border-radius: 18px;
    background: #fff7ed;
    border: 1px solid #fed7aa;
    color: #9a521e;
    font-size: 13px;
    line-height: 1.6;
}

@media (max-width: 1100px) {
    .detail-grid {
        grid-template-columns: 1fr;
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

    .admin-badge {
        margin-top: 16px;
    }

    .meta-box {
        grid-template-columns: 1fr;
    }

    .btn-area {
        flex-direction: column;
    }

    .btn {
        width: 100%;
        text-align: center;
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

    <c:set var="activeAdminMenu" value="inquiries" />
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <main class="main">

        <div class="top-bar">
            <div class="page-title">
                <h1>문의 상세 관리</h1>
                <p>사용자가 남긴 문의 내용을 확인하고 답변을 등록합니다.</p>
            </div>

            <div class="admin-badge">INQUIRY DETAIL</div>
        </div>

        <div class="detail-grid">

            <section>

                <div class="card">
                    <h2 class="section-title">문의 내용</h2>

                    <div class="inquiry-title">
                        ${inquiry.title}
                    </div>

                    <div class="meta-box">
                        <div class="meta-item">
                            <span class="meta-label">작성자</span>
                            <span class="meta-value">
                                ${inquiry.name} (${inquiry.loginId})
                            </span>
                        </div>

                        <div class="meta-item">
                            <span class="meta-label">작성일</span>
                            <span class="meta-value">
                                ${inquiry.createdAt}
                            </span>
                        </div>

                        <div class="meta-item">
                            <span class="meta-label">문의 번호</span>
                            <span class="meta-value">
                                ${inquiry.inquiryId}
                            </span>
                        </div>

                        <div class="meta-item">
                            <span class="meta-label">상태</span>
                            <span class="meta-value">
                                <span class="status-badge">
                                    ${inquiry.status}
                                </span>
                            </span>
                        </div>
                    </div>

                    <div class="content-box">
                        ${inquiry.content}
                    </div>
                </div>

                <div class="card">
                    <h2 class="section-title">기존 답변</h2>

                    <c:choose>
                        <c:when test="${empty replyList}">
                            <div class="empty-reply">
                                아직 등록된 답변이 없습니다.<br>
                                아래 답변 작성 영역에서 첫 답변을 남겨주세요.
                            </div>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="reply" items="${replyList}">
                                <div class="reply">
                                    <div class="reply-head">
                                        <div class="reply-admin">
                                            ${reply.adminName}
                                        </div>

                                        <div class="reply-date">
                                            ${reply.createdAt}
                                        </div>
                                    </div>

                                    <div class="reply-content">
                                        ${reply.content}
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="card">
                    <h2 class="section-title">답변 작성</h2>

                    <form action="${contextPath}/admin/inquiry/${inquiry.inquiryId}/reply"
                          method="post">

                        <input type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}">

                        <textarea name="content"
                                  placeholder="답변 내용을 입력하세요"
                                  required></textarea>

                        <div class="btn-area">
                            <a class="btn btn-soft"
                               href="${contextPath}/admin/inquiries">
                                목록으로
                            </a>

                            <button class="btn btn-primary"
                                    type="submit">
                                답변 등록
                            </button>
                        </div>
                    </form>
                </div>

            </section>

            <aside>

                <div class="side-card">
                    <div class="info-icon">💬</div>

                    <div class="side-title">문의 처리 안내</div>

                    <div class="side-desc">
                        사용자가 남긴 문의 내용을 확인한 뒤 답변을 등록하면 문의 상태를
                        처리 완료로 변경할 수 있습니다.
                    </div>

                    <div class="notice-box">
                        답변 등록 시 사용자 문의 상세 화면에서도 답변이 보여야 합니다.
                        답변 등록 후 상태값이 바뀌지 않는다면 Service 또는 Repository에서
                        status 업데이트 로직을 확인하세요.
                    </div>
                </div>

                <div class="side-card">
                    <div class="side-title">빠른 이동</div>

                    <div class="quick-list">
                        <a class="quick-link" href="${contextPath}/admin/inquiries">
                            문의 목록
                        </a>

                        <a class="quick-link" href="${contextPath}/admin">
                            관리자 대시보드
                        </a>

                        <a class="quick-link" href="${contextPath}/admin/members">
                            회원 관리
                        </a>

                        <a class="quick-link" href="${contextPath}/admin/reviewList">
                            리뷰 관리
                        </a>
                    </div>
                </div>

                <div class="side-card">
                    <div class="side-title">문의 삭제</div>

                    <div class="side-desc">
                        삭제하면 해당 문의가 목록에서 사라집니다.
                        필요한 경우에만 삭제하세요.
                    </div>

                    <form class="delete-form"
                          action="${contextPath}/admin/inquiry/${inquiry.inquiryId}/delete"
                          method="post"
                          onsubmit="return confirm('이 문의를 삭제하시겠습니까?');">

                        <input type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}">

                        <button class="btn btn-delete"
                                type="submit">
                            문의 삭제
                        </button>
                    </form>
                </div>

            </aside>

        </div>

    </main>

</div>

</body>
</html>