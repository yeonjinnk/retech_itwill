<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<link
	href="${pageContext.request.contextPath}/resources/css/default.css"
	rel="stylesheet" type="text/css">
<style type="text/css">
</style>
<script
	src="${pageContext.request.servletContext.contextPath}/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	
</script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>

	<article>
		<div class=""><h3>회원정보 관리</h3></div>
		<div class="">
			회원정보

			<form action="info" method="post">
				<label class="labelinput"> 선호지점 <select>
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
					<div class="">
						<span> 휴대폰번호 인증</span> <span> 인증회원</span>
					</div>
					<div class="">
						<span> 아이디(이메일)</span> <span> 아이디값불러올예정</span>
						<!--   db연결해서 아이디 값 가져올예정-->
					</div>
					<div class="">
						<span> 비밀번호</span> <input id="changebtnpasswd" type="button"
							value="변경">
					</div>
					<div class="">
						<span> 이름</span> <span> ${member.name} </span>
					</div>
					<div class="">
						<span> 생년월일</span> <span> ${dbmember.member_birth}</span>
					</div>
					<div class="">
						<span> 휴대폰번호</span> <span> 휴대폰번호값</span>
						<!--   db연결해서 아이디 값 가져올예정-->
						<input id="changebtnphone" type="button" value="변경">
					</div>
					<div class="h">
						<input type="checkbox" name="mck_check">다양한 혜택의 마케팅 동의<br>

					</div> <input type="submit" value="확인"> 회원 탈퇴<br> 탈퇴 신청시
					환불금액등의 확인 후 탈퇴처리가 진행되며 포인트, 등록한 관람권 등이 삭제되고 30일 이내 재가입이 불가하오니 신중히
					결정해주시기 바랍니다. <br> <input id="memberSecession" type="button"
					value="회원 탈퇴하기">



				</label>
			</form>
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>




















