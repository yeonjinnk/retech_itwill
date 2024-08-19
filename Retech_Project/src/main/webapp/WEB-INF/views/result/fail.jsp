<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<script>
			alert("${requestScope.msg}");
			// alert (); 는 자바스크립트인데 안에 들어가는 코드는 자바 문자열임
			// 자바스크립트는 자바의 코드를 판별할 수 없음
			// 그래서 문자열인거 알아야하니까 "" 처리 해줘야함
			
			// 1) JSTL과 EL을 조합하여 request 객체의 "targetURL" 속성이 비어있을 경우
			// 이전페이지로 돌아가기를 수행하고, 
			// 아니면 "targetURL" 속성에 지정된 페이지로 이동
			
			// jsp 주석으로 해줘야함
			<%--
			<c:choose> 
				<c:when test="${empty requestScope.targetURL}">
					history.back();
				</c:when>
				<c:otherwise> 
					location.href = "${targetURL}" //requestScope 생략 가능
				</c:otherwise>
			</c:choose>
			--%>
			
			// 2) 자바스크립트의 조건문으로 판별
			// 자바 문자열 데이터를 자바 스크립트로 판별 시 EL 문장을 ""로 둘러싸야 한다.
			
			if ("${targetURL}" == "") {
				history.back();		
			} else {
				location.href = "${targetURL}" 
			}
			
		</script>
	</body>
</html>