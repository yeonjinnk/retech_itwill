<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	function deleteAccount() {
		let deleteAccountConfirm = confirm("테크페이에서 해당 계좌를 삭제하시겠습니까?");
		console.log(deleteAccountConfirm);
		if(deleteAccountConfirm == true) {
			
		}
	}


</script>

<style type="text/css">
/*---- techpay_manage 영역 전체 ----*/
.paymanage_container {
	max-width: 500px;
	margin: auto;
	margin-bottom: 20px;
	margin-top: 20px;
	border: 1px solid gray;
	border-radius: 10px;
	box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.1); 
	padding: 20px 50px;
	box-sizing: border-box;
	display: block;
}

.title, .pay_balance {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

/*---- 충전금액 영역 ----*/
.charge_amount input[type="text"] {
	width: 100%;
	padding: 5px 10px;
	font-size: 15px;
	box-sizing: border-box;
}

/*---- 충전하기버튼 ----*/
.btn_top {
	display: flex;
	justify-content: space-between;
	gap: 10px;
	margin-bottom: 20px;
	margin-top: 20px;
	
}

.charge_btn { 
	padding: 10px 20px; 
	border: none; 
	border-radius: 2px; 
	background-color: skyblue; 
	color: white; 
	cursor: pointer; 
	font-size: 14px;  
	width: 100%;
	margin-top: 20px;
} 

</style>
</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section>
		<div class="paymanage_container">
		<div class="paymanage_title">
			<h2>${sessionScope.sName} 님의 테크페이</h2>					
		</div>
        	<%-- 페이 비밀번호 정보 존재 여부에 따라 다른 링크 표시 --%>
			<c:choose>
				<c:when test="${empty sessionScope.pay_pwd }">
					<!-- 세션 객체의 "pay_pwd" 속성이 비어있을 경우 -->
					<!-- 페이 비밀번호 미설정 회원이므로 비밀번호 설정 영역 표시 -->
					<div class="pay_pwd">
						<div class="title">
							<h2>페이 비밀번호 설정</h2>					
						</div>
						<div class="pay_pwd_contents">
							<form action="PayPwdSet">
							 	테크페이 비밀번호 
								<input type="password" name="pay_pwd" placeholder="테크페이 비밀번호"><br>
								<input type="submit" value="비밀번호 설정">
							</form>
						</div>			
					</div>
				</c:when>
				<c:otherwise>
					<!-- 세션 객체의 "pay_pwd" 속성이 비어있지 않을 경우 -->
					<!-- 페이 비밀번호 설정된 회원이므로 비밀번호 변경 영역 표시 -->
					<div class="pay_pwd">
						<div class="title">
							<h2>페이 비밀번호 변경</h2>					
						</div>
						<div class="pay_pwd_contents">
							<form action="PayPwdSet">
								현재 비밀번호 
								<input type="password" placeholder="현재 비밀번호"><br>
								새 비밀번호
								<input type="password" name="pay_pwd" placeholder="새 비밀번호"><br>
								<input type="submit" value="비밀번호 변경">
							</form>
						</div>			
					</div>
				</c:otherwise>
			</c:choose>
		
			
	       <!-- 페이에 등록한 계좌 목록 표시  -->
	       <div class="account_list">
			  <div class="title">
				<h2>${sessionScope.sName} 님의 계좌 목록</h2>
			  </div>
	          <div class="account_list_contents">
		        <table border="1">
		        	<tr>
		        		<td>No.</td>
		        		<td>계좌</td>
		        		<td>예금주명</td>
		        		<td>더보기</td>
		        		<td>삭제하기</td>
		        	</tr>
		        	<c:forEach var="account" items="${accountList.res_list}">
		        		<tr>
		        			<td>1</td>
		        			<td><b>${account.account_alias}</b><br>
		        				${account.bank_name}<br>
		        				${account.account_num_masked}<br>
		        			</td>
		        			<td>${account.account_holder_name}</td>
		        			<td>
		        				<form action="AccountDetail" method="get">
		        					<input type="submit" value="더보기">
		        				</form>
		        			</td>
		        			<td>
		        				<input type="button" value="삭제" onclick="deleteAccount()">		        				
		        			</td>
		        		</tr>
		        	</c:forEach>
		        </table>
	          </div>
	       </div>
	       
        </div>
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>	
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>

</body>
</html>