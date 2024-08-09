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
			.content {
				padding: 50px 0;
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
		</style>
	</head>
	<body>
		<header>
			<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
		</header>
		<article class="content inner">
			<div class="tab">
				<ul>
					<li class="tabMenu">이메일 입력</li>
					<li class="tabMenu">회원정보 입력</li>
					<li class="tabMenu on">가입 완료</li>
				</ul>
			</div>
			
			<h1>회원 가입이 완료되었습니다.</h1>
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