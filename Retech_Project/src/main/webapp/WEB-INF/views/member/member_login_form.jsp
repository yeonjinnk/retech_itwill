<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>  
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_1.3.2.js"></script>
   
    <%-- RSA 양방향 암호화 자바스크립트 라이브러리 추가 --%>
    <script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/rsa.js"></script>
    <script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/jsbn.js"></script>
    <script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/prng4.js"></script>
    <script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/rng.js"></script>

    <script type="text/javascript">
        $(function() {
            // form 태그 submit 이벤트 핸들링
            $("form").submit(function() {
                // ================ RSA 알고리즘을 활용한 비대칭키 방식 암호화 ================
                let rsa = new RSAKey();
                rsa.setPublic("${RSAModulus}", "${RSAExponent}");
                $("#hiddenId").val(rsa.encrypt($("#member_id").val())); // 아이디 암호화
                $("#hiddenPasswd").val(rsa.encrypt($("#member_passwd").val())); // 패스워드 암호화
            });

            // 카카오 로그인 초기화
            Kakao.init('2148dfcbfa10f00502540073a8c41792'); // 자바스크립트 키

            Kakao.Auth.createLoginButton({
                container: '#kakao-login-button',
                success: function(authObj) {
                    // 카카오 로그인 성공 시, authorization code를 서버로 전달
                    if (authObj.code) {
                        window.location.href = '/retech_proj/kakao-callback?code=' + authObj.code;
                    } else {
                        console.error('Authorization code is missing.');
                    }
                },
                fail: function(err) {
                    console.error('Kakao login failed:', err);
                }
            });
        });
    </script>
    
    <style>
        body {
            font-family: 'Noto Sans', sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 0;
        }
        
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
        
        #memberLoginArea {
            margin-top: 80px;
            padding: 40px 30px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            max-width: 400px;
            margin: 80px auto;
            box-sizing: border-box;
        }
        
        .tab {
            width: 100%;
            margin-bottom: 30px;
            text-align: center;
        }

        .tab ul {
            display: flex;
            justify-content: center;
            padding: 0;
        }

        .tab ul li {
            width: 50%;
            list-style: none;
            background-color: #eee;
            border-radius: 10px 10px 0 0;
            margin: 0;
        }

        .tab ul li a {
            display: block;
            width: 100%;
            padding: 15px;
            text-decoration: none;
            color: #555;
            transition: background-color 0.3s, color 0.3s;
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
            padding: 0;
            box-sizing: border-box;
        }

        article form {
            margin: 0 auto;
        }

        article form .info {
            width: 100%;
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
        }

        article form .info span {
            width: 100%;
            text-align: left;
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }

        article form .info input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        article form .info input:focus {
            border-color: #4CAF50;
        }

        article form .search {
            text-align: left;
            margin-bottom: 30px;
        }

        article form .search label {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: #555;
        }

        article form .search input[type="checkbox"] {
            margin-right: 5px;
        }

        article form ul {
            padding: 0;
            margin: 0;
            text-align: center;
            margin-top: 20px;
        }

        article form ul li {
            display: inline-block;
            margin: 0 10px;
        }

        article form ul li a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        article form ul li a:hover {
            color: #333;
        }

        #login_btn {
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

        #login_btn:hover {
            background-color: #45a049;
        }

        .social-login {
            text-align: center;
            margin-top: 20px;
        }

        .social-login a {
            display: inline-block;
            margin: 10px;
        }

        .social-login img {
            width: 150px;
            height: auto;
        }

        #kakao-login-button {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>
    
    <div id="memberLoginArea">
        <div class="logo2">
            <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="로고">
        </div>
        
        <div class="tab">
            <ul>
                <li class="tabMenu on"><a href="#">회원 로그인</a></li>
            </ul>
        </div>
        
        <article>
            <div align="center" class="login registed on">
                <span>아이디와 비밀번호를 입력하신 후, 로그인을 눌러주세요</span>
                <form action="MemberLogin" method="post" name="login" onsubmit="return validateForm();">
                    <div class="info">
                        <span>아이디(이메일)</span>
                        <input type="text" id="member_id" value="${cookie.rememberId.value}" placeholder="이메일을 입력해주세요" required> 
                    </div>
                    
                    <div class="info">
                        <span>비밀번호</span>
                        <input type="password" id="member_passwd" placeholder="영문, 숫자 포함 8자 이상" required>
                    </div>

                    <input type="hidden" name="member_id" id="hiddenId">
                    <input type="hidden" name="member_passwd" id="hiddenPasswd">    
                    
                    <div class="search">
                        <label>
                            <input type="checkbox" name="rememberId" <c:if test="${not empty cookie.rememberId}">checked</c:if>>아이디 기억
                        </label>
                    </div>
                    
                    <input type="submit" value="로그인" id="login_btn">
                    
                    <ul>
                        <li><a href="MemberSearchId">아이디 찾기</a></li>
                        <li><a href="Passwd_find">비밀번호 찾기</a></li>
                        <li><a href="MemberJoin">회원가입</a></li>
                    </ul>
                </form>

                <!-- 카카오 로그인 버튼 추가 -->
                <div id="kakao-login-button" class="social-login">
                    <p>카카오로 로그인</p>
                </div>
            </div>        
        </article>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>
