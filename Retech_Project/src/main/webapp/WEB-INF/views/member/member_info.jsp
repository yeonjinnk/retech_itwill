<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
		<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<style>
			join_detail{
				display: inline-block;
			}
			
			.tab{
				width: 500px;
				margin: 0 auto;
			}
			
			.tab > ul > li {
				display: inline-block;
			}
			
			.join{
				width: 500px;
				background-color: #eee;
				margin: 0 auto;
			}
			
			.social_btn{
				width: 150px;
			}
		
			#submit {
				width: 150px;
			}
			.logo {
				width: 100px;
				margin: 0 auto;
			}
			
			.logo .main_logo {
				width: 100%;
			}
			
			.logo .main_logo img {
				width: 100%;
			}
		</style>
			
		<script type="text/javascript">
		function checkPasswd() {
			// 패스워드 입력값 가져오기
			let passwd = $("#member_pw").val();
			
			// 패스워드 검증 결과 메세지 출력에 사용될 변수 선언
			let msg = "";
			let color = "";
			let bgColor = "";
			
			// 1) 패스워드 길이 및 종류 검증 : 영문자(대소문자), 숫자, 특수문자(!@#$%) 조합 8 ~ 16자리
			let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
			
			if(lengthRegex.exec(passwd)) { // 패스워드 길이 검사 적합
				// 2) 패스워드 복잡도(안전도) 검사
				//    => 영문 대문자 or 소문자 or 숫자 or 특수문자(!@#$%) 중 최소 2가지 이상 조합
				//    => 단, 부분 검사를 수행하므로 시작(^)과 끝($) 기호는 제외하고 표현식 작성
				// 2-1) 영문자 대문자 검사 규칙
				let engUpperRegex = /[A-Z]/;
				// 2-2) 영문자 소문자 검사 규칙
				let engLowerRegex = /[a-z]/;
				// 2-3) 숫자 검사 규칙
				let numRegex = /\d/; // /[0-9]/ 동일
				// 2-4) 특수문자(!@#$%) 검사 규칙
				let specRegex = /[!@#$%]/;
				
				// 각 규칙에 대한 부분 검사를 통해 일치하는 항목 카운팅 변수 선언
				// => 일치하는 규칙마다 +1 처리
				let count = 0;
				
				if(engUpperRegex.exec(passwd)) { count++; } // 대문자 포함
				if(engLowerRegex.exec(passwd)) { count++; } // 소문자 포함
				if(numRegex.exec(passwd)) { count++; } // 숫자 포함
				if(specRegex.exec(passwd)) { count++; } // 특수문자(!@#$%) 포함
				
				// 복잡도 검사 결과 판별하여 id 선택자 checkPasswdComplexResult 영역에 출력
				// 4점 : 안전(초록색 - green)
				// 3점 : 보통(주황색 - orange)
				// 2점 : 위험(빨간색 - red)
				// 1점 이하 : id 선택자 "checkPasswdResult" 에 사용불가 메세지 출력(빨간색)
				let complexityMsg = "";
				let complexityColor = "";
				
				if(count == 4) {
					complexityMsg = "안전";
					complexityColor = "green";
				} else if(count == 3) {
					complexityMsg = "보통";
					complexityColor = "orange";
				} else if(count == 2) {
					complexityMsg = "위험";
					complexityColor = "red";
				} else if(count <= 1) {
					msg = "영문자, 숫자, 특수문자(!@#$%) 조합 8 ~ 16글자";
					color = "red";
					bgColor = "lightpink";
					checkPasswdResult = false; // 패스워드 검사 적합 여부 false(부적합) 값 저장
				}

				if(count >= 2) {
					$("#checkPasswdComplexResult").text(complexityMsg);
					$("#checkPasswdComplexResult").css("color", complexityColor);
					checkPasswdResult = true; // 패스워드 검사 적합 여부 true(적합) 값 저장
				}
				
			} else { // 패스워드 길이 검사 부적합
				msg = "영문자, 숫자, 특수문자(!@#$%) 조합 8 ~ 16글자";
				color = "red";
				bgColor = "lightpink";
				
				checkPasswdResult = false; // 패스워드 검사 적합 여부 false(부적합) 값 저장
			}
			
			$("#checkPasswdResult").text(msg);
			$("#checkPasswdResult").css("color", color);
			$("#member_pw").css("background", bgColor);
		}
			
		
		
			function checkSamePw() {
		        let passwd = $("#member_pw").val();
		        let passwd2 = $("#member_pw2").val();
		        
		        if(passwd == passwd2) {
		            $("#checkPasswdResult2").text("비밀번호가 일치합니다.");
		            $("#checkPasswdResult2").css("color", "blue");
		        } else {
		            $("#checkPasswdResult2").text("비밀번호가 일치하지 않습니다.");
		            $("#checkPasswdResult2").css("color", "red");
		            $("#member_pw2").focus();
		        }
		    }
			
			function checkName(){
				let regex = /^[가-힣]{2,6}$/;
				let name = $("#member_name").val();
				
				if(!regex.exec(name)){
					$("#checkNameResult").text("한글로 이름을 입력해주세요.");
					$("#checkNameResult").css("color", "red");
					$("#member_name").focus();
				} else {
					$("#checkNameResult").text("");
				}
			}
			
			function checkBirth(){
				let regex = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
				let birth = $("#member_birth").val();	
				
				if(!regex.exec(birth)){
					$("#checkBirthResult").text("0000-00-00의 형식으로 입력해주세요.");
					$("#checkBirthResult").css("color", "red");
					$("#member_birth").focus();
				} else {
					$("#checkBirthResult").text("");
				}
			}
			
			function checkPhoneNum(){
				let regex = /^[0-9]{11}$/;
				let phone = $("#member_phonenumber").val();	
				
				if(!regex.exec(phone)){
					$("#checkPhoneResult").text("숫자만 입력해주세요.");
					$("#checkPhoneResult").css("color", "red");
					$("#member_phonenumber").focus();
				} else {
					$("#checkPhoneResult").text("");
				}
			}
			
		</script>
	</head>
	<body>
		<header>
			<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
		</header>
		
		<div class="logo">
			<a href="./" class="main_logo">
				<img src="resources/images/main_logo.png">
			</a>
		</div>

		<section>
			<div class="tab">
				<ul>
					<li>이메일 입력(소셜 가입)</li>
					<li>회원정보 입력</li>
					<li>가입 완료</li>
				</ul>
			</div>
			
			<form class="join" name="Modify" action="MemberModify" method="post">
				<div class="join_detail">
					<span>선호지점</span>
					<select name="preference_theater">
						<option>신도림</option>
						<option>청라</option>
						<option>동탄</option>
						<option>남양주다산</option>
						<option>경주보문</option>
						<option>구미봉곡</option>
						<option>천안불당</option>
						<option>대구이시아</option>
						<option>보은</option>
						<option>칠곡호이</option>
						<option>영덕예주</option>
					</select>
				</div>
				
				<div class="join_detail">
					<span>아이디(이메일)</span>
					<input type="text" name="member_id" value="${member.member_id}" readonly required>
				</div>
				<div class="join_detail">
					<span>기존 비밀번호</span>
					<input type="password" name="member_oldpw" id="member_oldpw" placeholder="영문, 숫자, 특수문자 중 2개 조합 8자 이상" onblur="checkPasswd()" required> <!-- / ^[A-Za-z0-9!@#$%^&*_-+=]{8,}$/ -->
				</div>
				<div class="join_detail">
					<span>새 비밀번호</span>
					<input type="password" name="member_pw" id="member_pw" placeholder="영문, 숫자, 특수문자 중 2개 조합 8자 이상" onblur="checkPasswd()">
					<span id="checkPasswdResult"></span> <!-- / ^[A-Za-z0-9!@#$%^&*_-+=]{8,}$/ -->
				</div>
				<div class="join_detail">
					<span>새 비밀번호 확인</span>
					<input type="password" name="member_pw2" id="member_pw2" placeholder="위에 입력한 비밀번호를 다시 입력해주세요" required onblur="checkSamePw()">
					<span id="checkPasswdResult2"></span>
				</div>
				<div class="join_detail">
					<span>이름</span>
					<input type="text" name="member_name" id="member_name" value="${member.member_name }" readonly required>
				</div>
				<div class="join_detail">
					<span>생년월일</span>
					<input type="text" name="member_birth" id="member_birth" value="${member.member_birth }" readonly required>
				</div>
				<div class="join_detail">
					<span>휴대폰번호</span>
					<input type="text" name="member_phonenumber" id="member_phonenumber" value="${member.member_phone}" required onblur="checkPhoneNum()">
					<span id="checkPhoneResult"></span>
<!-- 					<a href="#">인증번호 받기</a> --> <!-- 구현 배우면 추가 -->
				</div>
<!-- 				<div class="join_detail"> -->
<!-- 					<span>인증번호 입력</span> -->
<!-- 					<input type="text" placeholder="인증번호 입력"> 구현 배우면 추가 -->
<!-- 					<span>제한시간 3분</span> -->
<!-- 				</div> -->
				
 				<!-- 약관동의 -->
				<div class="join_detail">
					<input type="checkbox" name="member_agree_marketing"> 다양한 혜택의 마케팅 동의
				</div>
				<input type="submit" value="정보수정">
				<input type="reset" value="초기화">
				<input type="button" value="돌아가기" onclick="history.back()">
				<br>
				<input type="button" value="회원탈퇴" onclick="location.href='MemberWithdraw'">
			</form>
		</section>
	
		<footer>
			<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
		</footer>
	</body>
</html>