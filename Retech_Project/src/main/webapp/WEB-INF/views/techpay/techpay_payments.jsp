<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retech_테크페이</title>
<!-- 자바스크립트 연결 -->
<script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> <!-- Font Awesome 아이콘 라이브러리 로드 -->
<!-- 외부 CSS 파일(css/default.css) 연결 -->
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

	// 결제 비밀번호 확인
	function openCheckPayPwdWindow() {
	     // "CheckPayPwd" 서블릿 주소로 새 창을 열기
	     window.open('CheckPayPwd', 'CheckPayPwdWindow', 'width=500,height=400');
	 }

</script>

<style type="text/css">

/*---- paycharge_container 전체 ----*/
.payments_container {
    max-width: 600px;
    margin: 40px auto;
    border: 1px solid lightgray;
    border-radius: 5px;
    padding: 20px;
    background-color: white;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
    box-sizing: border-box;
    padding-bottom: 50px;
}

/* title, pay_balance - 페이잔액 상단 영역 */
.title, .pay_balance {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.title img {
    height: 40px;
    width: 80px;
}

/* charge_amount - 충전금액 입력 영역 */
.payments_amount h2 {
    font-size: 18px;
    color: #34495E;
}

.payments_amount input[type="text"] {
    width: 100%;
    padding: 12px;
    font-size: 16px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
    transition: border-color 0.3s ease;
}

.payments_amount input[type="text"]:focus {
    border-color: #007BFF;
    outline: none;
}

#onlyDigitMessage {
    font-size: 14px;
    margin-top: 5px;
    color: #dc3545; /* 빨간색 경고 메시지 */
}

/* charge_btn - 충전 금액 버튼들 */
.charge_btn {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    background-color: #3498db;
    color: white;
    cursor: pointer;
    font-size: 16px;
    width: 100%;
    margin-top: 10px;
    transition: background-color 0.3s ease;
}

.charge_btn:hover {
    background-color: #2980b9; /* 호버 시 어두운 색상 */
}

/* pay_account_list - 계좌 리스트 영역 */
.pay_account_list {
/*     margin-top: 20px; */
    background-color: #f9f9f9;
    margin-top: 20px;
    padding: 30px 0px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.pay_account_list h2 {
    font-size: 20px;
    margin-bottom: 20px;
    color: #34495E;
    font-weight: bold;
    text-align: center;
}

/* 계좌 목록 테이블 스타일 */
.account_list_table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

.account_list_table th, .account_list_table td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    font-size: 16px;
}

.account_list_table th {
    background-color: #f2f2f2;
    color: #333;
    font-weight: bold;
    text-align: center;
}

.account_list_table td {
    text-align: center;
}

.bank_symbol {
    display: block;
    margin: 0 auto;
    width: 40px;
    height: 30px;
}

/* 계좌 충전 버튼 */
/* .payment_btn { */
/*     padding: 8px 12px; */
/*     background-color: #2c3e50; /* 버튼 색상 */ */
/*     color: white; */
/*     border: none; */
/*     border-radius: 5px; */
/*     cursor: pointer; */
/*     font-size: 14px; */
/*     transition: background-color 0.3s ease; */
/* } */

.payment_btn:hover {
    background-color: #1a242f; /* 호버 시 버튼 색상 */
}

#sName {
	color: #0064FF;
	font-size: 28px;
	padding-top: 5px;
}

.pay_balance{
	padding: 0px 20px;
}

.pay_account_list {
	padding: 0px 20px;
}

.charge_amount {
	padding: 0px 20px;
}

/* #chargeButtons 컨테이너의 버튼을 가로로 꽉 차게 분배 */
#chargeButtons {
    display: flex;
    justify-content: space-between; /* 버튼들 사이 간격을 동일하게 만듦 */
    gap: 5px; /* 버튼 간의 간격을 10px로 설정 */
}

#chargeButtons .charge-btn {
    flex: 1; /* 버튼이 동일한 비율로 가로 영역을 차지하도록 설정 */
    padding: 10px 0; /* 버튼의 상하 여백 설정 */
    background-color: #34495E;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
    text-align: center;
}

#chargeButtons .payment-btn:hover {
    background-color: #2980b9; /* 호버 시 색상 변경 */
}

.payments_amount {
	padding-left: 20px;
}

#payments_amt_text {
	font-size: 20px; 
	color: #0064FF;
	text-decoration: underline;
} 

/* .payment_btn{ */
/* 	margin-top: 20px; */
/* 	margin-bottom: 20px; */
/* 	width: 40%; */
	
/* } */

.pay_account_list {
	padding: 20px 20px 20px 20px;


}

.payment_btn {

    padding: 12px;
    background-color: #2c3e50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
    width: 40%; /* 적당한 크기로 버튼을 설정 */
    margin: 0 auto; /* 버튼을 가운데로 정렬 */
    display: block; /* 버튼이 블록으로 취급되어 가운데 정렬 적용 */
    text-align: center;
}

.payment_btn {
	margin-top: 20px; 
	margin-bottom: 20px;
}

.payment_btn:hover {
    background-color: #1a242f;
}
</style>
</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section>
		<div class="payments_container">
	       <!-- 페이 기본 정보 표시  -->
	       <div class="pay_card">
			  <div class="title">
				<h2>
				<a href="SaleHistory" id="sName">
                        ${sessionScope.sName} 님
				</a></h2>	
<%-- 				<img src="${pageContext.request.servletContext.contextPath}/resources/images/logo.png" height="50" width="100"> --%>
			  </div>
			</div>				
          <div class="pay_balance">
    <h2 id="pay_balance_title" >페이잔액</h2>
	        <h2><fmt:formatNumber value="${sessionScope.pay_balance}" pattern="#,###" />원</h2>
          </div>
          <div class="payments_amount">
	        <h2>거래번호 : ${param.trade_idx}</h2>
<%-- 	        <h2 >결제금액 : <fmt:formatNumber value="${tran_amt}" pattern="#,###" />원</h2> --%>
<%-- 	        <h2><fmt:formatNumber value="${tran_amt}" pattern="#,###" />원</h2> --%>
          </div>
          <div class="pay_account_list">	
     		<form action="TechPaymentsProcess" method="post" id="PayProcessForm">
    			테크페이 결제 안내<br>
<!-- 				원하는 계좌의 '결제하기' 버튼을 누르시면,<br> -->
				테크페이 비밀번호 확인 후, <br>
				<a id="payments_amt_text" >결제금액 <fmt:formatNumber value="${tran_amt}" pattern="#,###" />원</a>을 
				테크페이에서 차감합니다.     		  		
				
<!--  		        <table border="1" class="account_list_table"> -->
<!--      			        	<tr> -->
<!-- 			        			<th>은행</th> -->
<!-- 			        			<th>계좌별칭</th> -->
<!-- 			        			<th>계좌번호</th> -->
<!-- 			        			<th>예금주명</th> -->
<!-- 			        			<th>상세정보</th> -->
<!-- 			        		</tr> -->
<%-- 		        	<c:forEach var="account" items="${accountList.res_list}" begin="0" end="1"> --%>
<!-- 		        		<tr> -->
<!-- 		        			<td> -->
<%-- 			        			<c:if test="${account.bank_code_std eq '002'}"> --%>
<%-- 			        				<img src="${pageContext.request.servletContext.contextPath}/resources/img/kdb_symbol2.png" class="bank_symbol"> --%>
<%-- 			        			</c:if> --%>
<!-- 		        			</td> -->
<%-- 		        			<td><b>${account.account_alias}</b></td> --%>
<%-- 		        			<td>${account.bank_name}<br> --%>
<%-- 		        				${account.account_num_masked}<br> --%>
<!-- 		        			</td> -->
<%-- 		        			<td>${sessionScope.sName}</td> --%>
<!-- 		        			<td> -->
	        					<input type="hidden" name="withdraw_fintech_use_num" value="${account.fintech_use_num}">
	        					<input type="hidden" name="withdraw_client_name" value="${account.account_holder_name}">
	        					<input type="hidden" name="tran_amt" value="110000">
	        					<input type="hidden" name="trade_idx" value="${param.trade_idx}"><br>
	        					<input type="button" class="payment_btn" value="결제하기" onclick="openCheckPayPwdWindow()">		        			
<!-- 		        			</td> -->
<!-- 		        		</tr>		        	 -->
<%-- 		        	</c:forEach>	 --%>
<!-- 	        	</table>        		        -->
		    </form>
<!-- 	            <button class="payments_btn">결제하기</button> -->
          </div>
        </div>
	</section>
<!-- 	<footer> -->
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>	
<%-- 		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	 --%>
<!-- 	</footer> -->
</body>
</html>