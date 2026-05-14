<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

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

.hero-card {
    display: grid;
    grid-template-columns: 1.4fr 0.8fr;
    gap: 24px;
    margin-bottom: 28px;
}

.welcome-card,
.weather-card,
.stat-card,
.panel {
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 28px;
    box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
}

.welcome-card,
.weather-card {
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

.weather-icon {
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

.weather-card h2 {
    font-size: 22px;
    color: #2f241d;
    margin-bottom: 10px;
}

.weather-card p {
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

    .admin-badge {
        margin-top: 16px;
    }

    .dashboard-grid {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

<div class="admin-layout">

    <aside class="sidebar">
        <div class="logo-box">
            <a href="${pageContext.request.contextPath}/" class="logo-link">
                <div class="logo">Pick<span>Eat</span></div>
            </a>
            <div class="logo-desc">날씨와 상황에 맞는 맛집 추천 서비스</div>
        </div>

        <div class="menu-title">Admin Menu</div>
        <ul class="menu-list">
            <li><a href="${pageContext.request.contextPath}/admin" class="active">대시보드</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/members">회원 관리</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/inquiries">문의 관리</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/restaurants">맛집 관리</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/reviewList">리뷰 관리</a></li>
        </ul>
    </aside>

    <main class="main">

        <div class="top-bar">
            <div class="page-title">
                <h1>PickEat 관리자 대시보드</h1>
                <p>회원, 맛집, 리뷰, 날씨 기반 추천 흐름을 한눈에 관리합니다.</p>
            </div>

            <div class="admin-badge">ADMIN MODE</div>
        </div>

        <section class="hero-card">
            <div class="welcome-card">
                <div class="welcome-title">오늘도 맛있는 운영을 시작합니다</div>
                <p class="welcome-text">
                    PickEat은 날씨와 사용자 상황을 바탕으로 맛집을 추천하는 서비스입니다.
                    관리자 페이지에서는 회원 정보와 서비스 데이터를 관리하고,
                    추천 서비스가 안정적으로 작동하도록 운영 흐름을 확인할 수 있습니다.
                </p>

                <div class="quick-actions">
                    <a href="${pageContext.request.contextPath}/admin/members" class="btn btn-primary">회원 관리 바로가기</a>
                    <a href="${pageContext.request.contextPath}/admin/restaurantList" class="btn btn-soft">맛집 관리</a>
                    <a href="${pageContext.request.contextPath}/admin/reviewList" class="btn btn-soft">리뷰 관리</a>
                </div>
            </div>

            <div class="weather-card">
                <div>
                    <div class="weather-icon">🌤</div>
                    <h2>날씨 기반 추천 관리</h2>
                    <p>
                        날씨 API와 위치 정보를 활용해 사용자에게 어울리는 맛집을 추천하는 영역입니다.
                        추후 날씨 조건별 추천 기준을 이곳에서 관리할 수 있습니다.
                    </p>
                </div>

                <div style="margin-top: 22px;">
                    <a href="${pageContext.request.contextPath}/admin/weather" class="btn btn-primary">추천 관리 이동</a>
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
                <div class="stat-icon">💬</div>
                <div class="stat-label">리뷰 관리</div>
                <div class="stat-value">REVIEW</div>
                <div class="stat-desc">사용자 리뷰와 서비스 피드백을 확인합니다.</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">📍</div>
                <div class="stat-label">위치 / 날씨</div>
                <div class="stat-value">API</div>
                <div class="stat-desc">외부 API 기반 추천 흐름을 관리합니다.</div>
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
                            <div class="task-title">회원 정보 수정</div>
                            <div class="task-desc">이름, 이메일, 전화번호 같은 기본 정보를 수정합니다. 권한은 변경하지 않습니다.</div>
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
                    <a href="${pageContext.request.contextPath}/admin/members" class="feature-item">
                        <span class="feature-title">회원 관리</span>
                        <span class="feature-desc">회원 목록, 상세 정보, 수정 페이지로 이동합니다.</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/restaurantList" class="feature-item">
                        <span class="feature-title">맛집 관리</span>
                        <span class="feature-desc">추천에 사용될 맛집 데이터를 관리합니다.</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/reviewList" class="feature-item">
                        <span class="feature-title">리뷰 관리</span>
                        <span class="feature-desc">회원들이 작성한 리뷰 데이터를 확인합니다.</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/weather" class="feature-item">
                        <span class="feature-title">날씨 추천 관리</span>
                        <span class="feature-desc">날씨와 상황 기반 추천 로직을 관리합니다.</span>
                    </a>
                </div>
            </div>

        </section>

    </main>
</div>

</body>
</html>