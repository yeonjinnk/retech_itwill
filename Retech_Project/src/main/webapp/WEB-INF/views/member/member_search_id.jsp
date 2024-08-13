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
				margin: 0 auto;
				text-align: center;
			}
			.tab > ul {
				display: flex;
				justify-content: space-between;
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
			
			article {
				width: 720px;
				margin: 0 auto;
			}
			
			article .search{
				width: 400px;
				padding-top: 30px;
			}
			
			article .search .info {
				width: 100%;
				display: flex;
				justify-content: center;
			}
			
			article .search .info span {
				width: 40%;
				text-align: left;
			}
			
			article .search .info input {
				width: 60%;
			}
			
			
/* 			article .search .info .auth_btn { */
/* 				width: 100px; */
/* 				margin-left: 10px; */
/* 			} */
			
			article .alert {
				display: block;
				width: 100%;
			}
			
			article .search .submitBtn {
				width: 100%;
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
				<li class="tabMenu on"><a href="MemberSearchId">아이디 찾기</a></li>
				<li class="tabMenu"><a href="MemberSearchPw">비밀번호 찾기</a></li>
			</ul>
		</div>
		
		<article>
			<div align="center">
				<!-- id 찾기 -->
				<h4>등록한 정보로 아이디 찾기</h4>
				<form class="search" name="searchIdForm" action="SearchIdPro" method="post">
					<div class="info">
						<span>이름</span>
						<input type="text" name="member_name" placeholder="이름을 입력해주세요" required> <br>
					</div>
					
					<div class="info">
						<span>생년월일</span>
						<input type="text" name="member_birth" placeholder="예) 1999-01-01" required> <br>
					</div>
					
					<div class="info">
						<span>휴대폰번호</span>
						<input type="text" name="member_phone" placeholder=" - 없이 숫자만 입력해주세요." required> <br>
					</div>
					
					<input type="submit" value="아이디찾기" class="submitBtn">
					
				</form>
				
				<span class="alert">이메일, 비밀번호, 휴대폰 번호 등 입력 정보를 <br>전부 다 모르실 경우
				고객센터 이메일 <br> 또는 ARS(1000-1000)로 문의주시기 바랍니다.
				</span>
			</div>
		</article>
		<footer>
			<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
		</footer>
	</body>
</html>