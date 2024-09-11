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
	alert("70,000원이 정상적으로 환급되었습니다");
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
		<h1>환급(입금이체) 결과</h1>
		<div align="center">
			<%-- depositResult 객체에 저장된 입금이체 결과 데이터 출력 --%>
			<%-- 주의! 현재 고객 성명은 res_list 배열 내의 account_holder_name 사용 --%>
			<h3>${sessionScope.sName} 고객님의 입금이체 결과 (사용자번호 : ${token.user_seq_no})</h3>
			<table border="1">
				<tr>
					<th>입금은행명(기관코드)</th>
					<td>${refundDepositResult.res_list[0].bank_name}(${refundDepositResult.res_list[0].bank_code_std})</td>
				</tr>
				<tr>
					<th>거래일시</th>
					<td>${refundDepositResult.api_tran_dtm}</td>
				</tr>
				<tr>
					<th>송금인성명</th>
					<td>리테크</td>
				</tr>
				<tr>
					<th>입금금액</th>
					<td>￦ <fmt:formatNumber value="${refundDepositResult.res_list[0].tran_amt}" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>입금계좌인자내역</th>
					<td>${refundDepositResult.res_list[0].print_content}</td>
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












