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
        }

        .content {
            padding: 50px 0;
            margin-top: 130px; 
        }

        .tab {
            width: 720px;
            margin: 0 auto;
            text-align: center;
            margin-bottom: 20px;
        }

        .tab > ul {
            display: flex;
            justify-content: space-between;
            height: 40px;
            padding: 0;
            margin: 0;
            list-style: none;
            border-bottom: 2px solid #4CAF50;
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
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .join_detail {
            margin-bottom: 20px;
        }

        .join_detail .title {
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

        #submit:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <section class="content">
        <div class="tab">
            <ul>
                <li class="tabMenu">이메일 입력</li>
                <li class="tabMenu on">회원정보 입력</li>
                <li class="tabMenu">가입 완료</li>
            </ul>
        </div>

        <form class="join" name="joinForm" action="${pageContext.request.contextPath}/MemberJoinForm" method="post" onsubmit="return validateForm()">
            <div class="join_detail">
                <label for="postCode" class="title">주소</label>
                <input type="text" name="member_postcode" id="postCode" placeholder="우편번호" required readonly>
                <button type="button" id="btnSearchAddress">주소검색</button>
                <input type="text" name="member_address1" id="address1" placeholder="기본주소" required readonly>
                <input type="text" name="member_address2" id="address2" placeholder="상세주소">
            </div>

            <div class="join_detail">
                <label for="member_id" class="title">아이디(이메일)</label>
                <input type="text" name="member_id" id="member_id" value="${param.member_id}" readonly>
            </div>

            <div class="join_detail">
                <label for="member_passwd" class="title">비밀번호</label>
                <input type="password" name="member_passwd" id="member_passwd" placeholder="영문, 숫자, 특수문자 중 2개 조합 8자 이상">
                <span id="checkPasswdResult" class="check"></span>
            </div>

            <div class="join_detail">
                <label for="member_passwd2" class="title">비밀번호 확인</label>
                <input type="password" name="member_passwd2" id="member_passwd2" placeholder="비밀번호를 다시 입력해주세요">
                <span id="checkPasswdResult2" class="check"></span>
            </div>

            <div class="join_detail">
                <label for="member_name" class="title">이름</label>
                <input type="text" name="member_name" id="member_name" placeholder="실명을 입력해주세요">
                <span id="checkNameResult" class="check"></span>
            </div> 

            <div class="join_detail">
                <label for="member_nickname" class="title">상점이름(닉네임)</label>
                <input type="text" name="member_nickname" id="member_nickname" placeholder="상점이름을 입력해주세요">
                <span id="checkNickNameResult" class="check"></span>
            </div>

            <div class="join_detail">
                <label for="member_birth" class="title">생년월일</label>
                <input type="text" name="member_birth" id="member_birth" placeholder="예) 1999-01-01">
                <span id="checkBirthResult" class="check"></span>
            </div>

            <div class="join_detail">
                <label for="member_phone" class="title">휴대폰번호</label>
                <input type="text" name="member_phone" id="member_phone" placeholder="- 없이 숫자만 입력해주세요." required>
                <span id="checkPhoneResult" class="check"></span>
            </div>

            <button id="submit" type="submit">가입하기</button>
        </form>
    </section>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#member_passwd2").on("blur", checkSamePw);
            $("#member_name").on("blur", checkName);
            $("#member_birth").on("blur", checkBirth);
            $("#member_phone").on("blur", checkPhoneNum);

            function checkSamePw() {
                let passwd = $("#member_passwd").val();
                let passwd2 = $("#member_passwd2").val();
                
                if (passwd === passwd2) {
                    $("#checkPasswdResult2").text("비밀번호가 일치합니다.").addClass("success").removeClass("error");
                } else {
                    $("#checkPasswdResult2").text("비밀번호가 일치하지 않습니다.").addClass("error").removeClass("success");
                    $("#member_passwd2").focus();
                }
            }

            function checkName() {
                let regex = /^[가-힣]{2,6}$/;
                let name = $("#member_name").val();
                
                if (!regex.test(name)) {
                    $("#checkNameResult").text("한글로 이름을 입력해주세요.").addClass("error").removeClass("success");
                    $("#member_name").focus();
                } else {
                    $("#checkNameResult").text("").removeClass("error success");
                }
            }

            function checkBirth() {
                let regex = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
                let birth = $("#member_birth").val();  
                
                if (!regex.test(birth)) {
                    $("#checkBirthResult").text("0000-00-00의 형식으로 입력해주세요.").addClass("error").removeClass("success");
                    $("#member_birth").focus();
                } else {
                    let birthDate = new Date(birth);
                    let maxDate = new Date('2010-01-01');

                    if (birthDate >= maxDate) {
                        $("#checkBirthResult").text("2010년 1월 1일 이전의 생년월일을 입력해주세요.").addClass("error").removeClass("success");
                        $("#member_birth").focus();
                    } else {
                        $("#checkBirthResult").text("").removeClass("error success");
                    }
                }
            }

            function checkPhoneNum() {
                let regex = /^[0-9]{10,11}$/;
                let phone = $("#member_phone").val();  
                
                if (!regex.test(phone)) {
                    $("#checkPhoneResult").text("숫자만 입력해주세요.").addClass("error").removeClass("success");
                    $("#member_phone").focus();
                } else {
                    $("#checkPhoneResult").text("").removeClass("error success");
                }
            }

            $("#btnSearchAddress").click(function() {
                new daum.Postcode({
                    oncomplete: function(data) { 
                        $("#postCode").val(data.zonecode);
                
                        let address = data.address;
                        if (data.buildingName !== '') {
                            address += " (" + data.buildingName + ")";
                        }
                
                        $("#address1").val(address);
                        $("#address2").focus();
                    }
                }).open();
            });

            function validateForm() {
                let isValid = true;

                let birth = $("#member_birth").val();
                let birthDate = new Date(birth);
                let maxDate = new Date('2010-01-01');

                if (birthDate >= maxDate) {
                    $("#checkBirthResult").text("2010년 1월 1일 이전의 생년월일을 입력해주세요.").addClass("error").removeClass("success");
                    isValid = false;
                }

                if ($("#checkPasswdResult").hasClass("error")) {
                    isValid = false;
                }

                if ($("#checkNameResult").hasClass("error")) {
                    isValid = false;
                }

                if ($("#checkPhoneResult").hasClass("error")) {
                    isValid = false;
                }

                return isValid;
            }
        });
    </script>
</body>
</html>
