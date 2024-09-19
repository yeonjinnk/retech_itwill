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
<script src="${pageContext.request.servletContext.contextPath}/resources/js/techpay/techpay_charge.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> <!-- Font Awesome 아이콘 라이브러리 로드 -->

<!-- 외부 CSS 파일 연결 -->
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/techpay/techpay_charge.css" rel="stylesheet" type="text/css">


</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section>
		<div class="title-container">
			<h2 id="techpay_title">테크페이 | 충전</h2>
		</div>
		<div class="paycharge_container">
	       <!-- 페이 기본 정보 표시  -->
	       <div class="pay_card">
			  <div class="title">
				<h2>
				<a href="SaleHistory" id="sName">
                        ${sessionScope.sName} 님
				</a></h2>	
			  </div>
			</div>				
          <div class="pay_balance">
	        <h2 id="pay_balance_title" >페이잔액</h2>
	        <h2><fmt:formatNumber value="${sessionScope.pay_balance}" pattern="#,###" />원</h2>
          </div>
          <div class="charge_amount">
	        <h2>충전금액</h2>
		    <div class="input-container">
		        <input type="text" id="chargeAmount" placeholder="충전을 원하시는 금액을 입력해주세요">
		        <button type="button" id="clearButton" class="clear-btn">X</button>
		    </div>	        
	        <div id="onlyDigitMessage" style="color: red; display: none;">숫자만 입력 가능합니다</div>	
				<div id="chargeButtons">
				    <button type="button" class="charge-btn" data-amount="10000">+1만원</button>
				    <button type="button" class="charge-btn" data-amount="30000">+3만원</button>
				    <button type="button" class="charge-btn" data-amount="50000">+5만원</button>
				    <button type="button" class="charge-btn" data-amount="100000">+10만원</button>
				</div>
          </div>
          <div class="pay_account_list">	
			<form action="ChargeBankWithdraw" method="post" id="PayProcessForm">
				<br>
				■ 테크페이 충전 안내<br>
				원하는 계좌의 '충전하기' 버튼을 누르시면,<br>
				테크페이 비밀번호 확인 후, 해당 계좌에서 출금하여 테크페이로 충전됩니다.
 		        <table border="1" class="account_list_table">
 					        <tr>
			        			<th>은행</th>
			        			<th>계좌별칭</th>
			        			<th>계좌번호</th>
			        			<th>예금주명</th>
			        			<th>상세정보</th>
			        		</tr>        
		        	<c:forEach var="account" items="${accountList.res_list}" begin="0" end="1">
		        		<tr>
		        			<td>
			        			<c:if test="${account.bank_code_std eq '002'}">
			        				<img src="${pageContext.request.servletContext.contextPath}/resources/img/kdb_symbol2.png" class="bank_symbol">
			        			</c:if>
		        			</td>
		        			<td><b>${account.account_alias}</b></td>
		        			<td>${account.bank_name}<br>
		        				${account.account_num_masked}<br>
		        			</td>
		        			<td>${sessionScope.sName}</td>
		        			<td>
	        					<input type="hidden" name="withdraw_fintech_use_num" value="${account.fintech_use_num}">
	        					<input type="hidden" name="withdraw_client_name" value="${account.account_holder_name}">
	        					<input type="hidden" name="tran_amt" value="50000">
	        					<input type="button" class="charge_btn" value="충전하기" onclick="openCheckPayPwdWindow()">
		        			</td>
		        		</tr>
		        	</c:forEach>	
	        	</table>      
     		</form>
          </div>
        </div>
	</section>
<!-- 	<footer> -->
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>	
<%-- 		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	 --%>
<!-- 	</footer> -->
</body>
</html>