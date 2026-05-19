<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pickeat-hard-fix.css?v=20260519hard3">
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pickeat-final-fix.css?v=20260519fix4">
<script src="${pageContext.request.contextPath}/resources/js/pickeat-theme-fix.js?v=20260519fix4"></script>

<aside class="sidebar admin-sidebar">
    <div class="logo-box">
        <a href="${contextPath}/" class="logo-link">
            <div class="logo">Pick<span>Eat</span></div>
        </a>
        <div class="logo-desc">관리자 통합 메뉴</div>
    </div>

    <div class="menu-title">Admin Menu</div>
    <ul class="menu-list admin-menu-list">
        <li><a href="${contextPath}/admin" class="${activeAdminMenu eq 'dashboard' ? 'active' : ''}">대시보드</a></li>
        <li><a href="${contextPath}/admin/members" class="${activeAdminMenu eq 'members' ? 'active' : ''}">회원 관리</a></li>
        <li><a href="${contextPath}/admin/inquiries" class="${activeAdminMenu eq 'inquiries' ? 'active' : ''}">문의 관리</a></li>
        <li><a href="${contextPath}/admin/restaurants" class="${activeAdminMenu eq 'restaurants' ? 'active' : ''}">맛집 관리</a></li>
        <li><a href="${contextPath}/admin/reviewList" class="${activeAdminMenu eq 'reviews' ? 'active' : ''}">리뷰 관리</a></li>
    </ul>

    <div class="menu-title admin-menu-subtitle">Service</div>
    <ul class="menu-list admin-menu-list">
        <li><a href="${contextPath}/">서비스 홈</a></li>
        <li><button type="button" class="admin-side-theme-toggle" data-theme-toggle>🌙 다크모드</button></li>
        <li><a href="${contextPath}/member/logout">로그아웃</a></li>
    </ul>
</aside>

<script>
(function () {
    function syncAdminThemeButtons() {
        var isDark = document.body.classList.contains("dark-mode");
        document.querySelectorAll("[data-theme-toggle]").forEach(function (btn) {
            btn.textContent = isDark ? "☀️ 라이트모드" : "🌙 다크모드";
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        syncAdminThemeButtons();
        document.querySelectorAll("[data-theme-toggle]").forEach(function (btn) {
            btn.addEventListener("click", function () {
                document.body.classList.toggle("dark-mode");
                localStorage.setItem("theme", document.body.classList.contains("dark-mode") ? "dark" : "light");
                syncAdminThemeButtons();
            });
        });
    });
})();
</script>
