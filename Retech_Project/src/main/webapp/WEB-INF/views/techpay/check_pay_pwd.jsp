<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 외부 CSS 파일(css/default.css) 연결하기 --%>
<link href="${pageContext.request.servletContext.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">

<!-- 자바스크립트 연결 -->
<script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>

<script type="text/javascript">
	// 입력한 비밀번호가 세션의 비밀번호와 같은지 비교
	function validateCurrentPassword() {
		let isValid = true;
		
	    let enteredPassword = $("#techpay_passwd_db").val();  
	    let sessionPassword = "${sessionScope.pay_pwd}";     
	
	    if (enteredPassword !== sessionPassword) {
	    	isValid = false;
	    }
	    
	    if(isValid == false) {
            alert("테크페이 비밀번호를 올바르게 입력해주세요!"); 
            $("#techpay_passwd_db").focus(); 	    	
	    } else {
            alert("테크페이 비밀번호 확인 완료!"); 

            // 부모 창에서 폼을 제출하고 새 창을 닫음
            opener.$('#PayProcessForm').submit();  // 부모 창의 폼을 제출
            window.close();  // 새 창 닫기

	    }
	    
	}
	
	// 입력란에서 엔터 치면 특정 비밀번호 확인 함수 호출
	function enterKeyDown(event) {
//         	console.log("----------enterKeyDown 호출됨-----------")
        if (event.key === "Enter") {
//         	console.log("----------enterKeyDown 엔터키 !!!---------")
        	validateCurrentPassword();
        }		
	}
	
</script>
</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<%-- 현재 위치는 컨텍스트 루트(/MVC_Board = webapp) 이므로 inc 디렉토리의 top.jsp 지정 --%>
<%-- 		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include> --%>
	</header>
	<section>
		<%-- 본문 표시 영역 --%>
		<h1>테크페이 비밀번호 확인</h1>
			<input type="password" placeholder="테크페이 비밀번호를 입력해주세요" id="techpay_passwd_db" onkeydown="enterKeyDown(event)">
			<input type="button" value="확인" onclick="validateCurrentPassword()">
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>
<%-- 		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include> --%>
	</footer>
</body>
</html>












