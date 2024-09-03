<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retech_테크페이</title>
<%-- 외부 CSS 파일(css/default.css) 연결 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">

<%-- 자바스크립트 연결 --%>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>


</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section class="main_section">
		<div>
			<h2>테크페이 메인</h2>
			<br>
			<div align="center">
				<%-- 페이관리자용 엑세스토큰 발급 --%>
				<input type="button" value="센터인증 이용기관 토큰발급" onclick="location.href='AdminBankRequestToken'">
			</div>
		</div>
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>	
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
</body>
</html>