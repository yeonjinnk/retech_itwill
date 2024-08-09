<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 가입</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
        .content {
            padding: 50px 0;
        }

        .content .join {
            width: 350px;
            margin: 0 auto;
        }

        .content .join_detail {
            padding: 10px 0 ;
        }

        .content .join_detail .title {
            display: block;
            width: 150px;
            margin-bottom: 7px;
        }
        .content .join_detail .detail2 {
            width: 100%;
        }

        .content .join_detail .check {
            width: 150px;
            font-size: 13px; 
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
        }
        .tab > ul > li {
            width: 50%;
            background-color: #eee;
        }
        .tab > ul > li a {
            display: block;
            width: 100%;
        }

        .tab > ul > li.on {
            background-color: #ccc;
            color: rgb(211, 84, 0);
            font-weight: bold;
        }

        .social_btn {
            width: 150px;
        }

        #submit {
            width: 100%;
        }

        input, select {
            height: 30px;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <section class="content inner">
        <div class="tab">
            <ul>
                <li class="tabMenu">이메일 입력</li>
                <li class="tabMenu on">회원정보 입력</li>
                <li class="tabMenu">가입 완료</li>
            </ul>
        </div>

        <form class="join" name="joinForm" action="MemberJoinForm" method="post">
            <div class="join_detail">
                <span class="title">주소</span>
                <input type="text" name="post_code" id="postCode" size="6" required readonly>
                <input type="button" value="주소검색" id="btnSearchAddress">
                <br>
                <input type="text" name="address1" id="address1" size="30" placeholder="기본주소" required>
                <br>
                <input type="text" name="address2" id="address2" size="30" placeholder="상세주소">
            </div>

            <div class="join_detail">
                <span class="title">아이디(이메일)</span>
                <input type="text" class="detail2" name="member_id" value="${param.member_id}" readonly>
            </div>
            <div class="join_detail">
                <span class="title">비밀번호</span>
                <input type="password" class="detail2" name="member_passwd" id="member_passwd" placeholder="영문, 숫자, 특수문자 중 2개 조합 8자 이상" required onblur="emptyPw()"> <!-- / ^[A-Za-z0-9!@#$%^&*_-+=]{8,}$/ -->
            </div>
            <div class="join_detail">
                <span class="title">비밀번호 확인</span>
                <input type="password" class="detail2" name="member_passwd2" id="member_passwd2" placeholder="위에 입력한 비밀번호를 다시 입력해주세요" required onblur="checkSamePw()"> <br>
                <span id="checkPasswdResult" class="check"></span>
            </div>
            <div class="join_detail">
                <span class="title">이름</span>
                <input type="text" class="detail2" name="member_name" id="member_name" placeholder="실명을 입력해주세요" required onblur="checkName()"><br>
                <span id="checkNameResult" class="check"></span>
            </div>
            <div class="join_detail">
                <span class="title">상점이름(닉네임)</span>
                <input type="text" class="detail2" name="member_nickname" id="member_nickname" placeholder="상점이름을 입력해주세요" required onblur="checkNickName()"><br>
                <span id="checkNickNameResult" class="check"></span>
            </div>
            <div class="join_detail">
                <span class="title">생년월일</span>
                <input type="text" class="detail2" name="member_birth" id="member_birth" placeholder="예) 1999-01-01" required onblur="checkBirth()"><br>
                <span id="checkBirthResult" class="check"></span>
            </div>
            <div class="join_detail">
                <span class="title">휴대폰번호</span>
                <input type="text" class="detail2" name="member_phone" id="member_phone" placeholder="- 없이 숫자만 입력해주세요." required onblur="checkPhoneNum()"> <br>
                <span id="checkPhoneResult" class="check"></span>
            </div>

            <input id="submit" class="submit" type="submit" value="가입하기">
        </form>
    </section>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>

    <script type="text/javascript">
        $(document).ready(function() {
            function checkSamePw() {
                let passwd = $("#member_pw").val();
                let passwd2 = $("#member_pw2").val();
                
                if (passwd === passwd2) {
                    $("#checkPasswdResult").text("비밀번호가 일치합니다.");
                    $("#checkPasswdResult").css("color", "blue");
                } else {
                    $("#checkPasswdResult").text("비밀번호가 일치하지 않습니다.");
                    $("#checkPasswdResult").css("color", "red");
                    $("#member_pw2").focus();
                }
            }

            function checkName() {
                let regex = /^[가-힣]{2,6}$/;
                let name = $("#member_name").val();
                
                if (!regex.exec(name)) {
                    $("#checkNameResult").text("한글로 이름을 입력해주세요.");
                    $("#checkNameResult").css("color", "red");
                    $("#member_name").focus();
                } else {
                    $("#checkNameResult").text("");
                }
            }

            function checkBirth() {
                let regex = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
                let birth = $("#member_birth").val();  
                
                if (!regex.exec(birth)) {
                    $("#checkBirthResult").text("0000-00-00의 형식으로 입력해주세요.");
                    $("#checkBirthResult").css("color", "red");
                    $("#member_birth").focus();
                } else {
                    $("#checkBirthResult").text("");
                }
            }

            function checkPhoneNum() {
                let regex = /^[0-9]{11}$/;
                let phone = $("#member_phonenumber").val();  
                
                if (!regex.exec(phone)) {
                    $("#checkPhoneResult").text("숫자만 입력해주세요.");
                    $("#checkPhoneResult").css("color", "red");
                    $("#member_phonenumber").focus();
                } else {
                    $("#checkPhoneResult").text("");
                }
            }

            // 주소 검색
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
        });
    </script>
</body>
</html>
