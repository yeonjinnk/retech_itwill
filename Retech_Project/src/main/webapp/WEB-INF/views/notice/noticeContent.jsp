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
				<td>제목</td>
				<td width="150px">등록일</td>
			</tr>
			
			<tr>
				<td>${selectedNotice.notice_subject}</td>
				<td width="150px">${selectedNotice.notice_date}</td>
			</tr>
			<tr class="contentArea">
				<td colspan="4">
					<div class="cont">${selectedNotice.notice_content}</div>
				</td>
			</tr>
		</table>
		
		<!-- 이전글 다음글 구현 필요 -->
		<div class="btnArea">
			<button value=""><a href="NoticeDetail?notice_idx=${selectedNotice.notice_idx - 1}">이전</a></button>
			<button value=""><a href="Notice">목록</a></button>
			<button value=""><a href="NoticeDetail?notice_idx=${selectedNotice.notice_idx + 1}">다음</a></button>
		</div>
	</section>
	<footer>		
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>













