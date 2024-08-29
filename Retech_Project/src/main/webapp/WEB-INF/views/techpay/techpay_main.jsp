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
<script type="text/javascript">
	// 새 창을 열어서 사용자 인증 서비스 요청
	// => 금융결제원 오픈API - 2.1.1. 사용자인증 API (3-legged) 서비스	
	$(document).ready(function() {
		$("#authButton").on("click", function() {
			let authWindow = window.open("about:blank", "authWindow", "width=500,height=700");
			authWindow.location = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
								+ "response_type=code"
								+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9"
								+ "&redirect_uri=http://localhost:8081/retech_proj/callback"
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
		<div>
			<h2>테크페이 메인</h2>
			<br>
			<div align="center">
				<%-- 엑세스토큰 정보 존재 여부에 따라 다른 링크 표시 --%>
				<c:choose>
					<%-- 세션 객체의 "token" 속성이 비어있을 경우, 계좌 미인증 회원이므로 계좌인증 수행하도록 표시 --%>
					<c:when test="${empty sessionScope.token}">
        				<c:redirect url="AccVerrify"/>				    					    
<%-- 						${sessionScope.sName}님,<br> --%>
<!-- 						계좌 인증 시 사용 가능합니다.<br> -->
<!-- 						<input type="button" value="계좌연결" id="authButton" > -->
					</c:when>
					<%-- 세션 객체의 "token" 속성이 비어있지 않을 경우, 계좌 인증 완료회원이므로 페이 정보페이지로 이동 --%>
				    <c:otherwise>
        				<c:redirect url="PayInfo"/>				    					    
				    </c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>	
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
</body>
</html>