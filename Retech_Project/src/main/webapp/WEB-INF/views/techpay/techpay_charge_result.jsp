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
<script type="text/javascript">
	alert("50000원이 정상적으로 충전되었습니다");
</script>
</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<%-- 현재 위치는 컨텍스트 루트(/MVC_Board = webapp) 이므로 inc 디렉토리의 top.jsp 지정 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<section>
		<%-- 본문 표시 영역 --%>
		<h1>충전이체 결과</h1>
		<div align="center">
			<%-- withdrawResult 객체에 저장된 출금이체 결과 데이터 출력 --%>
			<h3>${chargeWithdrawResult.account_holder_name} 고객님의 출금이체 결과 (사용자번호 : ${token.user_seq_no})</h3>
			<table border="1">
				<tr>
					<th>출금은행명(기관코드)</th>
					<td>${chargeWithdrawResult.bank_name}(${chargeWithdrawResult.bank_code_std})</td>
				</tr>
				<tr>
					<th>거래일시</th>
					<td>${chargeWithdrawResult.api_tran_dtm}</td>
				</tr>
				<tr>
					<th>송금인성명</th>
					<td>${chargeWithdrawResult.account_holder_name}</td>
				</tr>
				<tr>
					<th>출금금액</th>
					<td>￦ <fmt:formatNumber value="${chargeWithdrawResult.tran_amt}" pattern="#,###" /></td>
				</tr>
				<tr> 
					<th>출금한도잔여금액</th>
					<td>￦ <fmt:formatNumber value="${chargeWithdrawResult.wd_limit_remain_amt}" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>출금계좌인자내역</th>
					<td>${chargeWithdrawResult.print_content}</td>
				</tr>
				<tr>
					<th>입금계좌인자내역</th>
					<td>${chargeWithdrawResult.dps_print_content}</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" value="계좌관리 홈" onclick="location.href='TechPayMain'">
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












