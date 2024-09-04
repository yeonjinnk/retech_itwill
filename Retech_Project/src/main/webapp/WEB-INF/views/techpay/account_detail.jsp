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
		<h1>핀테크 계좌 상세정보</h1>
		<div align="center">
			<%-- bankAccountList 객체에 저장된 핀테크 계좌목록 데이터 출력 --%>
			<%-- 계좌목록 정보에는 사용자번호(user_seq_no)가 존재하지 않지만, 세션의 token 객체에 저장되어 있음 --%>
			<h3>${sessionScope.sName} 고객님의 계좌 상세 정보 (사용자번호 : ${token.user_seq_no})</h3>
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
					<th>상품명</th>
					<td>${accountDetail.product_name}</td>
				</tr>
				<tr>
					<th>계좌잔액</th>
<%-- 					<td>￦ ${accountDetail.balance_amt}</td> --%>
					<%-- 숫자(통화) 데이터 표기 시 3자리마다 콤마를 표시할 경우 --%>
					<%-- <fmt:formatNumber> 태그 활용 => fmt 라이브러리 추가 필수! --%>
					<td>￦ <fmt:formatNumber value="${accountDetail.balance_amt}" pattern="#,###" /></td>
				</tr>
				<tr> 
					<th>출금가능금액</th>
<%-- 					<td>￦ ${accountDetail.available_amt}</td> --%>
					<td>￦ <fmt:formatNumber value="${accountDetail.available_amt}" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>핀테크이용번호</th>
					<td>${accountDetail.fintech_use_num}</td>
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












