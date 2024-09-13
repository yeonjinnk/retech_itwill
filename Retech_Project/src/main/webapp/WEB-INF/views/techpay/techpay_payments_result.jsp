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
// 	alert("110,000원이 정상적으로 결제되었습니다");
</script>
<style type="text/css">
/* 섹션 스타일 */
section {
    margin: 20px auto;
    padding: 60px;
    max-width: 800px;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
}

/* h1 및 h3 제목 스타일 */
h1 {
    font-size: 28px;
    color: #34495E;
    margin-bottom: 20px;
    text-align: center;
}

h3 {
    font-size: 20px;
    margin-bottom: 20px;
    color: #555;
}

/* 테이블 스타일 */
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    font-size: 16px;
}

table th, table td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: left;
    font-size: 16px;
}

table th {
    background-color: #f2f2f2;
    color: #333;
    font-weight: bold;
    text-align: center;
}

table td {
    text-align: center;
}

/* 버튼 스타일 */
input[type="button"] {
    padding: 10px 20px;
    background-color: #34495E;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

input[type="button"]:hover {
    background-color: #0064FF;
}

/* 섹션 내의 div 정렬 */
div {
    text-align: center;
}

/* 페이지 여백 추가 */
section div {
    margin: 0 auto;
    max-width: 700px;
}

.gogo {
	font-size: 22px;
	color: #0064FF;
}

</style>
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
						<a href="TechPayMain" class="gogo">테크페이 내역 보기</a>
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












