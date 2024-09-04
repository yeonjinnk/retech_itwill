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

<%-- RSA 양방향 암호화 자바스크립트 라이브러리 추가 --%>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/rsa.js"></script>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/jsbn.js"></script>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/prng4.js"></script>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/rsa/rng.js"></script>

<script type="text/javascript">
<!-- $(function() { -->
//          $("#payPwdSetForm").submit(function() { 
<!--             // ================ RSA 알고리즘을 활용한 비대칭키 방식 암호화 ================ -->
//              let rsa = new RSAKey();
//             rsa.setPublic("${RSAModulus}", "${RSAExponent}");
//              $("#hiddenTechPasswd").val(rsa.encrypt($("#techpay_passwd").val())); // 아이디 암호화
//             $("#hiddenTechPasswd2").val(rsa.encrypt($("#techpay_passwd2").val())); // 패스워드 암호화		 
//  	}); 


</script>


<script>
	
    // 전체 폼 유효성 검사
    function validateForm() {
        let isValid = true;

        // 비밀번호 유효성 검사 및 비밀번호 확인 일치 여부 검사
        if (!validatepayPassword()) isValid = false;
        if (!checkSamePw()) isValid = false;

        return isValid;
    }

    // 테크페이 비밀번호 유효성 검사
    function validatepayPassword() {
        let passwd = $("#techpay_passwd").val(); 
        // 정규식을 통해 숫자 6자리인지 확인
        let isNumeric = /^\d{6}$/.test(passwd);  

        if (!isNumeric) {
            $("#checkPasswdResult").text("숫자 6자리여야 합니다.").addClass("error").removeClass("success");
            return false;
        } else {
            $("#checkPasswdResult").text("유효한 비밀번호입니다!").addClass("success").removeClass("error");
            return true;
        }
    }

    // 작성한 새 비밀번호와 비밀번호 입력 확인 값 일치 여부 검사
    function checkSamePw() {
        let passwd = $("#techpay_passwd").val();
        let passwd2 = $("#techpay_passwd2").val();
        if (passwd !== passwd2) {
            $("#checkPasswdResult2").text("비밀번호가 일치하지 않습니다.").addClass("error").removeClass("success");
            return false;
        } else {
            $("#checkPasswdResult2").text("비밀번호가 일치합니다.").addClass("success").removeClass("error");
            return true;
        }
    }

    // 현재 비밀번호가 세션의 비밀번호와 같은지 비교
    function validateCurrentPassword() {
        let enteredPassword = $("#techpay_passwd_db").val();  
        let sessionPassword = "${sessionScope.pay_pwd}";     

        if (enteredPassword !== sessionPassword) {
            return false;
        }
        return true;
    }

    $(document).ready(function() {
        // payPwdSetForm 제출 처리
        $('#payPwdSetForm').on('submit', function(e) {
        	
        	// 새 비밀번호 유효성 검사
            let isValid = validateForm(); 
         	// 현재 비밀번호 유효성 검사
            let isCurrentPwdValid = validateCurrentPassword(); 
            
            // 유효하지 않으면 폼 제출 막기
            if (!isCurrentPwdValid || !isValid) {
            	// 폼 제출 방지
                e.preventDefault(); 
				
            	// 유효하지 않은 상황에 맞는 alert창 띄우기
                if (!isCurrentPwdValid) {
                    alert("현재 비밀번호를 올바르게 입력해주세요!"); 
                    $("#techpay_passwd_db").focus(); 
                } else if (!isValid) {
                    alert("테크페이 비밀번호를 다시 확인해주세요!"); 
                }
            }
        });
        
        // 계좌정보 새 창으로 열기
        $('#accountDetailForm input[type="button"]').on('click', function(e) {
            // 기본 폼 제출 막기
            e.preventDefault();

            // 새 창 열기
            var newWindow = window.open('', 'AccountDetailWindow', 'width=800,height=600');

            // 새 창을 target으로 설정
            $('#accountDetailForm').attr('target', 'AccountDetailWindow');

            // 폼 제출
            $('#accountDetailForm').submit();
        });       
        
    });
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

/*---- 유효성 체크 영역 ----*/
.check {
    font-size: 13px;
    margin-top: 5px;
}

.check.success {
    color: #4CAF50;
}

.check.error {
    color: #e74c3c;
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
							<form action="PayPwdSet" id="payPwdSetForm">
							 	테크페이 비밀번호 
								<input type="password" name="pay_pwd" id="techpay_passwd" placeholder="숫자 6자리를 입력해주세요" onkeyup="validatepayPassword()" ><br>
								<span id="checkPasswdResult" class="check"></span><br>
							 	테크페이 비밀번호 확인
								<input type="password" id ="techpay_passwd2" placeholder="비밀번호를 다시 입력해주세요" onkeyup="checkSamePw()"><br>
				                <span id="checkPasswdResult2" class="check"></span><br>
								<input type="submit" value="비밀번호 설정">
								
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
							<h2>페이 비밀번호 변경</h2>					
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
				<h2>${sessionScope.sName} 님의 계좌 목록</h2>
			  </div>
	          <div class="account_list_contents">
		        <table border="1">
		        	<tr>
		        		<td>No.</td>
		        		<td>계좌</td>
		        		<td>예금주명</td>
		        		<td>상세정보</td>
<!-- 		        		<td>삭제하기</td> -->
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
		        				<form action="AccountDetail" method="get" id="accountDetailForm">
		        					<input type="hidden" name="fintech_use_num" value="${account.fintech_use_num}">
		        					<input type="hidden" name=account_holder_name value="${account.account_holder_name}">
		        					<input type="hidden" name="account_num_masked" value="${account.account_num_masked}">
		        					<input type="button" value="계좌정보" >
		        				</form>
		        			</td>
<!-- 		        			<td> -->
<!-- 		        				<input type="button" value="삭제" onclick="deleteAccount()">		        				 -->
<!-- 		        			</td> -->
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