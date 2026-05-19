<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pickeat-hard-fix.css?v=20260519hard3">
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pickeat-final-fix.css?v=20260519fix4">
<script src="${pageContext.request.contextPath}/resources/js/pickeat-theme-fix.js?v=20260519fix4"></script>
<style>
.footer {
    background: #111827;
    color: #d1d5db;
    padding: 34px 36px;
}

.footer-inner {
    max-width: 1180px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    gap: 20px;
    align-items: center;
}

.footer-logo {
    color: #ffffff;
    font-size: 24px;
    font-weight: 950;
    margin-bottom: 8px;
}

.footer-text {
    font-size: 13px;
    color: #9ca3af;
    line-height: 1.7;
}

.footer-links {
    display: flex;
    gap: 18px;
    font-size: 13px;
    font-weight: 800;
}

.footer-links a {
    text-decoration: none;
    color: inherit;
}

.footer-links a:hover {
    color: #ffffff;
}

body.dark-mode .footer {
    background: #0f172a !important;
    border-top: 1px solid #374151;
    color: #d1d5db !important;
}

body.dark-mode .footer-logo {
    color: #f9fafb !important;
}

body.dark-mode .footer-text,
body.dark-mode .footer-links a {
    color: #d1d5db !important;
}

body.dark-mode .footer-links a:hover {
    color: #fb923c !important;
}

@media (max-width: 980px) {
    .footer-inner {
        flex-direction: column;
        align-items: flex-start;
    }
}
</style>

<footer class="footer">
    <div class="footer-inner">
        <div>
            <div class="footer-logo">PickEat</div>
            <div class="footer-text">
                날씨와 위치, 취향을 바탕으로 맛집을 추천하는 서비스<br>
                Team Project · Weather Restaurant Recommendation
            </div>
        </div>

        <div class="footer-links">
            <a href="${contextPath}/">홈</a>
            <a href="${contextPath}/recommend">추천</a>
            <a href="${contextPath}/restaurants">맛집 리스트</a>
        </div>
    </div>
</footer>
