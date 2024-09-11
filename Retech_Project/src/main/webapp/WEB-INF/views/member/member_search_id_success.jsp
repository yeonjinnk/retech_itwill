<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 확인</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
        body {
            font-family: 'Noto Sans', sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 0;
        }

        article {
            width: 100%;
            max-width: 400px;
            margin: 60px auto; 
            padding: 30px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        article span {
            font-size: 18px;
            color: #333;
            display: block;
            margin-bottom: 20px;
        }

        article b {
            color: #d35400;
            font-weight: bold;
        }

        article input[type="button"] {
            width: 100px;
            margin: 10px 10px;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #34495e;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        article input[type="button"]:hover {
            background-color: #34495e; 
        }

        footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            text-align: center;
            color: #999;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <article>
        <div>
            <span>회원님의 아이디는 <b>${member_id}</b> 입니다.</span>
        </div>

        <div>
            <input type="button" value="홈으로" onclick="location.href='./'">
            <input type="button" value="로그인" onclick="location.href='MemberLogin'">
        </div>
    </article>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>
    