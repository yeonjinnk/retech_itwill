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
<script src="${pageContext.request.servletContext.contextPath}/resources/js/techpay/techpay_manage.js"></script>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> <!-- Font Awesome 아이콘 라이브러리 로드 -->

<!-- 외부 CSS 파일(css/default.css) 연결 -->
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/techpay/techpay_manage.css" rel="stylesheet" type="text/css">

<%-- RSA 양방향 암호화 자바스크립트 라이브러리 추가 --%>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/rsa.js"></script>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/jsbn.js"></script>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/prng4.js"></script>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/rng.js"></script>

</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section>
		<div class="title-container">
			<h2 id="techpay_title">테크페이 | 관리</h2>
		</div>
		<div class="paymanage_container">
		<div class="paymanage_title">
	       <div class="pay_card">
			  <div class="title">
				<h2>
				<a href="SaleHistory" id="sName">
                        ${sessionScope.sName} 님
				</a></h2>	
			  </div>
			</div>					
		</div>
        	<%-- 페이 비밀번호 정보 존재 여부에 따라 다른 링크 표시 --%>
			<c:choose>
				<c:when test="${empty sessionScope.pay_pwd }">
					<!-- 세션 객체의 "pay_pwd" 속성이 비어있을 경우 -->
					<!-- 페이 비밀번호 미설정 회원이므로 비밀번호 설정 영역 표시 -->
					<div class="pay_pwd">
						<div class="title">
							<h2 id="pay_pwd_title">페이 비밀번호 설정</h2>					
						</div>
						<div class="pay_pwd_contents">
							<form action="PayPwdSet" id="payPwdSetForm">
							 	테크페이 비밀번호 
								<input type="password" name="pay_pwd" id="techpay_passwd" placeholder="숫자 6자리를 입력해주세요" onkeyup="validatepayPassword()" ><br>
								<span id="checkPasswdResult" class="check"></span><br>
							 	테크페이 비밀번호 확인
								<input type="password" id ="techpay_passwd2" placeholder="비밀번호를 다시 입력해주세요" onkeyup="checkSamePw()"><br>
				                <span id="checkPasswdResult2" class="check"></span><br>
								<input type="submit" value="비밀번호 변경">
								<input type="hidden" name="pay_pwd" id="hiddenTechPasswd">
                    			<input type="hidden" name="pay_pwd2" id="hiddenTechPasswd2">   								
							</form>
						</div>			
					</div>
				</c:when>
				<c:otherwise>
					<!-- 세션 객체의 "pay_pwd" 속성이 비어있지 않을 경우 -->
					<!-- 페이 비밀번호 설정된 회원이므로 비밀번호 변경 영역 표시 -->
					<div class="pay_pwd">
						<div class="title">
							<h2 id="pay_pwd_title">페이 비밀번호 변경</h2>					
						</div>
						<div class="pay_pwd_contents">
							<form action="PayPwdSet" id="payPwdSetForm">
								현재 테크페이 비밀번호 
								<input type="password" id="techpay_passwd_db" placeholder="현재 비밀번호"><br>
								
							 	새 테크페이 비밀번호 
								<input type="password" name="pay_pwd" id="techpay_passwd" placeholder="새 비밀번호" onkeyup="validatepayPassword()" ><br>
								<span id="checkPasswdResult" class="check"></span><br>
							 	새 테크페이 비밀번호 확인
								<input type="password" name="pay_pwd2" id ="techpay_passwd2" placeholder="새 비밀번호 확인" onkeyup="checkSamePw()"><br>
				                <span id="checkPasswdResult2" class="check"></span><br>			
								<input type="submit" value="비밀번호 설정">			
							</form>
						</div>			
					</div>
				</c:otherwise>
			</c:choose>
		
	       <!-- 페이에 등록한 계좌 목록 표시  -->
	       <div class="account_list">
			  <div class="title">
				<h2>계좌 목록</h2>
			  </div>
	          <div class="pay_account_list">
	    		<form action="AccountDetail" method="get" id="accountDetailForm">
			        <table border="1" class="account_list_table">
		        		<tr>
		        			<th>은행</th>
		        			<th>계좌별칭</th>
		        			<th>계좌번호</th>
		        			<th>예금주명</th>
		        			<th>상세정보</th>
		        		</tr>
			        	<%-- 페이 비밀번호 정보 존재 여부에 따라 다른 링크 표시 --%>
						<c:choose>
							<c:when test="${empty sessionScope.pay_pwd }">
					        	<c:forEach var="account" items="${accountList.res_list}"  begin="0" end="0">
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
				        					<input type="hidden" name="fintech_use_num" value="${account.fintech_use_num}">
				        					<input type="hidden" name=account_holder_name value="${account.account_holder_name}">
				        					<input type="hidden" name="account_num_masked" value="${account.account_num_masked}">
				        					<input type="button" class="acc_info_btn" value="계좌정보" >
					        			</td>
					        		</tr>
					        	</c:forEach>
							</c:when>
							<c:otherwise>
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
				        					<input type="hidden" name="fintech_use_num" value="${account.fintech_use_num}">
				        					<input type="hidden" name=account_holder_name value="${account.account_holder_name}">
				        					<input type="hidden" name="account_num_masked" value="${account.account_num_masked}">
				        					<input type="button" class="acc_info_btn" value="계좌정보" >
					        			</td>
					        		</tr>
						        </c:forEach>
							</c:otherwise>
						</c:choose>
			        </table>
		        </form>
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