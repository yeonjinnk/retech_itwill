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
		width: 1024px;
		max-height: 610px;
		margin: auto;
	}
	
	#listForm #tr_top {
		background-color: #eee;
	}
	
	h2 {
		text-align: center;
	}
	
	table {
		margin: auto;
		width: 1024px;
	}
	
	table td {
		text-align: center;
	}
	
	a {
		text-decoration: none;
	}
	
	#subject {
		text-align: left;
		padding-left: 20px;
	}
	.contentArea > td {
		text-align: left;	
	}
	
	.cont {
		display: block;
		margin: 50px;
		height: 100%;
	}
	
	.btnArea {
		width: 100px;
		margin: 0 auto;
		margin-top: 30px;
		margin-bottom: 30px;
		display: flex;
		justify-content: space-between;
	}
	
	.reply {
		background-color: #eee;
	}
	
	.button-container {
            text-align: center; 
            margin-top: 50px; 
    }
	
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<h2>1:1 문의</h2>
	<br>
	<section id="listForm">
		<table border="1">
			<tr id="tr_top">			
				<td width="100px">문의유형</td>
				<td>제목</td>
				<td>확인여부</td>
			</tr>
			
			<tr>
				<td width="100px">${selectedCs.cs_category}</td>
				<td>${selectedCs.cs_subject}</td>
				<td>${selectedCs.cs_check}</td>
			</tr>
			<tr class="contentArea">
				<td colspan="4">
					<div class="cont">${selectedCs.cs_content}</div>
				</td>
			</tr>
			
			<c:if test="${not empty selectedCs.cs_answer}">
				<tr>
					<td colspan="4" class="reply">답변</td>
				</tr>
				<tr class="answerArea">
					<td colspan="4">
						<div class=answer>${selectedCs.cs_answer}</div>
					</td>
				</tr>
			</c:if>
		</table>		
		<div class="button-container">
        	<input type="button" class="button" value="돌아가기" onclick="history.back()">
   		</div>		 
	</section>
	<footer>		
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>













