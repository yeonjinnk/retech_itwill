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
<link href="${pageContext.request.contextPath}/resources/css/techpay/techpay_refund.css" rel="stylesheet" type="text/css">

<script type="text/javascript">


// 환급금액 텍스트박스에 반영하기
$(document).ready(function() {
    $('#refundButtons').on('click', '.refund-btn', function() {
        // 현재 텍스트 박스에 입력된 값을 숫자로 변환(빈 값일 경우 0으로 처리)
        let currentAmount = parseInt($('#refundAmount').val().replace(/,/g, '')) || 0; // 기존 콤마 제거
    
        // 클릭된 버튼의 data-amount 속성에서 환급 금액 가져오기
        let additionalAmount = parseInt($(this).data('amount'));
    
        // 기존 금액에 버튼의 금액을 더하기
        let newAmount = currentAmount + additionalAmount;
    
        // 텍스트 박스의 값을 업데이트
        $('#refundAmount').val(newAmount.toLocaleString());
    });
    
    // 환급금액 텍스트박스에 숫자만 허용
    $('#refundAmount').on('input', function() {
        let value = this.value.replace(/,/g, '');
        if (/^\d*$/.test(value)) {
            this.value = Number(value).toLocaleString();
            $('#onlyDigitMessage').hide();
        } else {
            $('#onlyDigitMessage').show();
        }
    });
	
    // 'X' 버튼 클릭 시 텍스트 박스 내용 초기화
    $('#clearButton').on('click', function() {
        $('#refundAmount').val('');
    });  
    
});
   
   
// 환급금액, 잔액 판별 후 페이비밀번호 확인 새 창 열기
function openCheckPayPwdWindow() {
	
	let pay_balance = ${sessionScope.pay_balance};
	console.log(pay_balance);
	let currentAmount = parseInt($('#refundAmount').val());
	console.log("currentAmount : " + currentAmount);
	
	// 환급금액이 입력되지 않거나
	// 잔액보다 큰 금액을 환급할 시에는 환급 불가
	if(isNaN(currentAmount)) {
		alert("환급 금액을 입력해주세요!");
	} else if (pay_balance < currentAmount) {
		alert("페이잔액이 환급 금액보다 클 때에만 환급이 가능합니다!");
	} else {
	    // "CheckPayPwd" 서블릿 주소로 페이 비밀번호 확인 새 창 열기
	    window.open('CheckPayPwd', 'CheckPayPwdWindow', 'width=500,height=400');
	}
}    
    
    
</script>

</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section>
		<div class="title-container">
			<h2 id="techpay_title">테크페이 | 환급</h2>
		</div>
		<div class="payrefund_container">
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
	        <h2>페이잔액</h2> 
	        <h2><fmt:formatNumber value="${sessionScope.pay_balance}" pattern="#,###" />원</h2>
          </div>
          <div class="refund_amount">
	        <h2>환급금액</h2>
     		<div class="input-container">
		        <input type="text" id="refundAmount" placeholder="환급을 원하시는 금액을 입력해주세요">
		        <button type="button" id="clearButton" class="clear-btn">X</button>
		    </div>	
	        
	        <div id="onlyDigitMessage" style="color: red; display: none;">숫자만 입력 가능합니다</div>	
				<div id="refundButtons">
				    <button type="button" class="refund-btn" data-amount="10000">+1만원</button>
				    <button type="button" class="refund-btn" data-amount="30000">+3만원</button>
				    <button type="button" class="refund-btn" data-amount="50000">+5만원</button>
				    <button type="button" class="refund-btn" data-amount="100000">+10만원</button>
				</div>
          </div>
          <div class="pay_account_list">	
     		<form action="RefundBankDeposit" method="post" id="PayProcessForm">
     			<br>
     			■ 테크페이 환급 안내<br>
				원하는 계좌의 '환급하기' 버튼을 누르시면,<br>
				테크페이 비밀번호 확인 후, 테크페이에서 해당 계좌로 환급이 진행됩니다.     		
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
	        					<input type="hidden" name="deposit_fintech_use_num" value="${account.fintech_use_num}">
	        					<input type="hidden" name="deposit_client_name" value="${account.account_holder_name}">
	        					<input type="hidden" name="tran_amt" value="70000">
		       					<input type="button" class="refund_btn" value="환급하기" onclick="openCheckPayPwdWindow()">
		        			</td>
		        		</tr>
		        	</c:forEach>	
	        	</table>        		        
		    </form>
          </div>
        </div>
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>	
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
</body>
</html>