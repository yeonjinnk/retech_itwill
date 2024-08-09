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
			.content {
				padding: 50px 0;
			}
		
			.content .join {
				width: 350px;
				margin: 0 auto;
			}
			
			.content .join_detail {
				padding: 10px 0 ;
			}
			
			.content .join_detail .title {
				display: block;
				width: 150px;
				margin-bottom: 7px;
			}
			.content .join_detail .detail2 {
				width: 100%;
			}
			
			.content .join_detail .check {
				width: 150px;
				font-size: 13px; 
			}
			
			.tab{
				width: 720px;
				margin: 0 auto;
				text-align: center;
			}
			.tab > ul {
				display: flex;
				justify-content: space-between;
				height: 40px;
				line-height: 2.5;
			}
			.tab > ul > li {
				width:50%;
				background-color: #eee;
				
			}
			.tab > ul > li a {
				display: block;
				width: 100%;
			}
			
			.tab > ul > li.on {
				background-color: #ccc;
				color: rgb(211, 84, 0);
				font-weight: bold;
			}
			
			.social_btn{
				width: 150px;
			}
		
			#submit {
				width: 100%;
			}
			
			input, select {
				height: 30px;
			}
		</style>
			
		<script type="text/javascript">
			
			// 비밀번호 정규표현식 사용 필요 !!!!
			
		
			function checkSamePw() {
		        let passwd = $("#member_pw").val();
		        let passwd2 = $("#member_pw2").val();
		        
		        if(passwd == passwd2) {
		            $("#checkPasswdResult").text("비밀번호가 일치합니다.");
		            $("#checkPasswdResult").css("color", "blue");
		        } else {
		            $("#checkPasswdResult").text("비밀번호가 일치하지 않습니다.");
		            $("#checkPasswdResult").css("color", "red");
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
		

		<section class="content inner">
			
			<div class="tab">
				<ul>
					<li class="tabMenu">이메일 입력</li>
					<li class="tabMenu on">회원정보 입력</li>
					<li class="tabMenu">가입 완료</li>
				</ul>
			</div>
			
			<form class="join" name="joinForm" action="MemberJoinForm" method="post">
				<div class="join_detail">
					<span class="title">선호지점</span>
					<select name="preference_theater" class="detail2">
						<option selected>신도림</option>
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
					<span class="title">아이디(이메일)</span>
					<input type="text" class="detail2" name="member_id" value="${param.member_id}" readonly>
				</div>
				<div class="join_detail">
					<span class="title">비밀번호</span>
					<input type="password" class="detail2" name="member_pw" id="member_pw" placeholder="영문, 숫자, 특수문자 중 2개 조합 8자 이상" required onblur="emptyPw()"> <!-- / ^[A-Za-z0-9!@#$%^&*_-+=]{8,}$/ -->
				</div>
				<div class="join_detail">
					<span class="title">비밀번호 확인</span>
					<input type="password" class="detail2" name="member_pw2" id="member_pw2" placeholder="위에 입력한 비밀번호를 다시 입력해주세요" required
						onblur="checkSamePw()"> <br>
					<span id="checkPasswdResult" class="check"></span>
				</div>
				<div class="join_detail">
					<span class="title">이름</span>
					<input type="text" class="detail2" name="member_name" id="member_name" placeholder="실명을 입력해주세요" required onblur="checkName()"><br>
					<span id="checkNameResult" class="check"></span>
				</div>
				<div class="join_detail">
					<span class="title">생년월일</span>
					<input type="text" class="detail2" name="member_birth" id="member_birth" placeholder="예) 1999-01-01" required onblur="checkBirth()"><br>
					<span id="checkBirthResult" class="check"></span>
				</div>
				<div class="join_detail">
					<span class="title">휴대폰번호</span>
					<input type="text" class="detail2" name="member_phonenumber" id="member_phonenumber" placeholder="- 없이 숫자만 입력해주세요." required onblur="checkPhoneNum()"> <br>
					<span id="checkPhoneResult" class="check"></span>
<!-- 					<a href="#">인증번호 받기</a> --> <!-- 구현 배우면 추가 -->
				</div>
<!-- 				<div class="join_detail"> -->
<!-- 					<span>인증번호 입력</span> -->
<!-- 					<input type="text" placeholder="인증번호 입력"> 구현 배우면 추가 -->
<!-- 					<span>제한시간 3분</span> -->
<!-- 				</div> -->
				
 				<!-- 약관동의 -->
				<div class="join_detail">
					<input type="checkbox" name="member_agree_marketing" value="1"> 다양한 혜택의 마케팅 동의
				</div>
				<input id="submit" class="submit" type="submit" value="가입하기">
			</form>
		</section>
	
		<footer>
			<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
		</footer>
	</body>

</html>