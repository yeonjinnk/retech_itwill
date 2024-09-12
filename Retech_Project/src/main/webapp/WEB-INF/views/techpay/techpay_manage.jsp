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
	max-width: 600px;
	margin: auto;
	margin-bottom: 40px;
	margin-top: 10px;
	border: 1px solid lightgray;
	border-radius: 5px;
/* 	box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.1);  */
	padding: 10px 20px 20px 20px;
	box-sizing: border-box;
	display: block;
}

.title, .pay_balance {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.pay_account_list, .account_list_table {
	margin-top: 10px;
}

/* 비밀번호 설정 폼 영역 */
.pay_pwd_contents {
    padding: 20px;
    background-color: #f9f9f9; /* 배경색 추가 */
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 효과 */
    max-width: 400px;
    margin: 0 auto;
}

.pay_pwd_contents h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333;
    font-weight: bold;
}

/* 입력 필드 스타일 */
.pay_pwd_contents input[type="password"] {
    width: 100%;
    padding: 12px 15px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    box-sizing: border-box;
    transition: border-color 0.3s ease;
}

.pay_pwd_contents input[type="password"]:focus {
    border-color: #007BFF; /* 포커스 시 테두리 색상 */
    outline: none;
}

/* 비밀번호 체크 결과 메시지 */
.check {
    font-size: 14px;
    margin-top: 5px;
}

.check.success {
    color: #28a745; /* 성공 시 초록색 */
}

.check.error {
    color: #dc3545; /* 오류 시 빨간색 */
}

/* 제출 버튼 스타일 */
.pay_pwd_contents input[type="submit"] {
    width: 100%;
    padding: 12px;
    background-color: #34495E;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 22px;
    margin-top: 0px;
    transition: background-color 0.3s ease;
}

.pay_pwd_contents input[type="submit"]:hover {
    background-color: #0064FF; /* 테마보다 약간 어두운 색상으로 변경 */
}


.acc_info_btn { 
	padding: 10px 20px;
	border: none;
	border-radius: 2px;
	background-color: skyblue;
	color: white;
	cursor: pointer;
	font-size: 10px;
	width: 100%;
} 


#techpay_passwd_db{
    margin-bottom: 30px; /* "새 테크페이 비밀번호" 위에 10px 여백 추가 */
}

.bank_symbol {
	margin-top: 5px 0px 5px 0px;
	width: 40px;
	height: 30px;
}

.pay_pwd_contents {
	font-size: 1.2em;
}

#sName {
	color: #0064FF;
	font-size: 28px;
	padding-top: 5px;
}

.account_list {
	margin-top: 10px;
}

/* 계좌 목록 컨테이너 */
.account_list {
    margin: 20px auto;
    max-width: 900px; /* 컨테이너 너비 설정 */
    padding: 20px;
    border-radius: 10px;
}

.account_list h2 {
    text-align: center;
    color: #34495E; /* 테마 색상 적용 */
    font-size: 1.5rem;
    margin-bottom: 20px;
    font-weight: bold;
}

/* 계좌 목록 테이블 스타일 */
.account_list_table {
    width: 100%;
    border-collapse: collapse; /* 테이블 경계선 겹침 제거 */
    margin-top: 5px;
    font-size: 18px;
}

.account_list_table th, .account_list_table td {
    padding: 5px;
    text-align: left;
    font-size: 14px;
    border-bottom: 1px solid #ddd;
    color: #555;
}

.account_list_table th {
    background-color: #f2f2f2; /* 테이블 헤더 배경색 */
    color: #333;
    font-weight: bold;
    text-align: center;
}

.account_list_table tr {
    transition: background-color 0.3s ease;
}


/* 은행 아이콘 이미지 */
.bank_symbol {
    display: block;
    margin: 0 auto; /* 이미지 가로 가운데 정렬 */
    width: 55px; /* 원하는 이미지 크기 */
    height: 40px;
    vertical-align: middle; /* 이미지 세로 가운데 정렬 */
}

/* 예금주명 열 가운데 정렬 */
.account_list_table td:nth-child(4) {
    text-align: center;
    padding-left: 0px;
    font-size: 20px;
}

.account_list_table td:nth-child(2) {
    font-size: 20px;
}

.account_list_table td:nth-child(1) {
    padding-left: 0px;
    padding-right: 0px;
}

/* 계좌 정보 버튼 스타일 */
.acc_info_btn {
    padding: 8px 12px;
    background-color: #34495E; /* 테마색 적용 */
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    transition: background-color 0.3s ease;
    width: 100%;
    text-align: center;
}

.acc_info_btn:hover {
    background-color: #2c3e50; /* 마우스 오버 시 색상 변경 */
}

.title img {
	margin-right: 10px;
}

#pay_pwd_title {
	padding-left: 20px;
}


.title-container {
	margin-top: 30px;
    display: flex;
    justify-content: flex-end; /* 오른쪽 정렬 */
    padding-right: 330px; /* 오른쪽 여백 추가 (원하는 대로 조정) */
	color: #34495E;
	font-size: 12px;
}

</style>
</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section>
		<div class="title-container">
			<h2 id="techpay_title">테크페이  > 테크페이 관리</h2>
		</div>
		<div class="paymanage_container">
		<div class="paymanage_title">
				
	       <div class="pay_card">
			  <div class="title">
				<h2>
				<a href="SaleHistory" id="sName">
                        ${sessionScope.sName} 님
				</a></h2>	
<%-- 				<img src="${pageContext.request.servletContext.contextPath}/resources/images/logo.png" height="50" width="100"> --%>
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