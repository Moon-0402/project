<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PickEat 관리자 문의 상세</title>

    <style>
        body {
            margin: 0;
            font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
            background: #2b2118;
            color: #fff8ef;
        }

        .header {
            padding: 24px 60px;
            background: #201710;
        }

        .logo-link {
            text-decoration: none;
        }

        .logo {
            font-size: 30px;
            font-weight: 900;
            color: #ff9b38;
        }

        .container {
            max-width: 950px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .card {
            background: #3a2b20;
            border-radius: 28px;
            padding: 34px;
            box-shadow: 0 18px 45px rgba(0, 0, 0, 0.25);
            border: 1px solid #5c4028;
            margin-bottom: 24px;
        }

        h1, h2 {
            color: #ffd7a8;
        }

        .meta {
            color: #d0ad8a;
            margin-bottom: 20px;
        }

        .content {
            white-space: pre-line;
            line-height: 1.8;
            background: #4a3525;
            padding: 24px;
            border-radius: 20px;
        }

        .reply {
            white-space: pre-line;
            line-height: 1.8;
            background: #31412f;
            padding: 24px;
            border-radius: 20px;
            margin-top: 15px;
        }

        textarea {
            width: 100%;
            box-sizing: border-box;
            min-height: 180px;
            border-radius: 18px;
            border: 1px solid #7a573a;
            background: #2b2118;
            color: #fff8ef;
            padding: 16px;
            font-size: 15px;
            resize: vertical;
        }

        .btn-area {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 16px;
        }

        .btn {
            padding: 12px 18px;
            border-radius: 16px;
            border: none;
            font-weight: 900;
            cursor: pointer;
            text-decoration: none;
        }

        .submit {
            background: #ff9b38;
            color: #2b2118;
        }

        .back {
            background: #5c4028;
            color: #fff8ef;
        }

        .delete {
            background: #d9534f;
            color: white;
        }
    </style>
</head>
<body>

<div class="header">
    <a class="logo-link" href="${pageContext.request.contextPath}/">
        <div class="logo">PickEat Admin</div>
    </a>
</div>

<div class="container">

    <div class="card">
        <h1>${inquiry.title}</h1>

        <div class="meta">
            작성자: ${inquiry.name} (${inquiry.loginId}) |
            작성일: ${inquiry.createdAt} |
            상태: ${inquiry.status}
        </div>

        <div class="content">${inquiry.content}</div>
    </div>

    <div class="card">
        <h2>기존 답변</h2>

        <c:choose>
            <c:when test="${empty replyList}">
                <p>아직 등록된 답변이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="reply" items="${replyList}">
                    <div class="reply">
                        <strong>${reply.adminName}</strong>
                        <div>${reply.createdAt}</div>
                        <br>
                        ${reply.content}
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="card">
        <h2>답변 작성</h2>

        <form action="${pageContext.request.contextPath}/admin/inquiry/${inquiry.inquiryId}/reply" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

            <textarea name="content" placeholder="답변 내용을 입력하세요" required></textarea>

            <div class="btn-area">
                <a class="btn back" href="${pageContext.request.contextPath}/admin/inquiries">목록으로</a>
                <button class="btn submit" type="submit">답변 등록</button>
            </div>
        </form>
    </div>

    <form action="${pageContext.request.contextPath}/admin/inquiry/${inquiry.inquiryId}/delete" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <button class="btn delete" type="submit">문의 삭제</button>
    </form>

</div>

</body>
</html>