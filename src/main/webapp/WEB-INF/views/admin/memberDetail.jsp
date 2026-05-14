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
</style>
</head>

<body>

<div class="admin-layout">

    <aside class="sidebar">
        <div class="logo-box">
            <a href="${pageContext.request.contextPath}/home" class="logo-link">
                <div class="logo">Pick<span>Eat</span></div>
            </a>
            <div class="logo-desc">날씨와 상황에 맞는 맛집 추천 서비스</div>
        </div>

        <div class="menu-title">Admin Menu</div>
        <ul class="menu-list">
            <li><a href="${pageContext.request.contextPath}/admin">대시보드</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/members" class="active">회원 관리</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/inquiries">문의 관리</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/restaurants">맛집 관리</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/reviewList">리뷰 관리</a></li>
        </ul>
    </aside>

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