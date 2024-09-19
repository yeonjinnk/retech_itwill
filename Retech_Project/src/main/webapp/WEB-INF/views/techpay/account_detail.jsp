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
	<section>
		<h1>계좌 상세정보</h1>
		<div align="center">
			<h3>${sessionScope.sName} 고객님의 계좌 (사용자번호 : ${token.user_seq_no})</h3>
			<table border="1">
				<tr>
					<th>은행명</th>
					<td>${accountDetail.bank_name}</td>
				</tr>
				<tr>
					<th>계좌번호</th>
					<td>${account_num_masked}</td>
				</tr>
				<tr>
					<th>계좌별칭</th>
					<td>${accountDetail.product_name}</td>
				</tr>
				<tr>
					<th>계좌잔액</th>
					<%-- 숫자(통화) 데이터 표기 시 3자리마다 콤마를 표시 --%>
					<td>￦ <fmt:formatNumber value="${accountDetail.balance_amt}" pattern="#,###" /></td>
				</tr>
				<tr> 
					<th>출금가능금액</th>
					<td>￦ <fmt:formatNumber value="${accountDetail.available_amt}" pattern="#,###" /></td>
				</tr>
				<tr>
				</tr>
			</table>
			<input type="button" value="돌아가기" onclick="window.close();">
		</div>
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>
<%-- 		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include> --%>
	</footer>
</body>
</html>












