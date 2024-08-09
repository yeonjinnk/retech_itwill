<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
		<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<style>
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
			
			.tab{
				width: 720px;
				background-color: red;
				margin: 0 auto;
				text-align: center;
			}
			.tab > ul {
				display: flex;
				justify-content: space-between;
			}
			.tab > ul > li {
				width:50%;
				background-color: #ccc;
			}
			.tab > ul > li a {
				display: block;
				width: 100%;
			}
			
			article {
				width: 720px;
				margin: 0 auto;
			}
			
			article .content{
				width: 600px;
				padding-top: 30px;
			}
			
			article .content .info {
				width: 100%;
				display: flex;
			}
			
			article .content .info span {
				width: 30%;
				text-align: left;
			}
			
			article .content .info input {
				width: 50%;
			}
			
			article .content .info .auth_btn {
				width: 100px;
				margin-left: 10px;
			}
			
			article .content .auth {
				display: none;
			}
			
			article .id {
				display: none;
			}
		</style>
	</head>
	<body>
		<header>
			<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
		</header>
		
		<div class="logo">
			<a href="./" class="main_logo"><img src="resources/images/main_logo.png"></a>
		</div>
		
		<div class="tab">
			<ul>
				<li><a>아이디(이메일) 찾기</a></li>
				<li><a>비밀번호 찾기</a></li>
			</ul>
		</div>
		
		<article>
			<div align="center">
				<ul>
					<li>
						<!-- id 찾기 -->
						<div class="id content">
							<div class="info">
								<span>이름</span>
								<input type="text" name="name" placeholder="이름을 입력해주세요" required> <br>
							</div>
							
							<div class="info">
								<span>휴대폰 번호</span>
								<input type="text" name="phoneNum" placeholder="휴대폰 번호를 입력해주세요" required> <br>
								<input type="button" class="auth_btn" value ="인증번호 전송">
							</div>
							
							<!-- display: none; 상태, 인증번호 전송 버튼 클릭 시 표시됨 -->
							<div class="info auth">
								<span>인증번호</span>
								<input type="text" name="auth_num" placeholder="인증번호를 입력해주세요" required> <br>
								<input type="button" class="auth_btn" value ="확인">
							</div>
							
							<span>이메일, 비밀번호, 휴대폰 번호 등 입력 정보를 전부 다 모르실 경우 <br>
							고객센터 이메일 또는 ARS(1000-1000)로 문의주시기 바랍니다.
							</span>
						</div>
						
						<!-- pw 찾기 -->
						<div class="pw content">
							<div class="info">
								<span>이름</span>
								<input type="text" name="name" placeholder="이름을 입력해주세요" required> <br>
							</div>
							
							<div class="info">
								<span>아이디(이메일)</span>
								<input type="text" name="email" placeholder="아이디를 입력해주세요" required> <br>
								<input type="button" class="auth_btn" value ="인증번호 전송">
							</div>
							
							<!-- display: none; 상태, 인증번호 전송 버튼 클릭 시 표시됨 -->
							<div class="info auth">
								<span>인증번호</span>
								<input type="text" name="auth_num" placeholder="인증번호를 입력해주세요" required> <br>
								<input type="button" class="auth_btn" value ="확인">
							</div>
							
							<span>이메일, 비밀번호, 휴대폰 번호 등 입력 정보를 전부 다 모르실 경우 <br>
							고객센터 이메일 또는 ARS(1000-1000)로 문의주시기 바랍니다.
							</span>
						</div>
					</li>
				</ul>
			</div>
		</article>
		<footer>
			<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
		</footer>
	</body>
</html>