<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<link href="${pageContext.request.servletContext.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #findPw_wrap {
        border: 1px solid #ccc;
        border-radius: 12px;
        padding: 6px 18px; /* 패딩 크기 축소 */
        background-color: #ffffff;
        max-width: 600px; /* 최대 너비 설정 */
        margin: 0 auto; /* 중앙 정렬 */
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
        margin: 6px auto; /* 양옆 여백을 자동으로 조정하여 중앙 정렬 */
        padding: 6px; /* 패딩 축소 */
        max-width: 560px; /* 최대 너비 설정 */
    }

    table {
        font-size: 0.9em;
        width: 100%; /* 테이블 너비 100%로 설정 */
    }

    td {
        padding: 5px 8px; 
    }
</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>
    <main>
        <section>
            <div id="findPw_wrap">
                <form action="PwFindPro" method="post" id="form01">
                    <section id="sec01">
                        <table>
                            <tr>
                                <td id="td01"><h2>비밀번호 재설정</h2></td>
                            </tr>
                            <tr>
                                <td id="td02">찾고자 하는 아이디를 입력해주세요</td>
                            </tr>
                        </table>
                    </section>    
                    <section id="sec02">
                        <div style="display: flex; justify-content: center;">
                            <table>
                                <tr>
                                    <td id="td03">아이디</td>
                                    <td><input type="text" name="member_id" id="member_id" size="10" required="required"></td>
                                </tr>
                                <tr>
                                    <td id="td04" colspan="2">
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
