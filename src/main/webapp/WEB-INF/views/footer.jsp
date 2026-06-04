<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>
.footer {
    width: 100% !important;
    background: linear-gradient(135deg, #ffedd5 0%, #fed7aa 45%, #fdba74 100%) !important;
    color: #7c2d12 !important;
    padding: 36px 36px 24px !important;
    box-sizing: border-box !important;
    flex-shrink: 0 !important;
}

.footer .footer-inner {
    width: 100% !important;
    max-width: 980px !important;
    margin: 0 auto !important;
    display: flex !important;
    justify-content: space-between !important;
    align-items: flex-start !important;
    gap: 50px !important;
    box-sizing: border-box !important;
}

.footer .footer-brand {
    flex: 1.4 !important;
}

.footer .footer-logo {
    color: #c2410c !important;
    font-size: 25px !important;
    font-weight: 950 !important;
    margin-bottom: 8px !important;
    line-height: 1.2 !important;
}

.footer .footer-text {
    font-size: 13px !important;
    color: #9a3412 !important;
    line-height: 1.7 !important;
    font-weight: 600 !important;
}

.footer .footer-section {
    min-width: 150px !important;
}

.footer .footer-title {
    font-size: 14px !important;
    font-weight: 900 !important;
    color: #c2410c !important;
    margin-bottom: 12px !important;
}

.footer .footer-links {
    display: flex !important;
    flex-direction: column !important;
    gap: 8px !important;
    font-size: 13px !important;
    font-weight: 800 !important;
    white-space: nowrap !important;
}

.footer .footer-links a {
    text-decoration: none !important;
    color: #7c2d12 !important;
}

.footer .footer-links a:hover {
    color: #ff6500 !important;
}

.footer .footer-tech {
    display: flex !important;
    flex-direction: column !important;
    gap: 8px !important;
    font-size: 13px !important;
    font-weight: 700 !important;
    color: #9a3412 !important;
}

.footer .footer-bottom {
    max-width: 980px !important;
    margin: 26px auto 0 !important;
    padding-top: 18px !important;
    border-top: 1px solid rgba(124, 45, 18, 0.18) !important;
    font-size: 12px !important;
    color: #9a3412 !important;
    font-weight: 700 !important;
    text-align: center !important;
}

@media (max-width: 980px) {
    .footer .footer-inner {
        max-width: 100% !important;
        flex-direction: column !important;
        align-items: center !important;
        text-align: center !important;
        gap: 28px !important;
    }

    .footer .footer-links,
    .footer .footer-tech {
        align-items: center !important;
    }
}
</style>

<footer class="footer">
    <div class="footer-inner">

        <div class="footer-brand">
            <div class="footer-logo">PickEat</div>
            <div class="footer-text">
                날씨와 위치, 취향을 바탕으로 맛집을 추천하는 서비스<br>
                사용자 활동 데이터를 분석해 나에게 맞는 맛집을 제안합니다.
            </div>
        </div>

        <div class="footer-section">
            <div class="footer-title">서비스</div>
            <div class="footer-links">
                <a href="${contextPath}/">홈</a>
                <a href="${contextPath}/recommend">추천</a>
                <a href="${contextPath}/restaurants">맛집 리스트</a>
                <a href="${contextPath}/bookmark/list">즐겨찾기</a>
            </div>
        </div>

        <div class="footer-section">
            <div class="footer-title">프로젝트 기능</div>
            <div class="footer-tech">
                <span>Kakao Local API</span>
                <span>AI Pick 추천</span>
                <span>찜 · 리뷰 기반 분석</span>
            </div>
        </div>

    </div>

    <div class="footer-bottom">
        ⓒ 2026 PickEat Team · Weather Restaurant Recommendation Project
    </div>
</footer>