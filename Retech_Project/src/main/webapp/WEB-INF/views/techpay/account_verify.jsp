<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retech_테크페이</title>
<%-- 외부 CSS 파일 연결 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/techpay/techpay_verify.css" rel="stylesheet" type="text/css">

<%-- 자바스크립트 연결 --%>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>

<script type="text/javascript">
	// 새 창을 열어서 사용자 인증 서비스 요청
	// => 금융결제원 오픈API - 2.1.1. 사용자인증 API (3-legged) 서비스	
	$(document).ready(function() {
		$("#verifyButton").on("click", function() {
			let authWindow = window.open("about:blank", "authWindow", "width=500,height=700,left=100,top=100");
			authWindow.location = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
								+ "response_type=code"
								+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9"
								+ "&redirect_uri=http://c5d2403t1.itwillbs.com/Retech_Project/callback"
								+ "&scope=login inquiry transfer"
								+ "&state=12345678901234567890123456789012"
								+ "&auth_type=0";
		});
	});	
</script>

</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section class="main_section">
		<div class="account_verify_container" id="account_verify_container2">
			<div class="verify_info">
				<b>${sessionScope.sName}</b>님,<br>
				계좌연결 시 사용 가능합니다.<br>
			</div>
			<div class="verify_btn">
				<input type="button" value="계좌연결" id="verifyButton" >
			</div>
		</div>
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>	
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
</body>
</html>