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
<style type="text/css">
/* 전체 페이지 스타일 */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
/*     background-color: #f4f4f4; */
    color: #333;
}

/* 헤더와 푸터 스타일 */
header, footer {
/*     background-color: #34495E; */
    color: white;
    padding: 10px;
    text-align: center;
}

/* 섹션 스타일 */
section {
    margin: 30px auto;
    padding: 100px;
    max-width: 600px;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
}

/* h1 제목 스타일 */
h1 {
    font-size: 24px;
    color: #34495E;
    margin-bottom: 20px;
}

/* 비밀번호 입력 필드 스타일 */
input[type="password"] {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    box-sizing: border-box;
    transition: border-color 0.3s ease;
}

/* 포커스 시 입력 필드 스타일 */
input[type="password"]:focus {
    border-color: #007BFF;
    outline: none;
}

/* 확인 버튼 스타일 */
input[type="button"] {
    padding: 12px 20px;
    background-color:  #34495E;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    margin-top: 10px;
    width: 100%;
    transition: background-color 0.3s ease;
}

/* 확인 버튼 호버 시 색상 변화 */
input[type="button"]:hover {
    background-color: #0064FF;
}

/* 입력 폼을 위한 컨테이너 */
input-container {
    display: flex;
    flex-direction: column;
    gap: 10px;
}
/* header-container 스타일 */
.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

/* h1 제목 스타일 수정 */
h1 {
    font-size: 24px;
    color: #34495E;
    margin: 0; /* 여백 제거 */
}

</style>
</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<%-- 현재 위치는 컨텍스트 루트(/MVC_Board = webapp) 이므로 inc 디렉토리의 top.jsp 지정 --%>
<%-- 		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include> --%>
	</header>
	<section>
	    <div class="header-container">
	        <h1>테크페이 비밀번호 확인</h1>
<%-- 	        <img src="${pageContext.request.servletContext.contextPath}/resources/images/logo.png" height="50" width="100"> --%>
	    </div>
	    <input type="password" placeholder="테크페이 비밀번호를 입력해주세요" id="techpay_passwd_db" onkeydown="enterKeyDown(event)">
	    <input type="button" value="확인" onclick="validateCurrentPassword()">
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>
<%-- 		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include> --%>
	</footer>
</body>
</html>












