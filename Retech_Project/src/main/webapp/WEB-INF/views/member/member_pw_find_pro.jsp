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
        padding: 10px 20px; /* 패딩 조정 */
        background-color: #ffffff;
        max-width: 500px; /* 최대 너비 설정 */
        margin: 20px auto; /* 중앙 정렬 */
    }

    #next {
        padding: 8px 20px; /* 패딩 조정 */
        border: none;
        border-radius: 8px; /* 둥근 모서리 */
        background-color: #4CAF50; /* 버튼 색상 변경 */
        color: white; /* 텍스트 색상 변경 */
    }

    #next:hover {
        background-color: #45a049; /* hover 시 버튼 색상 변경 */
    }

    #sec02 {
        background-color: #f9fafb; /* 배경 색상 밝게 변경 */
        border-radius: 8px; /* 둥근 모서리 */
        margin: 10px 0; /* 상하 여백 설정 */
        padding: 10px;
    }

    table {
        width: 100%; /* 테이블 너비 100% */
        border-collapse: collapse; /* 테이블 셀 간의 간격 제거 */
    }

    td, th {
        padding: 8px; /* 셀 내 여백 조정 */
        text-align: left; /* 텍스트 정렬 */
    }

    input[type="text"] {
        width: 100%; /* 텍스트 입력 필드 너비 조정 */
        padding: 6px; /* 패딩 추가 */
        border: 1px solid #ccc; /* 테두리 색상 설정 */
        border-radius: 4px; /* 둥근 모서리 */
    }

    select {
        width: 100%; /* 셀렉트 박스 너비 조정 */
        padding: 6px; /* 패딩 추가 */
        border: 1px solid #ccc; /* 테두리 색상 설정 */
        border-radius: 4px; /* 둥근 모서리 */
    }

    input[type="submit"] {
        padding: 10px 20px; /* 패딩 조정 */
        border: none;
        border-radius: 8px; /* 둥근 모서리 */
        background-color: #4CAF50; /* 버튼 색상 변경 */
        color: white; /* 텍스트 색상 변경 */
        cursor: pointer; /* 커서 포인터로 변경 */
    }

    input[type="submit"]:hover {
        background-color: #45a049; /* hover 시 버튼 색상 변경 */
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
                    <input type="hidden" name="member_id" value="${param.mem_id}" id="member_phonenumber" size="10">
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
