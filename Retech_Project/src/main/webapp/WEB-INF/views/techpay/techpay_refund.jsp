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


    // 충전금액 텍스트박스에 반영하기
    $(document).ready(function() {
        $('#refundButtons').on('click', '.refund-btn', function() {
            // 현재 텍스트 박스에 입력된 값을 숫자로 변환(빈 값일 경우 0으로 처리)
            let currentAmount = parseInt($('#refundAmount').val()) || 0;
        
            // 클릭된 버튼의 data-amount 속성에서 충전 금액 가져오기
            let additionalAmount = parseInt($(this).data('amount'));
        
            // 기존 금액에 버튼의 금액을 더하기
            let newAmount = currentAmount + additionalAmount;
        
            // 텍스트 박스의 값을 업데이트
            $('#refundAmount').val(newAmount);
        });
        
        
     // 충전금액 텍스트박스에 숫자가 아닌 값 넣지 못하도록 함
        $('#refundAmount').on('keydown', function(event) {
            // keyCode 가져오기
            let keyCode = event.keyCode;

            // 숫자, 백스페이스, Delete 키만 허용
            if (!(event.keyCode >= 48 && event.keyCode <= 57) && !(event.keyCode >= 96 && event.keyCode <= 105) &&event.keyCode !== 8 && event.keyCode !== 46) {
                // 허용되지 않은 키가 눌렸을 경우 경고 메시지 표시
                $('#onlyDigitMessage').show();
            } else {
                // 허용된 키가 눌렸을 경우 경고 메시지 숨김
                $('#onlyDigitMessage').hide();
            }
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

<style type="text/css">
/*---- techpay_refund 영역 전체 ----*/
.payrefund_container {
    max-width: 600px;
    margin: 40px auto;
    border: 1px solid lightgray;
    border-radius: 5px;
    padding: 20px;
    background-color: white;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
    box-sizing: border-box;
}

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
.refund_amount h2 {
    font-size: 18px;
    color: #34495E;
}

/*---- 환급금액 영역 ----*/
.refund_amount input[type="text"] {
    width: 100%;
    padding: 12px;
    font-size: 16px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
    transition: border-color 0.3s ease;
}

.refund_amount input[type="text"]:focus {
    border-color: #007BFF;
    outline: none;
}


#onlyDigitMessage {
    font-size: 14px;
    margin-top: 5px;
    color: #dc3545; /* 빨간색 경고 메시지 */
}

/* pay_account_list - 계좌 리스트 영역 */
.pay_account_list {
    margin-top: 20px;
    background-color: #f9f9f9;
    margin-top: 50px;
    padding: 30px 0px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.refundButtons {
	margin-top: 10px;
}

.refund_btn { 
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

.pay_account_list h2 {
    font-size: 20px;
    margin-bottom: 20px;
    color: #34495E;
    font-weight: bold;
    text-align: center;
}

.refund_btn {
    padding: 8px 12px;
    background-color: #2c3e50; /* 버튼 색상 */
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    transition: background-color 0.3s ease;
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

.refund_btn:hover {
    background-color: #2980b9; /* 호버 시 어두운 색상 */
}

.bank_symbol {
	margin-top: 5px 0px 5px 0px;
	width: 40px;
	height: 30px;
}

.refund_btn:hover {
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

.refund_amount {
	padding: 0px 20px;
}

/* #chargeButtons 컨테이너의 버튼을 가로로 꽉 차게 분배 */
#refundButtons {
    display: flex;
    justify-content: space-between; /* 버튼들 사이 간격을 동일하게 만듦 */
    gap: 5px; /* 버튼 간의 간격을 10px로 설정 */
}

#refundButtons .refund-btn {
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

#refundButtons .refund-btn:hover {
    background-color: #2980b9; /* 호버 시 색상 변경 */
}

</style>
</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section>
		<div class="payrefund_container">
	       <!-- 페이 기본 정보 표시  -->
	       <div class="pay_card">
			  <div class="title">
				<h2>${sessionScope.sName} 님</h2>
				<img src="${pageContext.request.servletContext.contextPath}/resources/images/logo.png" height="40" width="80">
			  </div>
			</div>				
          <div class="pay_balance">
	        <h2>페이잔액</h2> 
	        <h2><fmt:formatNumber value="${sessionScope.pay_balance}" pattern="#,###" />원</h2>
          </div>
          <div class="refund_amount">
	        <h2>환급금액</h2>
	        <input type="text" id="refundAmount" onkeypress="checkDigit(event)" placeholder="환급을 원하시는 금액을 입력해주세요">
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
     			테크페이 환급 안내<br>
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