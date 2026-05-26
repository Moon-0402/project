<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat | 내 리뷰 내역</title>

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

.page-wrap {
    min-height: 100vh;
    display: flex;
}

/* 왼쪽 배너 */
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

/* 메인 */
.main {
    flex: 1;
    padding: 42px 54px;
}

.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 20px;
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
    line-height: 1.6;
}

.review-count {
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 20px;
    padding: 16px 22px;
    color: #b45309;
    font-weight: 900;
    box-shadow: 0 12px 30px rgba(90, 64, 43, 0.08);
    white-space: nowrap;
}

/* 카드 영역 */
.review-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 22px;
}

.review-card {
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 28px;
    overflow: hidden;
    box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
    transition: 0.25s ease;
    display: flex;
    flex-direction: column;
}

.review-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 25px 55px rgba(255, 145, 77, 0.18);
}

.review-image {
    width: 100%;
    height: 220px;
    object-fit: cover;
    background: #f3f4f6;
}

.no-image-box {
    width: 100%;
    height: 220px;
    background: #fffaf3;
    border-bottom: 1px solid #f4d7b7;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #a27755;
    font-weight: 900;
    font-size: 15px;
}

.review-body {
    padding: 22px;
    display: flex;
    flex-direction: column;
    flex: 1;
}

.restaurant-name {
    font-size: 22px;
    font-weight: 900;
    margin-bottom: 12px;
    color: #2f241d;
}

.star-area {
    color: #facc15;
    font-size: 22px;
    margin-bottom: 14px;
    letter-spacing: 2px;
    min-height: 28px;
}

.review-content {
    color: #6b7280;
    font-size: 14px;
    line-height: 1.8;
    margin-bottom: 20px;
    flex: 1;
    word-break: break-word;
}

.review-date {
    font-size: 13px;
    color: #9ca3af;
    font-weight: 700;
    margin-bottom: 18px;
}

.btn-group {
    display: flex;
    gap: 10px;
}

.btn {
    flex: 1;
    height: 46px;
    border-radius: 14px;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    font-weight: 900;
    transition: 0.2s;
}

.detail-btn {
    background: #fffaf3;
    color: #a27755;
    border: 1px solid #f4d7b7;
}

.detail-btn:hover {
    background: #ff914d;
    color: #fff;
    box-shadow: 0 8px 18px rgba(255, 145, 77, 0.28);
}

.edit-btn {
    background: #ff914d;
    color: #fff;
    border: none;
    box-shadow: 0 8px 20px rgba(255, 145, 77, 0.32);
}

.edit-btn:hover {
    background: #f97316;
    transform: translateY(-1px);
}

/* 빈 상태 */
.empty-box {
    background: rgba(255, 255, 255, 0.86);
    border: 1px solid rgba(255, 184, 107, 0.35);
    border-radius: 28px;
    padding: 80px 30px;
    text-align: center;
    box-shadow: 0 18px 45px rgba(90, 64, 43, 0.13);
}

.empty-icon {
    width: 78px;
    height: 78px;
    border-radius: 26px;
    background: linear-gradient(135deg, #ff914d, #ffb86b);
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 36px;
    margin: 0 auto 22px;
    box-shadow: 0 12px 24px rgba(255, 145, 77, 0.24);
}

.empty-box h2 {
    font-size: 28px;
    margin-bottom: 14px;
    color: #2f241d;
}

.empty-box p {
    color: #7a6a5d;
    margin-bottom: 28px;
    line-height: 1.8;
}

.empty-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 52px;
    padding: 0 28px;
    border-radius: 18px;
    background: #ff914d;
    color: white;
    text-decoration: none;
    font-weight: 900;
    box-shadow: 0 10px 25px rgba(255, 145, 77, 0.28);
    transition: 0.2s;
}

.empty-btn:hover {
    background: #f97316;
    transform: translateY(-1px);
}

/* 페이지네이션 */
.pagination-wrap {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin-top: 35px;
    flex-wrap: wrap;
}

.page-num,
.page-btn {
    min-width: 40px;
    height: 40px;
    padding: 0 14px;
    border-radius: 12px;
    border: 1px solid #f4d7b7;
    background: #fff;
    color: #b45309;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 900;
    transition: all 0.2s ease;
}

.page-num:hover,
.page-btn:hover {
    background: #fff3df;
    color: #ff6500;
    transform: translateY(-2px);
}

.page-num.active {
    background: #ff914d;
    color: #fff;
    border-color: #ff914d;
    box-shadow: 0 8px 18px rgba(255, 145, 77, 0.28);
}

@media (max-width: 1200px) {
    .review-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 900px) {
    .page-wrap {
        display: block;
    }

    .sidebar {
        width: 100%;
    }

    .main {
        padding: 28px 20px;
    }

    .top-bar {
        flex-direction: column;
    }

    .review-count {
        width: 100%;
    }

    .review-grid {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

<div class="page-wrap">

    <aside class="sidebar">
        <div class="logo-box">
            <a href="${contextPath}/" class="logo-link">
                <div class="logo">Pick<span>Eat</span></div>
            </a>
            <div class="logo-desc">날씨와 상황에 맞는 맛집 추천 서비스</div>
        </div>

        <div class="menu-title">My Menu</div>
        <ul class="menu-list">
            <li>
                <a href="${contextPath}/">메인 페이지</a>
            </li>
            <li>
                <a href="${contextPath}/member/mypage">내 정보 수정</a>
            </li>
            <li>
                <a href="${contextPath}/member/mypage/changePw">비밀번호 변경</a>
            </li>
            <li>
                <a href="${contextPath}/member/inquiry/write">문의하기</a>
            </li>
            <li>
                <a href="${contextPath}/member/inquiries">문의 내역</a>
            </li>
            <li>
                <a href="${contextPath}/member/mypage/reviews" class="active">내 리뷰 내역</a>
            </li>
            <li>
                <a href="${contextPath}/member/logout">로그아웃</a>
            </li>
        </ul>
    </aside>

    <main class="main">

        <div class="top-bar">
            <div class="page-title">
                <h1>내 리뷰 내역</h1>
                <p>내가 남긴 맛집 리뷰들을 한눈에 확인하고 수정할 수 있습니다.</p>
            </div>

            <div class="review-count">
                총 ${totalCount}개의 리뷰
            </div>
        </div>

        <c:choose>

            <c:when test="${empty reviewList}">

                <div class="empty-box">
                    <div class="empty-icon">🍽️</div>

                    <h2>아직 작성한 리뷰가 없어요</h2>

                    <p>
                        맛집에 방문하고 첫 리뷰를 남겨보세요.<br>
                        다른 사용자들에게 큰 도움이 됩니다.
                    </p>

                    <a class="empty-btn" href="${contextPath}/restaurants">
                        맛집 보러가기
                    </a>
                </div>

            </c:when>

            <c:otherwise>

                <div class="review-grid">

                    <c:forEach var="review" items="${reviewList}">

                        <div class="review-card">

                            <c:choose>
                                <c:when test="${not empty review.image}">
                                    <img class="review-image"
                                         src="${contextPath}${review.image}"
                                         alt="리뷰 이미지">
                                </c:when>

                                <c:otherwise>
                                    <div class="no-image-box">
                                        등록된 이미지 없음
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <div class="review-body">

                                <div class="restaurant-name">
                                    ${review.restaurantName}
                                </div>

                                <div class="star-area">
                                    <c:forEach begin="1" end="${review.rating}">
                                        ★
                                    </c:forEach>
                                </div>

                                <div class="review-content">
                                    ${review.content}
                                </div>

                                <div class="review-date">
                                    작성일 : ${review.createdAt}
                                </div>

                                <div class="btn-group">
                                    <a class="btn detail-btn"
                                       href="${contextPath}/review/list?restaurantId=${review.restaurantId}">
                                        리뷰 보기
                                    </a>

                                    <a class="btn edit-btn"
                                       href="${contextPath}/review/update?reviewId=${review.reviewId}">
                                        수정하기
                                    </a>
                                </div>

                            </div>

                        </div>

                    </c:forEach>

                </div>

                <c:if test="${totalPage > 1}">
                    <div class="pagination-wrap">

                        <c:if test="${startPage > 1}">
                            <a class="page-btn"
                               href="${contextPath}/member/mypage/reviews?page=${startPage - pageLimit}&size=${size}">
                                ‹ 이전
                            </a>
                        </c:if>

                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="page-num active">${i}</span>
                                </c:when>

                                <c:otherwise>
                                    <a class="page-num"
                                       href="${contextPath}/member/mypage/reviews?page=${i}&size=${size}">
                                        ${i}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:if test="${endPage < totalPage}">
                            <a class="page-btn"
                               href="${contextPath}/member/mypage/reviews?page=${endPage + 1}&size=${size}">
                                다음 ›
                            </a>
                        </c:if>

                    </div>
                </c:if>

            </c:otherwise>

        </c:choose>

    </main>

</div>

</body>
</html>