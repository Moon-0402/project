<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>PickEat - 리뷰 작성</title>

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

.container {
	max-width: 900px;
	margin: 0 auto;
	padding: 50px 24px;
}

.back-link {
	display: inline-block;
	margin-bottom: 20px;
	color: #ff6500;
	font-weight: 900;
	text-decoration: none;
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

.review-badge {
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
	content: "⭐";
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

.input-group textarea {
	min-height: 180px;
	resize: vertical;
	line-height: 1.7;
}

.input-group input:focus,
.input-group textarea:focus,
.input-group select:focus {
	border-color: #ff914d;
	box-shadow: 0 0 0 4px rgba(255, 145, 77, 0.16);
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

.star-rating {
	display: flex;
	flex-direction: row-reverse;
	justify-content: flex-end;
	gap: 6px;
	padding: 10px 0;
}

.star-rating input {
	display: none;
}

.star-rating label {
	font-size: 34px;
	color: #e5e7eb;
	cursor: pointer;
	transition: 0.2s;
}

.star-rating label:hover,
.star-rating label:hover ~ label,
.star-rating input:checked ~ label {
	color: #facc15;
}

.preview-box {
	margin-top: 12px;
	display: none;
}

.preview-box img {
	max-width: 220px;
	border-radius: 16px;
	border: 1px solid #f4d7b7;
}

@media ( max-width : 900px) {
	.container {
		padding: 32px 20px;
	}

	.top-bar {
		display: block;
	}

	.review-badge {
		margin-top: 16px;
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


/* footer 하단 정렬용 레이아웃 보정 */
html,
body {
    min-height: 100%;
}

body {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

main,
.container,
.admin-layout,
.page-wrap,
.page-container,
.content,
.main-content {
    flex: 1 0 auto;
}

.admin-layout,
.page-wrap {
    min-height: 0;
}

.footer {
    margin-top: auto;
    flex-shrink: 0;
}
</style>
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<main class="container">

		<a class="back-link"
			href="${contextPath}/review/list?restaurantId=${review.restaurantId}">
			← 리뷰 목록으로 돌아가기
		</a>

		<div class="top-bar">
			<div class="page-title">
				<h1>
					<c:choose>
						<c:when test="${edit}">
							리뷰 수정
						</c:when>
						<c:otherwise>
							리뷰 작성
						</c:otherwise>
					</c:choose>
				</h1>
				<p>맛집에 대한 별점과 솔직한 후기를 남겨주세요.</p>
			</div>

			<div class="review-badge">REVIEW MODE</div>
		</div>

		<section class="summary-card">
			<div class="summary-title">리뷰 입력 센터</div>
			<p class="summary-text">
				별점은 1점부터 5점까지 선택할 수 있습니다.
				작성한 리뷰는 다른 사용자들이 맛집을 선택하는 데 도움이 됩니다.
			</p>
		</section>

		<section class="content-card">

			<!-- 수정1. multipart/form-data 형식에서는 CSRF hidden input을 넣어도 Spring Security가 토큰을 제대로 못 읽을 수 있다고 함 
						action에도 csrf 토큰 전송하기 (hidden 유지)
				 수정2. C드라이브에 upload 폴더 없다하여 생성함 -->
			<form action="${contextPath}/review/${edit ? 'update' : 'write'}?${_csrf.parameterName}=${_csrf.token}"
				  method="post"
				  enctype="multipart/form-data">

				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="hidden" name="reviewId" value="${review.reviewId}">
				<input type="hidden" name="restaurantId" value="${review.restaurantId}">
				<input type="hidden" name="memberId" value="${review.memberId}">

				<div class="form-grid">

					<div class="input-group">
						<label>맛집명</label>
						<input type="text"
							   value="${review.restaurantName}"
							   placeholder="맛집명"
							   readonly>
					</div>

					<div class="input-group">
						<label>별점</label>

						<div class="star-rating">
							<input type="radio" id="star5" name="rating" value="5"
								${review.rating == 5 ? 'checked' : ''} required>
							<label for="star5">★</label>

							<input type="radio" id="star4" name="rating" value="4"
								${review.rating == 4 ? 'checked' : ''}>
							<label for="star4">★</label>

							<input type="radio" id="star3" name="rating" value="3"
								${review.rating == 3 ? 'checked' : ''}>
							<label for="star3">★</label>

							<input type="radio" id="star2" name="rating" value="2"
								${review.rating == 2 ? 'checked' : ''}>
							<label for="star2">★</label>

							<input type="radio" id="star1" name="rating" value="1"
								${review.rating == 1 ? 'checked' : ''}>
							<label for="star1">★</label>
						</div>
					</div>

					<div class="input-group full">
						<label>리뷰 내용</label>
						<textarea name="content"
								  placeholder="음식 맛, 분위기, 서비스 등을 자유롭게 작성해주세요."
								  required>${review.content}</textarea>
					</div>

					<div class="input-group full">
						<label>리뷰 이미지</label>
						<input type="file"
							   id="imageFile"
							   name="imageFile"
							   accept="image/*">

						<c:if test="${not empty review.image}">
							<div class="help-text">
								현재 이미지: ${review.image}
							</div>
						</c:if>

						<div class="preview-box" id="previewBox">
							<img id="previewImage" src="#" alt="리뷰 이미지 미리보기">
						</div>
					</div>

				</div>

				<div class="help-text">
					※ 이미지는 JPG, PNG, GIF 등 이미지 파일만 선택해주세요.
				</div>

				<div class="btn-area">
					<a class="back-btn"
					   href="${contextPath}/review/list?restaurantId=${review.restaurantId}">
						목록으로
					</a>

					<button class="submit-btn" type="submit">
						<c:choose>
							<c:when test="${edit}">
								수정하기
							</c:when>
							<c:otherwise>
								등록하기
							</c:otherwise>
						</c:choose>
					</button>
				</div>

			</form>

		</section>

	</main>

	<script>
		const imageInput = document.getElementById("imageFile");
		const previewBox = document.getElementById("previewBox");
		const previewImage = document.getElementById("previewImage");

		imageInput.addEventListener("change", function() {
			const file = this.files[0];

			if (!file) {
				previewBox.style.display = "none";
				return;
			}

			const reader = new FileReader();

			reader.onload = function(e) {
				previewImage.src = e.target.result;
				previewBox.style.display = "block";
			};

			reader.readAsDataURL(file);
		});
	</script>


	<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>