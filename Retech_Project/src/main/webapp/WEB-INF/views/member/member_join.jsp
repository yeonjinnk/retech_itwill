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
			
			div ul li{
				display: inline-block;
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
				width: 150px;
			}
			
			
			.content .join {
				margin: 30px auto;
			}
			
			.content .join .join_email {
				margin-bottom: 30px; 
			}
			
			
			#member_id {
				width: 200px;			
			}
			
			
		</style>
		<script type="text/javascript">
			
			function checkId() {
				// 이메일 유효성 검사
				let email = $("#member_id").val();
				let regex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
				
				if(!regex.exec(email) || email == "") {
					alert("올바른 이메일이 아닙니다.");
					
					return false;
				} 
				
			}
		</script>
	</head>
	<body>
		<header>
			<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
		</header>

		<section align="center" class="content inner">
			<div class="tab">
				<ul>
					<li class="tabMenu on">이메일 입력</li>
					<li class="tabMenu">회원정보 입력</li>
					<li class="tabMenu">가입 완료</li>
				</ul>
			</div>
			
			<form class="join" action="MemberJoin" method="post">
				
				<div class="join_email">
					<ul>
						<li>이메일 주소로 가입</li>
						<li><input type="text" name="member_id" id="member_id" placeholder="이메일 주소를 입력해주세요." onblur="checkId()" ></li>
					</ul>
				</div>
				
				<input id="submit" type="submit" value="가입하기" >
			</form>
		</section>
				
		<footer>
			<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
		</footer>
	</body>
	
</html>















