<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보수정</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
        /* 기본 스타일 */
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }
        header, footer {
            background: #f4f4f4;
            padding: 10px 0;
            text-align: center;
        }
        .logo {
            text-align: center;
            margin: 20px 0;
        }
        .logo img {
            width: 100px;
        }
        .tab {
            width: 500px;
            margin: 0 auto;
        }
        .tab h2 {
            margin: 0;
            text-align: center;
            font-size: 24px;
        }
        .join {
            width: 500px;
            background-color: #eee;
            margin: 0 auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .join_detail {
            margin-bottom: 15px;
        }
        .join_detail span {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .join_detail input[type="text"], 
        .join_detail input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .join_detail input[type="button"], 
        .join_detail input[type="submit"], 
        .join_detail input[type="reset"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            background-color: #007BFF;
            color: #fff;
            cursor: pointer;
            margin: 5px 0;
        }
        .join_detail input[type="button"]:hover, 
        .join_detail input[type="submit"]:hover, 
        .join_detail input[type="reset"]:hover {
            background-color: #0056b3;
        }
        #checkPasswdResult, #checkPasswdResult2, #checkNameResult, #checkBirthResult, #checkPhoneResult {
            display: block;
            margin-top: 5px;
        }
        #checkPasswdResult {
            color: red;
        }
        #checkPasswdComplexResult {
            font-weight: bold;
        }
        #checkPasswdComplexResult.green {
            color: green;
        }
        #checkPasswdComplexResult.orange {
            color: orange;
        }
        #checkPasswdComplexResult.red {
            color: red;
        }
        .error {
            color: red;
        }
    </style>
    <script type="text/javascript">
        // 비밀번호 강도 확인 함수
        function checkPasswd() {
            let passwd = $("#member_pw").val();
            let msg = "";
            let color = "";
            let bgColor = "";

            let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;

            if(lengthRegex.exec(passwd)) {
                let engUpperRegex = /[A-Z]/;
                let engLowerRegex = /[a-z]/;
                let numRegex = /\d/;
                let specRegex = /[!@#$%]/;

                let count = 0;

                if(engUpperRegex.exec(passwd)) { count++; }
                if(engLowerRegex.exec(passwd)) { count++; }
                if(numRegex.exec(passwd)) { count++; }
                if(specRegex.exec(passwd)) { count++; }

                let complexityMsg = "";
                let complexityColor = "";

                if(count == 4) {
                    complexityMsg = "안전";
                    complexityColor = "green";
                } else if(count == 3) {
                    complexityMsg = "보통";
                    complexityColor = "orange";
                } else if(count == 2) {
                    complexityMsg = "위험";
                    complexityColor = "red";
                } else {
                    msg = "영문자, 숫자, 특수문자(!@#$%) 조합 8 ~ 16글자";
                    color = "red";
                    bgColor = "lightpink";
                }

                $("#checkPasswdComplexResult").text(complexityMsg);
                $("#checkPasswdComplexResult").css("color", complexityColor);
                $("#checkPasswdResult").text(msg);
                $("#checkPasswdResult").css("color", color);
                $("#member_pw").css("background", bgColor);

            } else {
                msg = "영문자, 숫자, 특수문자(!@#$%) 조합 8 ~ 16글자";
                color = "red";
                bgColor = "lightpink";

                $("#checkPasswdResult").text(msg);
                $("#checkPasswdResult").css("color", color);
                $("#member_pw").css("background", bgColor);
            }
        }

        // 비밀번호 일치 여부 확인 함수
        function checkSamePw() {
            let passwd = $("#member_pw").val();
            let passwd2 = $("#member_pw2").val();

            if(passwd === passwd2) {
                $("#checkPasswdResult2").text("비밀번호가 일치합니다.");
                $("#checkPasswdResult2").css("color", "blue");
            } else {
                $("#checkPasswdResult2").text("비밀번호가 일치하지 않습니다.");
                $("#checkPasswdResult2").css("color", "red");
                $("#member_pw2").focus();
            }
        }

        // 이름 유효성 검사 함수
        function checkName() {
            let regex = /^[가-힣]{2,6}$/;
            let name = $("#member_name").val();

            if(!regex.exec(name)) {
                $("#checkNameResult").text("한글로 이름을 입력해주세요.");
                $("#checkNameResult").css("color", "red");
                $("#member_name").focus();
            } else {
                $("#checkNameResult").text("");
            }
        }

        // 생년월일 유효성 검사 함수
        function checkBirth() {
            let regex = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
            let birth = $("#member_birth").val();

            if(!regex.exec(birth)) {
                $("#checkBirthResult").text("0000-00-00의 형식으로 입력해주세요.");
                $("#checkBirthResult").css("color", "red");
                $("#member_birth").focus();
            } else {
                $("#checkBirthResult").text("");
            }
        }

        // 전화번호 유효성 검사 함수
        function checkPhoneNum() {
            let regex = /^[0-9]{11}$/;
            let phone = $("#member_phonenumber").val();

            if(!regex.exec(phone)) {
                $("#checkPhoneResult").text("숫자만 입력해주세요.");
                $("#checkPhoneResult").css("color", "red");
                $("#member_phonenumber").focus();
            } else {
                $("#checkPhoneResult").text("");
            }
        }
    </script>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <div class="logo">
        <a href="./" class="main_logo">
            <img src="resources/images/main_logo.png" alt="Main Logo">
        </a>
    </div>

    <section>
        <div class="tab">
            <h2>회원정보수정</h2>
        </div>

        <form class="join" name="Modify" action="MemberModify" method="post">
            <div class="join_detail">
                <span>아이디(이메일)</span>
                <input type="text" name="member_id" value="${member.member_id}" readonly required>
            </div>
            <div class="join_detail">
                <span>기존 비밀번호</span>
                <input type="password" name="member_oldpw" id="member_oldpw" placeholder="영문, 숫자, 특수문자 중 2개 조합 8자 이상" onblur="checkPasswd()" required>
            </div>
            <div class="join_detail">
                <span>새 비밀번호</span>
                <input type="password" name="member_pw" id="member_pw" placeholder="영문, 숫자, 특수문자 중 2개 조합 8자 이상" onblur="checkPasswd()">
                <span id="checkPasswdResult"></span>
                <span id="checkPasswdComplexResult"></span>
            </div>
            <div class="join_detail">
                <span>새 비밀번호 확인</span>
                <input type="password" name="member_pw2" id="member_pw2" placeholder="위에 입력한 비밀번호를 다시 입력해주세요" required onblur="checkSamePw()">
                <span id="checkPasswdResult2"></span>
            </div>
            <div class="join_detail">
                <span>이름</span>
                <input type="text" name="member_name" id="member_name" value="${member.member_name}" readonly required>
                <span id="checkNameResult"></span>
            </div>
            <div class="join_detail">
                <span>생년월일</span>
                <input type="text" name="member_birth" id="member_birth" value="${member.member_birth}" readonly required>
                <span id="checkBirthResult"></span>
            </div>
            <div class="join_detail">
                <span>휴대폰번호</span>
                <input type="text" name="member_phonenumber" id="member_phonenumber" value="${member.member_phone}" required onblur="checkPhoneNum()">
                <span id="checkPhoneResult"></span>
                <input type="button" value="인증번호 받기">
            </div>
            <div class="join_detail">
                <span>인증번호 입력 (제한시간 3분)</span>
                <input type="text" placeholder="인증번호 입력">
            </div>
            
            <div class="form-buttons">
                <input type="submit" value="정보수정" class="form-button">
                <input type="reset" value="초기화" class="form-button">
                <input type="button" value="돌아가기" class="form-button" onclick="history.back()">
                <input type="button" value="회원탈퇴" class="form-button" onclick="location.href='MemberWithdraw'">
            </div>
        </form>
    </section>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>
