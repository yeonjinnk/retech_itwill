<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<link href="${pageContext.request.servletContext.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.servletContext.contextPath}/resources/css/pw_find.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<script type="text/javascript">
    let checkPasswdResult = false;
    let checkPasswd2Result = false;

    // 비밀번호 복잡성 검증 함수
    function checkPasswd() {
        let member_pw = $("#member_pw").val();

        let msg = "";
        let color = "";
        let bgColor = "";

        let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;

        if (lengthRegex.test(member_pw)) {
            let engUpperRegex = /[A-Z]/;
            let engLowerRegex = /[a-z]/;
            let numRegex = /\d/;
            let specRegex = /[!@#$%]/;

            let count = 0;

            if (engUpperRegex.test(member_pw)) {
                count++;
            }
            if (engLowerRegex.test(member_pw)) {
                count++;
            }
            if (numRegex.test(member_pw)) {
                count++;
            }
            if (specRegex.test(member_pw)) {
                count++;
            }

            let complexityMsg = "";
            let complexityColor = "";

            if (count === 4) {
                complexityMsg = "안전";
                complexityColor = "green";
            } else if (count === 3) {
                complexityMsg = "보통";
                complexityColor = "orange";
            } else if (count === 2) {
                complexityMsg = "위험";
                complexityColor = "red";
            } else if (count <= 1) {
                msg = "영문자, 숫자, 특수문자(!@#$%) 조합 8 ~ 16글자";
                color = "red";
                bgColor = "lightpink";
                checkPasswdResult = false;
            }

            if (count >= 2) {
                $("#checkPasswdComplexResult").text(complexityMsg);
                $("#checkPasswdComplexResult").css("color", complexityColor);
                checkPasswdResult = true;
            }

        } else {
            msg = "영문자, 숫자, 특수문자(!@#$%) 조합 8 ~ 16글자";
            color = "red";
            bgColor = "lightpink";
            checkPasswdResult = false;
        }

        $("#checkPasswdResult").text(msg);
        $("#checkPasswdResult").css("color", color);
        $("#member_pw").css("background", bgColor);
    }

    // 비밀번호 확인 함수
    function checkSamePasswd() {
        let member_pw = $("#member_pw").val();
        let member_pw2 = $("#member_pw2").val();

        if (member_pw === member_pw2) {
            $("#checkPasswd2Result").text("비밀번호 일치");
            $("#checkPasswd2Result").css("color", "blue");
            checkPasswd2Result = true;
        } else {
            $("#checkPasswd2Result").text("비밀번호 불일치");
            $("#checkPasswd2Result").css("color", "red");
            checkPasswd2Result = false;
        }
    }

    $(document).ready(function() {
        $("form").submit(function(event) {
            checkPasswd(); 

            if (!checkPasswdResult) {
                alert("패스워드를 부적합하게 입력했습니다.");
                $("#member_pw").focus();
                event.preventDefault();
            } else {
                checkSamePasswd();

                if (!checkPasswd2Result) {
                    alert("패스워드 확인 항목이 일치하지 않습니다!");
                    $("#member_pw2").focus();
                    event.preventDefault(); 
                }
            }
        });
    });

</script>

<style type="text/css">
    #findPw_wrap3 {
        border: 1px solid #ccc;
        border-radius: 12px;
        padding: 10px 30px;
    }

    #next {
        padding: 10px 30px;
        border: none;
        border-radius: 12px;
        background-color: #ccc;
    }

    #next:hover {
        background-color: #59b9a9;
    }

    #sec02 {
        background-color: #f1f3f5;
        border-radius: 12px;
        margin: 10px 60px;
        padding: 10px;
    }
</style>

</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
</header>
<main>
<section>
    <div id="findPw_wrap3">
        <form action="PwResetFinal" method="post">
            <input type="hidden" name="member_phonenumber" value="${dbMember.member_phonenumber}" id="member_phonenumber" size="10">
            <input type="hidden" name="member_id" value="${dbMember.member_id}" id="member_id" size="10">
            <section id="sec01">
                <table>
                    <tr>
                        <td id="td01"><h2>비밀번호 재설정</h2></td>
                    </tr>
                </table>
            </section>
            <section id="sec02">
                <div style="display: flex; justify-content: center;">
                    <table>  
                        <tr>
                            <td id="td03">새 비밀번호</td>
                            <td>
                                <input type="password" name="member_pw" id="member_pw" size="15" maxlength="16" onblur="checkPasswd()" required>
                                <span id="checkPasswdComplexResult"></span>
                                <div id="checkPasswdResult"></div>
                            </td>
                        </tr>
                        <tr>
                            <td id="td04">새 비밀번호 확인</td>
                            <td>
                                <input type="password" name="member_pw2" id="member_pw2" size="15" maxlength="16" onblur="checkSamePasswd()" required>
                                <div id="checkPasswd2Result"></div>
                            </td>
                        </tr>
                        <tr>
                            <td id="td04" colspan="2" align="center">
                                <br><input type="submit" value="다음" id="next">
                            </td>
                        </tr>
                    </table>
                </div>
            </section>
        </form>
    </div>
</section>
</main>
<footer>
    <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
</footer>
</body>
</html>
