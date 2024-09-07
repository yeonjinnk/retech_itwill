<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    #next {
        padding: 8px 20px;
        border: none;
        border-radius: 8px; 
        background-color: #4CAF50; 
        color: white; 
    }

    #next:hover {
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

    select {
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
        // 인증번호 받기 요청을 비동기적으로 처리
        $("#smsForm").on("submit", function(event) {
            event.preventDefault(); // 폼의 기본 제출 동작을 막음
            
            var submitButton = event.originalEvent.submitter;
            if (submitButton && submitButton.id === "next") {
                // 다음 버튼 클릭 시 인증번호 확인 요청을 비동기적으로 처리
                var formData = $(this).serialize(); // 폼 데이터를 직렬화

                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/VerifyCode", // 인증번호 확인 URL
                    data: formData,
                    success: function(response) {
                        var jsonResponse = JSON.parse(response); // 응답을 JSON으로 파싱
                        if (jsonResponse.result) {
                            alert("인증 성공!");
                            window.location.href = jsonResponse.redirectUrl || "${pageContext.request.contextPath}/member/member_pw_reset"; // 리디렉션 URL
                        } else {
                            alert("인증 실패. 인증번호를 확인해 주세요.");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("서버 요청 실패:", status, error);
                    }
                });
            } else {
                // 인증번호 받기 버튼 클릭 시
                var formData = $(this).serialize(); // 폼 데이터를 직렬화

                $.ajax({
                    type: "POST",
                    url: $(this).attr("action"), // 폼의 action 속성 값을 사용
                    data: formData,
                    success: function(response) {
                        var jsonResponse = JSON.parse(response); // 응답을 JSON으로 파싱
                        if (jsonResponse.result) {
                            alert("인증번호가 성공적으로 발송되었습니다.");
                        } else {
                            alert("인증번호 발송에 실패했습니다.");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("서버 요청 실패:", status, error);
                    }
                });
            }
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
                <form id="smsForm" action="${pageContext.request.contextPath}/SendSms" method="post">
                    <input type="hidden" name="member_id" value="${param.mem_id}" id="member_id" size="10">
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
                                    <td colspan="3"><input type="text" name="name" size="10" maxlength="5" placeholder="이름을 입력하세요"></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><b>휴대전화번호</b></td>
                                </tr>
                                <tr>
                                    <td>
                                        <select name="CountryCode">
                                            <option value="+82">+82</option>
                                        </select>
                                    </td>
                                    <td><input type="text" name="phone_number" size="10" placeholder="전화번호 입력"></td>
                                    <td><input type="submit" value="인증번호 받기" id="sendCode"></td>
                                </tr>    
                                <tr>
                                    <td colspan="3"><input type="text" name="auth_code" placeholder="인증번호 입력" size="10" maxlength="8"></td>
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
