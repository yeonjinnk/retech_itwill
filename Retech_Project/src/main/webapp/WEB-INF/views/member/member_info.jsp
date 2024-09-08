<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보수정</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
            max-width: 120px; 
        }

        .tab {
            width: 80%; 
            max-width: 500px; 
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
            text-align: center;
        }

        .join {
            padding: 20px;
            width: 80%; 
            max-width: 500px; 
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
            width: calc(100% - 22px);
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
            text-align: center; 
        }

        .form-buttons input[type="button"], 
        .form-buttons input[type="submit"], 
        .form-buttons input[type="reset"] {
            width: auto; 
            margin: 5px;
        }

        .input_text {
            margin-bottom: 15px;
        }

        .input_text input[type="text"] {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .input_text input[type="button"] {
            margin: 5px 0;
            width: 100%;
        }

        .image-upload {
            margin: 20px 0;
        }

        .image-upload input[type="file"] {
            display: block;
            margin-bottom: 10px;
        }

        .image-upload img {
            display: block;
            max-width: 200px;
            margin-top: 10px;
        }

        #img_preview_img {
            display: none;
        }
    </style>
    <script type="text/javascript">
        let code2 = "";

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

        // 주소 검색 기능
        function searchAddress() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 선택한 주소 정보 가져오기
                    let addr = data.address;
                    let extraAddr = '';

                    // 기본 주소
                    if(data.addressType === 'R') { // 동/리 단위 주소
                        if(data.bname !== '') {
                            extraAddr += data.bname;
                        }
                        if(data.buildingName !== '') {
                            extraAddr += (extraAddr !== '' ? ', ' : '') + data.buildingName;
                        }
                        addr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                    }

                    // 우편번호와 주소 정보를 form에 삽입
                    document.getElementById('postCode').value = data.zonecode;
                    document.getElementById('address1').value = addr;
                    document.getElementById('address2').focus();
                }
            }).open();
        }

        $(document).ready(function() {
            // 폼 제출 전 비밀번호 체크
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

            // 주소 검색 버튼 클릭 이벤트
            $("#btnSearchAddress").click(function() {
                searchAddress();
            });

            // 휴대폰 번호 인증
            $("#phoneChk").click(function() {
                alert('인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.');
                var phone = $("#phoneNumber").val();
                $.ajax({
                    type: "POST", // post 형식으로 발송
                    url: "/shop/member/sendSMS1.do", // controller 위치
                    data: { member_phone: phone }, // 전송할 데이터값 (회원 전화번호로 변경)
                    cache: false,
                    success: function(data) {
                        if(data === "error") { // 실패시
                            alert("휴대폰 번호가 올바르지 않습니다.");
                        } else { // 성공시        
                            alert("휴대폰 전송이 됨.");
                            code2 = data; // 성공하면 데이터 저장
                        }
                    }
                });
            });

            // 휴대폰 인증번호 대조
            $("#phoneChk2").click(function() {
                if($("#phone2").val() === code2) { // 위에서 저장한 값과 비교
                    alert('인증성공');
                    // 인증 성공 시 전화번호 입력 필드에 값 설정
                    $("#phoneNumber").val($("#phoneNumber").val());
                } else {
                    alert('인증실패');
                }
            });

            // 프로필 사진 미리보기
            $("#member_profile").change(function() {
                let file = this.files[0];
                if (file) {
                    let reader = new FileReader();
                    reader.onload = function(e) {
                        $("#img_preview_img").attr("src", e.target.result).show();
                        $("#img_status").text("사진 미리보기");
                        $("#del_img").show();
                    };
                    reader.readAsDataURL(file);
                }
            });

            // 프로필 사진 삭제
            $("#del_img").click(function() {
                $("#img_preview_img").hide();
                $("#img_status").text("프로필사진");
                $("#del_img").hide();
                $("#member_profile").val("");
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

        <form class="join" name="Modify" action="MemberModify" method="post" enctype="multipart/form-data">
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
                <input type="password" name="member_passwd" id="member_passwd" placeholder="영문, 숫자, 특수문자 중 2개 조합 8자 이상" onblur="checkPasswd()" required>
                <span id="checkPasswdResult"></span>
                <span id="checkPasswdComplexResult"></span>
            </div>
            <div class="join_detail">
                <span>비밀번호 확인</span>
                <input type="password" name="member_pw2" id="member_pw2" placeholder="비밀번호 확인" onblur="checkSamePw()" required>
                <span id="checkPasswdResult2"></span>
            </div>
            <div class="join_detail">
                <span>이름</span>
                <input type="text" name="member_name" id="member_name" value="${member.member_name}" required>
                <span id="checkNameResult"></span>
            </div>
            <div class="join_detail">
                <span>생년월일</span>
                <input type="text" name="member_birth" id="member_birth" value="${member.member_birth}" required>
                <span id="checkBirthResult"></span>
            </div>
            <div class="join_detail">
                <span>휴대폰 번호</span>
                <input type="text" name="member_phone" id="phoneNumber" value="${member.member_phone}" required>
                <input type="button" id="phoneChk" value="인증번호 전송">
                <input type="text" id="phone2" placeholder="인증번호 입력">
                <input type="button" id="phoneChk2" value="인증번호 확인">
                <span id="checkPhoneResult"></span>
            </div>
            <div class="join_detail">
                <span>주소</span>
                <input type="text" id="postCode" name="member_postcode" readonly placeholder="우편번호">
                <input type="button" id="btnSearchAddress" value="주소 검색">
                <input type="text" id="address1" name="member_address1" readonly placeholder="주소">
                <input type="text" id="address2" name="member_address2" placeholder="상세주소">
            </div>
            <div class="join_detail">
			    <span>프로필 사진</span>
			    <input type="file" name="profile" id="member_profile">
			    <img id="img_preview_img" src="${pageContext.request.contextPath}/resources/images/${member.member_profile}" alt="미리보기" style="display:${member.member_profile != null ? 'block' : 'none'};">
			    <span id="img_status">${member.member_profile != null ? '사진 미리보기' : '프로필사진'}</span>
			    <input type="button" id="del_img" value="사진 삭제" style="${member.member_profile != null ? 'display: block;' : 'display: none;'}">
			</div>


            <div class="form-buttons">
                <input type="submit" value="정보수정">
                <input type="reset" value="초기화">
                <input type="button" value="돌아가기" onclick="history.back()">
                <input type="button" value="회원탈퇴" onclick="location.href='MemberWithdraw'">
            </div>
        </form>
    </section>
</body>
</html>
