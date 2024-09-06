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
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>
    <main>
        <section>
            <div id="findPw_wrap2">
                <form action="PwResetPro" method="post">
                    <input type="hidden" name="member_id" value="${param.mem_id}" id="member_phone" size="10">
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
                                    <td colspan="3"><input type="text" size="10" maxlength="5" placeholder="이름을 입력하세요"></td>
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
                                    <td><input type="text" name="member_phone" id="member_phone" size="10" placeholder="전화번호 입력"></td>
                                    <td><input type="submit" value="인증번호 받기"></td>
                                </tr>    
                                <tr>
                                    <td colspan="3"><input type="text" name="name" placeholder="인증번호 입력" size="10" maxlength="8"></td>
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



