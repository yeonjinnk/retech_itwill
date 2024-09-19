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
<link href="${pageContext.request.servletContext.contextPath}/resources/css/techpay/techpay_result.css" rel="stylesheet" type="text/css">

</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<%-- 현재 위치는 컨텍스트 루트(/MVC_Board = webapp) 이므로 inc 디렉토리의 top.jsp 지정 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<section>
		<%-- 본문 표시 영역 --%>
		<h1>테크페이 결제 완료</h1>
		<div align="center">
			<%-- withdrawResult 객체에 저장된 출금이체 결과 데이터 출력 --%>
			<h3>${sessionScope.sName} 고객님의 결제 내역 (결제코드 : ${paymentResult.techpay_idx})</h3>
			<table border="1">
				<tr>
					<th>결제상품</th>
					<td>${paymentResult.pd_subject}</td>
				</tr>
				<tr>
					<th>결제일시</th>
					<td>${paymentResult.techpay_tran_dtime}</td>
				</tr>
				<tr>
					<th>결제금액</th>
					<td>￦ <fmt:formatNumber value="${paymentResult.tran_amt}" pattern="#,###" /></td>
				</tr>
				<tr> 
					<th>결제 후 테크페이 잔액</th>
					<td>￦ <fmt:formatNumber value="${paymentResult.pay_balance}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" value="테크페이 내역 보기" onclick="location.href='TechPayMain'">
					</td>
				</tr>
			</table>
		</div>
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>












