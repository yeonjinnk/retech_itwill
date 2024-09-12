<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<link href="${pageContext.request.servletContext.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<style type="text/css">
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
    }

    body {
        display: flex;
        flex-direction: column;
    }

    main {
        flex: 1;
    }

    #findPw_wrap {
        border: 1px solid #ccc;
        border-radius: 12px;
        padding: 6px 18px; 
        background-color: #ffffff;
        max-width: 600px;
        margin: 0 auto;
    }

    #next {
        padding: 8px 20px; 
        border: none;
        border-radius: 8px; 
        background-color: #34495e; 
        color: white;
    }

    #next:hover {
        background-color: #45a049;
    }

    #sec02 {
        background-color: #f9fafb;
        border-radius: 8px; 
        margin: 6px auto; 
        padding: 6px; 
        max-width: 560px; 
    }

    table {
        font-size: 1.3em;
        width: 100%; 
    }

    td {
        padding: 5px 8px; 
    }
    
    footer {
        padding: 0px;
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
