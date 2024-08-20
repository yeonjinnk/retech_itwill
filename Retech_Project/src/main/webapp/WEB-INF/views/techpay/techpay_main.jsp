<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retech_테크페이</title>
<%-- 외부 CSS 파일(css/default.css) 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
	function 
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section class="main_section">
		<div>
			<h2>테크페이 메인</h2>
			<br>
			<div align="center">
			<%-- 엑세스토큰 정보 존재 여부에 따라 다른 링크 표시 --%>
			<%-- 세션 객체의 "token" 속성이 비어있을 경우 계좌 미인증 회원이므로 계좌인증 수행하도록 표시 --%>
			<%-- 아니면, 계좌관리 기능 버튼 표시 --%>
				<c:choose>
					<c:when test="${empty sessionScope.token}">
						${sessionScope.sName}님,<br>
						계좌 인증 시 사용 가능합니다.<br>
						<input type="button" value="계좌연결" onclick="linkPayAgreement()">
					</c:when>
				    <c:otherwise>
						계좌인증완료
				    </c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
</body>
</html>