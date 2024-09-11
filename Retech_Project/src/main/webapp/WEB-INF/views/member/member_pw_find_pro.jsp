<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<link href="${pageContext.request.servletContext.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.servletContext.contextPath}/resources/css/pw_find_pro.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #findPw_wrap2 {
        border: 1px solid #ccc;
        border-radius: 12px;
        padding: 10px 20px; 
        background-color: #ffffff;
        max-width: 500px; 
        margin: 20px auto; 
    }

    #next, #sendCode {
        padding: 8px 20px;
        border: none;
        border-radius: 8px; 
        background-color: #4CAF50; 
        color: white; 
        cursor: pointer;
    }

    #next:hover, #sendCode:hover {
        background-color: #45a049; 
    }

    #sec02 {
        background-color: #f9fafb; 
        border-radius: 8px; 
        margin: 10px 0;
        padding: 10px;
    }

    table {
        width: 100%; 
        border-collapse: collapse; 
    }

    td, th {
        padding: 8px; 
        text-align: left; 
    }

    input[type="text"] {
        width: 100%; 
        padding: 6px; 
        border: 1px solid #ccc; 
        border-radius: 4px;
    }

    input[type="submit"] {
        padding: 10px 20px; 
        border: none;
        border-radius: 8px; 
        background-color: #4CAF50; 
        color: white;
        cursor: pointer; 
    }

    input[type="submit"]:hover {
        background-color: #45a049; 
    }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    var isCodeSent = false; // 인증번호 발송 여부를 추적하는 변수

    $("#sendCode").on("click", function(event) {
        event.preventDefault(); // 폼 제출 막기

        var name = $("input[name='name']").val().trim();
        var phone = $("input[name='member_phone']").val().trim();

        if (name === "" || phone === "") {
            alert("이름과 전화번호를 입력해 주세요.");
            return;
        }

        if (isCodeSent) {
            alert("이미 인증번호를 발송하였습니다.");
            return;
        }

        $.ajax({
            url: $("#smsForm").attr('action'),
            type: "POST",
            data: {
                name: name,
                member_phone: phone
            },
            success: function(response) {
                alert("인증번호가 발송되었습니다. 확인 후 입력해 주세요.");
                isCodeSent = true; // 인증번호가 발송되었음을 기록
            },
            error: function() {
                alert("인증번호 발송에 실패했습니다. 다시 시도해 주세요.");
            }
        });
    });

    $("#smsForm").on("submit", function(event) {
        var authCode = $("input[name='auth_code']").val().trim();

        // 인증번호가 6자리 숫자인지 확인
        if (!/^\d{6}$/.test(authCode)) {
            alert("6자리 숫자의 인증번호를 입력해 주세요.");
            event.preventDefault(); // 기본 제출 동작 방지
            return;
        }

        if (!isCodeSent) {
            alert("먼저 인증번호를 발송해 주세요.");
            event.preventDefault(); // 기본 제출 동작 방지
            return;
        }

        // 서버에서 인증번호 검증
        $.ajax({
            url: "${pageContext.request.servletContext.contextPath}/validateAuthCode",
            type: "POST",
            data: {
                auth_code: authCode
            },
            success: function(response) {
                if (response.valid) {
                    // 인증번호가 유효할 경우 폼을 제출하여 다음 페이지로 이동
                    $("#smsForm").off("submit").submit();
                } else {
                    alert("인증번호가 유효하지 않습니다. 다시 확인해 주세요.");
                }
            },
            error: function() {
                alert("인증번호 검증에 실패했습니다. 다시 시도해 주세요.");
            }
        });

        event.preventDefault(); // 기본 제출 동작 방지
    });
});

</script>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>
    <main>
        <section>
            <div id="findPw_wrap2">
                <!-- 인증번호 요청 폼 -->
                <form id="smsForm" action="${pageContext.request.servletContext.contextPath}/PwResetPro" method="post">
                    <input type="hidden" name="member_id" value="${param.member_id}" id="member_id">
                    <section id="sec01">
                        <table>
                            <tr>
                                <td><h2>비밀번호 재설정</h2></td>
                            </tr>
                            <tr>
                                <td>회원정보에 등록한 휴대전화 번호와 입력한 전화번호가 같아야 인증번호를 받을 수 있습니다.</td>
                            </tr>
                        </table>
                    </section>    
                    <section id="sec02">
                        <div style="display: flex; flex-direction: column; gap: 10px;">
                            <table>
                                <tr>
                                    <td colspan="3"><b>이름</b></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><input type="text" name="name" placeholder="이름을 입력하세요"></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><b>휴대전화번호</b></td>
                                </tr>
                                <tr>
                                    <td><input type="text" name="member_phone" size="10" placeholder="전화번호 입력"></td>
                                    <td><input type="button" value="인증번호 받기" id="sendCode"></td>
                                </tr>    
                                <tr>
                                    <td colspan="3"><input type="text" name="auth_code" placeholder="인증번호 입력" size="10" maxlength="6"></td>
                                </tr>    
                                <tr>
                                    <td colspan="3" align="center">
                                        <input type="submit" value="다음" id="next">
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

