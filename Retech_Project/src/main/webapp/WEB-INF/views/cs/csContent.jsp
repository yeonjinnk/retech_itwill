<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<!-- 외부 CSS 파일(css/default.css) 연결하기 -->
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<style type="text/css">
    #listForm {
        width: 900px;
        margin: auto;
        border-collapse: collapse;
        background-color: #f0f4f8;
    }
    
    #listForm table {
        width: 100%;
        border-collapse: collapse;
    }

    #listForm table th, #listForm table td {
        padding: 15px;
        text-align: center;
        border: 1px solid #ccc;
        font-size: 1rem;
    }

    #listForm table th {
        background-color: #3498db;
        color: white;
    }

    #listForm table td a {
        color: #2c3e50;
        text-decoration: none;
        font-weight: bold;
    }

    #listForm #tr_top {
        background-color: #eee;
    }
    
    h2 {
        text-align: center;
        color: #2c3e50;
    }

    .contentArea > td {
        text-align: left;    
    }

    .cont {
        display: block;
        margin: 20px;
        color: #2c3e50;
    }

    .btnArea {
        width: 100%;
        margin: 20px auto;
        display: flex;
        justify-content: center;
        gap: 10px; 
    }

    .btnArea button {
        padding: 10px 20px;
        border: none;
        background-color: #3498db;
        color: white;
        cursor: pointer;
        font-size: 1rem;
        border-radius: 5px;
    }

    .btnArea button a {
        color: white;
        text-decoration: none;
    }

    .btnArea button:hover {
        background-color: #2980b9;
    }

    footer {
        margin-top: 30px;
    }
</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>
    <h2>공지사항</h2>
    <br>
    <section id="listForm">
        <table border="1">
            <tr id="tr_top">            
                <th width="100px">카테고리</th>
                <th>제목</th>
                <th>확인여부</th>
            </tr>
            
            <tr>
                <td width="100px">${selectedCs.cs_category}</td>
                <td>${selectedCs.cs_subject}</td>
                <td>${selectedCs.cs_check}</td>
            </tr>
            <tr class="contentArea">
                <td colspan="3" style="text-align: left;">
                    <div class="cont">${selectedCs.cs_content}</div>
                </td>
            </tr>
            
            <c:if test="${not empty selectedCs.cs_answer}">
                <tr>
                    <td colspan="3" class="reply">답변</td>
                </tr>
                <tr class="answerArea">
                    <td colspan="3">
                        <div class="answer">${selectedCs.cs_answer}</div>
                    </td>
                </tr>
            </c:if>
        </table>        
        
        <div class="btnArea">
            <button><a href="javascript:history.back()">돌아가기</a></button>
        </div>		 
    </section>
    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>
