<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    color: white;
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
    color: white;
}

@media (max-width: 980px) {
    .footer-inner {
        flex-direction: column;
        align-items: flex-start;
    }
}
</style>
</head>
<body>
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
				<a href="${contextPath}/member/login">로그인</a>
			</div>
		</div>
	</footer>
</body>
</html>