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
     body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
	}
	
	.logo {
	    margin: 20px 0;
	}
	
	.logo img {
	    max-width: 120px; /* 로고 이미지의 최대 너비를 줄였습니다 */
	}
	
	.tab {
	    width: 80%; /* 폭을 줄였습니다 */
	    max-width: 500px; /* 최대 너비를 줄였습니다 */
	    margin: 20px auto;
	    background-color: #fff;
	    border-radius: 8px;
	    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	}
	
	.tab h2 {
	    margin: 0;
	    padding: 15px;
	    font-size: 22px;
	    color: #fff;
	    background-color: #007bff;
	    border-radius: 8px 8px 0 0;
	    text-align: center; /* 중앙 정렬 */
	}
	
	.join {
	    padding: 20px;
	    width: 80%; /* 폭을 줄였습니다 */
	    max-width: 500px; /* 최대 너비를 줄였습니다 */
	    margin: 0 auto;
	    background-color: #fff;
	    border-radius: 8px;
	    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	}
	
	.join_detail {
	    margin-bottom: 15px;
	}
	
	.join_detail span {
	    display: block;
	    margin-bottom: 8px;
	    font-weight: bold;
	    color: #333;
	}
	
	.join_detail input[type="text"], 
	.join_detail input[type="password"] {
	    width: 100%;
	    padding: 10px;
	    border: 1px solid #ccc;
	    border-radius: 5px;
	    font-size: 16px;
	    box-sizing: border-box;
	}
	
	.join_detail input[type="button"], 
	.join_detail input[type="submit"], 
	.join_detail input[type="reset"] {
	    width: calc(100% - 22px);
	    padding: 10px;
	    border: none;
	    border-radius: 5px;
	    background-color: #007bff;
	    color: #fff;
	    cursor: pointer;
	    margin: 5px 0;
	    font-size: 16px;
	    text-align: center;
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
	
	.form-buttons {
	    text-align: center; /* 중앙 정렬 */
	}
	
	.form-buttons input[type="button"], 
	.form-buttons input[type="submit"], 
	.form-buttons input[type="reset"] {
	    width: auto; /* 버튼 너비를 콘텐츠에 맞게 조정 */
	    margin: 5px;
	}

        
    </style>
    <script type="text/javascript">
        // 비밀번호 강도 확인 함수
        function checkPasswd() {
            let passwd = $("#member_passwd").val();
            let msg = "";
            let color = "";
            let bgColor = "";

            // 비밀번호 길이 및 조합 확인
            let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
            if(lengthRegex.test(passwd)) {
                let engUpperRegex = /[A-Z]/;
                let engLowerRegex = /[a-z]/;
                let numRegex = /\d/;
                let specRegex = /[!@#$%]/;

                let count = 0;
                if(engUpperRegex.test(passwd)) count++;
                if(engLowerRegex.test(passwd)) count++;
                if(numRegex.test(passwd)) count++;
                if(specRegex.test(passwd)) count++;

                let complexityMsg = "";
                let complexityColor = "";

                switch(count) {
                    case 4:
                        complexityMsg = "안전";
                        complexityColor = "green";
                        break;
                    case 3:
                        complexityMsg = "보통";
                        complexityColor = "orange";
                        break;
                    case 2:
                        complexityMsg = "위험";
                        complexityColor = "red";
                        break;
                    default:
                        msg = "영문자, 숫자, 특수문자(!@#$%) 조합 8 ~ 16글자";
                        color = "red";
                        bgColor = "lightpink";
                        break;
                }

                $("#checkPasswdComplexResult").text(complexityMsg);
                $("#checkPasswdComplexResult").css("color", complexityColor);
                $("#checkPasswdResult").text(msg);
                $("#checkPasswdResult").css("color", color);
                $("#member_passwd").css("background", bgColor);

            } else {
                msg = "영문자, 숫자, 특수문자(!@#$%) 조합 8 ~ 16글자";
                color = "red";
                bgColor = "lightpink";

                $("#checkPasswdResult").text(msg);
                $("#checkPasswdResult").css("color", color);
                $("#member_passwd").css("background", bgColor);
            }
        }

        // 비밀번호 일치 여부 확인 함수
        function checkSamePw() {
            let passwd = $("#member_passwd").val();
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

        $(document).ready(function() {
            $("form").submit(function(event) {
                checkPasswd(); 
                checkSamePw();

                let checkPasswdResult = $("#checkPasswdResult").text() === "";
                let checkPasswd2Result = $("#checkPasswdResult2").text() === "비밀번호가 일치합니다.";

                if (!checkPasswdResult) {
                    alert("비밀번호를 적절히 입력해 주세요.");
                    $("#member_passwd").focus();
                    event.preventDefault();
                } else if (!checkPasswd2Result) {
                    alert("비밀번호 확인이 일치하지 않습니다.");
                    $("#member_pw2").focus();
                    event.preventDefault(); 
                }
            });
        });
    </script>
</head>
<body>
    <header class="header-section">
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <div class="logo">
        <a href="./" class="main_logo">
            <img src="${pageContext.request.contextPath}/resources/images/main_logo.png" alt="Main Logo">
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
                <input type="password" name="member_passwd" id="member_passwd" placeholder="영문, 숫자, 특수문자 중 2개 조합 8자 이상" onblur="checkPasswd()">
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
            </div>
            <div class="join_detail">
                <span>생년월일</span>
                <input type="text" name="member_birth" id="member_birth" value="${member.member_birth}" readonly required>
            </div>
            <div class="join_detail">
                <label for="postCode" class="title">주소</label>
                <input type="text" name="member_postcode" id="postCode" placeholder="우편번호" required readonly>
                <button type="button" id="btnSearchAddress">주소검색</button>
                <input type="text" name="member_address1" id="address1" placeholder="기본주소" required>
                <input type="text" name="member_address2" id="address2" placeholder="상세주소">
            </div>
            <div class="join_detail">
                <span>휴대폰번호</span>
                <input type="text" name="member_phonenumber" id="member_phonenumber" value="${member.member_phone}" required>
                <input type="button" value="인증번호 받기">
            </div>
            <div class="join_detail">
                <span>인증번호 입력 (제한시간 3분)</span>
                <input type="text" placeholder="인증번호 입력">
            </div>
            
            <div class="form-buttons">
                <input type="submit" value="정보수정">
                <input type="reset" value="초기화">
                <input type="button" value="돌아가기" onclick="history.back()">
                <input type="button" value="회원탈퇴" onclick="location.href='MemberWithdraw'">
            </div>
        </form>
    </section>

    <footer class="footer-section">
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>