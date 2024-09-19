<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.servletContext.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.servletContext.contextPath}/resources/css/techpay/techpay_check_pay_pwd.css" rel="stylesheet" type="text/css">

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
        if (event.key === "Enter") {
        	validateCurrentPassword();
        }		
	}
	
</script>
</head>
<body>
	<section>
	    <div class="header-container">
	        <h1>테크페이 비밀번호 확인</h1>
	    </div>
	    <input type="password" placeholder="테크페이 비밀번호를 입력해주세요" id="techpay_passwd_db" onkeydown="enterKeyDown(event)">
	    <input type="button" value="확인" onclick="validateCurrentPassword()">
	</section>
</body>
</html>












