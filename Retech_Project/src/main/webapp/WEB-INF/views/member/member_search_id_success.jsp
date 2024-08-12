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
		
		<article>
			<div align="center">
				<!-- id 알려주기 -->
				<span>회원님의 아이디는 <b>${member_id}</b> 입니다.</span>
			</div>
			
			<div align="center">
				<input type="button" value ="홈으로" onclick="location.href='./'">
				<input type="button" value ="로그인" onclick="location.href='MemberLogin'">
			</div>
		</article>
		
		<footer>
			<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
		</footer>
	</body>
</html>