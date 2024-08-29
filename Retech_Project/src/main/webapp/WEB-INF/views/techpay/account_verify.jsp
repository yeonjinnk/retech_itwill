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
		$("#verifyButton").on("click", function() {
			let authWindow = window.open("about:blank", "authWindow", "width=500,height=700,left=100,top=100");
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
<style type="text/css">

/*---- account_verify 영역 전체 ----*/
.account_verify_container {
    max-width: 500px;
    margin: auto;
    margin-bottom: 20px;
    margin-top: 20px;
    border: 1px solid gray;
    border-radius: 3px;
    box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.1); 
    padding: 50px 50px;
    box-sizing: border-box;
}

.verify_info {
    margin-bottom: 20px;
    display: block;
    width: 100%;
/*     text-align: center; /* 텍스트 중앙 정렬 */ */
}

.verify_btn {
    display: block;
    text-align: center; /* 버튼을 중앙에 위치 */s
    width: 100%;
}

.verify_btn #verifyButton {
    font-size: 10px;
    cursor: pointer; 
}

.verify_btn input {
    width: 200px; 
    padding: 10px 20px;
    box-sizing: border-box;
    display: inline-block;
    margin: 0 auto;
}

</style>
</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section class="main_section">
		<div class="account_verify_container">
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