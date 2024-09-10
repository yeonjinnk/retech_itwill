<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 가입</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
        body {
            font-family: 'Noto Sans', sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .content {
            flex: 1;
            padding: 50px 0;
            margin-top: 130px;
        }

        .tab {
            width: 720px;
            margin: 0 auto;
            text-align: center;
        }

        .tab > ul {
            display: flex;
            justify-content: space-between;
            height: 40px;
            line-height: 2.5;
            padding: 0;
            margin: 0;
            list-style: none;
            border-bottom: 2px solid #4CAF50;
            background-color: #eee;
        }

        .tab > ul > li {
            width: 33.33%;
            background-color: #eee;
            border-radius: 10px 10px 0 0;
        }

        .tab > ul > li a {
            display: block;
            width: 100%;
            padding: 15px;
            text-decoration: none;
            color: #555;
            transition: background-color 0.3s, color 0.3s;
        }

        .tab > ul > li.on {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
        }

        .tab > ul > li.on a {
            color: white;
        }

        .join {
            margin: 30px auto;
            max-width: 500px;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
        }

        .join_detail {
            margin-bottom: 20px;
        }

        .join_detail label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }

        .join_detail input[type="text"],
        .join_detail input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        .join_detail input[type="text"]:focus,
        .join_detail input[type="password"]:focus {
            border-color: #4CAF50;
        }

        .check {
            font-size: 13px;
            margin-top: 5px;
        }

        .check.success {
            color: #4CAF50;
        }

        .check.error {
            color: #e74c3c;
        }

        #submit {
            width: 150px;
            padding: 12px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #submit:hover {
            background-color: #45a049;
        }

        .address-btn {
            margin-top: 10px;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .address-btn:hover {
            background-color: #45a049;
        }

        footer {
		    margin-top: auto; 
		    width: 100%;
		}
    </style>
    <script type="text/javascript">
        function checkId() {
            let email = $("#member_id").val();
            let regex = /^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

            if (!regex.exec(email) || email === "") {
                alert("올바른 이메일이 아닙니다.");
                return false;
            }
        }
    </script>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <section class="content">
        <div class="tab">
            <ul>
                <li class="tabMenu on">이메일 입력</li>
                <li class="tabMenu">회원정보 입력</li>
                <li class="tabMenu">가입 완료</li>
            </ul>
        </div>

        <form class="join" action="MemberJoin" method="post">
            <div class="join_email">
                <div class="join_detail">
                    <label for="member_id">이메일 주소로 가입</label>
                    <input type="text" name="member_id" id="member_id" placeholder="이메일 주소를 입력해주세요." onblur="checkId()">
                </div>

            </div>

            <button id="submit" type="submit">가입하기</button>
        </form>
    </section>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>
