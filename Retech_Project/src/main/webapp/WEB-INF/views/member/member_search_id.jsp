<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <style>
        body {
            font-family: 'Noto Sans', sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 0;
        }
        
        /* 로고 영역 */
        .logo2 {
            width: 120px;
            margin: 30px auto;
            text-align: center;
        }

        .logo2 img {
            width: 100%;
            border-radius: 50%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .tab {
            width: 100%;
            max-width: 400px;
            margin: 30px auto;
            text-align: center;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

	     .tab ul {
		    display: flex;
		    justify-content: center;
		    padding: 0;
		    margin: 0;
		    width: 100%;
		}
		
		.tab ul li {
		    flex: 1;
		    list-style: none;
		    background-color: #eee;
		    border-radius: 10px 10px 0 0;
		    margin: 0;
		    text-align: center;
		}
		
		.tab ul li a {
		    display: block;
		    width: 100%;
		    padding: 15px;
		    text-decoration: none;
		    color: #555;
		    transition: background-color 0.3s, color 0.3s;
		    text-align: center;
		    box-sizing: border-box;
		}


        .tab ul li.on {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
        }

        .tab ul li.on a {
            color: white;
        }

        article {
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        article h4 {
            margin-bottom: 20px;
            font-size: 18px;
            color: #333;
            text-align: center;
        }

        article .info {
            width: 100%;
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
        }

        article .info span {
            width: 100%;
            text-align: left;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }

        article .info input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        article .info input:focus {
            border-color: #4CAF50;
        }

        .submitBtn {
            width: 100%;
            padding: 15px;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .submitBtn:hover {
            background-color: #45a049;
        }

        .alert {
            display: block;
            width: 100%;
            text-align: center;
            color: #999;
            font-size: 14px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <div class="logo2">
        <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="로고">
    </div>

    <div class="tab">
        <ul>
            <li class="tabMenu on"><a href="MemberSearchId">아이디 찾기</a></li>
        </ul>
    </div>

    <article>
        <div align="center">
            <h4>등록한 정보로 아이디 찾기</h4>
            <form class="search" name="searchIdForm" action="SearchIdPro" method="post">
                <div class="info">
                    <span>이름</span>
                    <input type="text" name="member_name" placeholder="이름을 입력해주세요" required> 
                </div>

                <div class="info">
                    <span>생년월일</span>
                    <input type="text" name="member_birth" placeholder="예) 1999-01-01" required> 
                </div>

                <div class="info">
                    <span>휴대폰번호</span>
                    <input type="text" name="member_phone" placeholder=" - 없이 숫자만 입력해주세요." required> 
                </div>

                <input type="submit" value="아이디찾기" class="submitBtn">
            </form>

            <span class="alert">
                이메일, 비밀번호, 휴대폰 번호 등 입력 정보를<br>전부 다 모르실 경우
                고객센터 이메일<br> 또는 ARS(1000-1000)로 문의주시기 바랍니다.
            </span>
        </div>
    </article>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>
