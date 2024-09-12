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
            margin-top: 0px;
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
		    display: flex;
		    align-items: center; 
		    justify-content: center; 
		    height: 40px;
		    line-height: 40px; 
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
            background-color: #34495e;
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
        .join_detail input[type="password"],
        .join_detail input[type="file"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        .join_detail input[type="text"]:focus,
        .join_detail input[type="password"]:focus,
        .join_detail input[type="file"]:focus {
            border-color: #34495e;
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
            background-color: #34495e;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #submit:hover {
            background-color: #34495e;
        }

        .auth_code {
            display: flex;
            flex-direction: column;
        }

        .auth_code input[type="text"] {
            width: calc(100% - 110px);
            margin-right: 10px;
        }

        .auth_code button {
            padding: 12px;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .auth_code button:hover {
            background-color: #45a049;
        }
        footer {
		    margin-top: auto;
		    width: 100%;
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

        <form class="join" name="joinForm" id="joinform" action="${pageContext.request.contextPath}/MemberJoinForm" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
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
                <input type="password" name="member_passwd" id="member_passwd" placeholder="영문, 숫자, 특수문자 중 2개 조합 8자 이상" required>
                <span id="checkPasswdResult" class="check"></span>
            </div>

            <div class="join_detail">
                <label for="member_passwd2" class="title">비밀번호 확인</label>
                <input type="password" name="member_passwd2" id="member_passwd2" placeholder="비밀번호를 다시 입력해주세요" required>
                <span id="checkPasswdResult2" class="check"></span>
            </div>

            <div class="join_detail">
                <label for="member_name" class="title">이름</label>
                <input type="text" name="member_name" id="member_name" placeholder="실명을 입력해주세요" required>
                <span id="checkNameResult" class="check"></span>
            </div>

            <div class="join_detail">
                <label for="member_nickname" class="title">상점이름(닉네임)</label>
                <input type="text" name="member_nickname" id="member_nickname" placeholder="상점이름을 입력해주세요" required>
                <span id="checkNickNameResult" class="check"></span>
            </div>

            <div class="join_detail">
                <label for="member_birth" class="title">생년월일</label>
                <input type="text" name="member_birth" id="member_birth" placeholder="예) 1999-01-01" required>
                <span id="checkBirthResult" class="check"></span>
            </div>

            <div class="join_detail">
                <label for="member_phone" class="title">휴대폰번호</label>
                <input type="text" name="member_phone" id="member_phone" placeholder="- 없이 숫자만 입력해주세요." required>
                <span id="checkPhoneResult" class="check"></span>
                <button type="button" id="sendAuthCode">인증번호 받기</button>
                <span id="authCodeResult" class="check"></span>
            </div>

            <!-- 인증번호 입력란 추가 -->
            <div class="join_detail">
                <label for="auth_code" class="title">인증번호</label>
                <input type="text" name="auth_code" id="auth_code" placeholder="인증번호 입력">
                <button type="button" id="verifyAuthCode">확인</button>
                <span id="authCodeVerificationResult" class="check"></span>
            </div>

            <div class="join_detail">
			    <span>프로필 사진</span>
			    <input type="file" name="profile" id="member_profile">
			    <img id="img_preview_img" src="${pageContext.request.contextPath}/resources/images/${member.member_profile}" alt="미리보기" style="display:${member.member_profile != null ? 'block' : 'none'};">
			    <input type="button" id="del_img" value="사진 삭제" style="${member.member_profile != null ? 'display: block;' : 'display: none;'}">
			</div>

            <button id="submit" type="submit">가입하기</button>
        </form>
    </section>

    <script type="text/javascript">
    $(document).ready(function() {
    	
        // 비밀번호 유효성 검사
        $("#member_passwd, #member_passwd2").on("blur", validatePassword);

        // 전화번호 유효성 검사
        $("#member_phone").on("blur", validatePhoneNumber);

        // 주소 검색 버튼 클릭 시
        $("#btnSearchAddress").on("click", function() {
            new daum.Postcode({
                oncomplete: function(data) {
                    $("#postCode").val(data.zonecode);
                    $("#address1").val(data.roadAddress);
                    $("#address2").focus();
                }
            }).open();
        });

        // 인증번호 발송 버튼 클릭 시
        $("#sendAuthCode").on("click", function() {
        	
            var phone = $("#member_phone").val();
            console.log("phone : " + phone);
            if (validatePhoneNumber()) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/SendAuthCode",
                    type: "POST",
                    data: { member_phone: phone },
                    success: function(response) {
                        $("#authCodeResult").text("인증번호가 발송되었습니다.").addClass("success");
                    },
                    error: function() {
                        $("#authCodeResult").text("인증번호 발송에 실패했습니다.").addClass("error");
                    }
                });
            }
        });

        // 인증번호 확인 버튼 클릭 시
        $("#verifyAuthCode").on("click", function() {
            var authCode = $("#auth_code").val();
            if (validateAuthCode(authCode)) {
                $("#authCodeVerificationResult").text("인증번호가 일치합니다.").removeClass("error").addClass("success");
            } else {
                $("#authCodeVerificationResult").text("인증번호가 일치하지 않습니다.").addClass("error");
            }
        });
    });

    
    function validatePassword() {
        var passwd = $("#member_passwd").val();
        var passwd2 = $("#member_passwd2").val();
        
        // 비밀번호 유효성 검사
        if (passwd.length < 8) {
            $("#checkPasswdResult").text("비밀번호는 8자 이상이어야 합니다.").addClass("error");
        } else if (passwd !== passwd2) {
            $("#checkPasswdResult2").text("비밀번호가 일치하지 않습니다.").addClass("error");
        } else {
            $("#checkPasswdResult2").text("비밀번호가 일치합니다.").removeClass("error").addClass("success");
        }
    }

    function validatePhoneNumber() {
        var phone = $("#member_phone").val();
        var phonePattern = /^\d{10,11}$/; // 10 또는 11자리 숫자
        if (phonePattern.test(phone)) {
            $("#checkPhoneResult").text("전화번호가 유효합니다.").removeClass("error").addClass("success");
            return true; // 전화번호가 유효한 경우 true 반환
        } else {
            $("#checkPhoneResult").text("유효하지 않은 전화번호입니다.").addClass("error");
            return false; // 전화번호가 유효하지 않은 경우 false 반환
        }
    }

    function validateForm() {
        // 폼 전체 유효성 검사
        var authCode = $("#auth_code").val();
        if (!authCode) {
            $("#authCodeVerificationResult").text("인증번호를 입력해주세요.").addClass("error");
            return false;
        }
        
        // 비밀번호 유효성 검사
        validatePassword();

        // 전화번호 유효성 검사
        var phoneValid = validatePhoneNumber();

        // 모든 필드가 유효한 경우 폼을 제출
        return $(".error").length === 0 && phoneValid;
    }

    function validateAuthCode(authCode) {
        var authCodePattern = /^\d{6}$/; // 6자리 숫자
        return authCodePattern.test(authCode);
    }
    </script>
</body>
</html>
