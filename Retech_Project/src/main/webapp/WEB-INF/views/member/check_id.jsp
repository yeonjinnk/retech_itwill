<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
		<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
		<script>
			$(function() { // 문서 로딩하고 바로 실행되도록 익명함수로. 
				$("#btnUseId").click(function() { // btnUseId 버튼 클릭했을 때.
					let id = $("#id").val();
					if(id == "") { // 아이디 미입력
						alert("아이디 입력 필수 !");
						$("#id").focus();
					} else { // 아이디 입력
						window.opener.document.joinForm.id.value = id; // 자식창에서 부모창 요소에 접근 가능.
						// window.opener 까지하면 부모창 접근
						close();
					}
				});
			});
		
		</script>
	</head>
	<body>
		<article>
			<h1>아이디 중복 검사</h1>
			
			<div align="center">
				<form action="MemberCheckIdPro.me">
					<input type="text" name="id" id="id" placeholder="4 ~ 16자 영문자, 숫자" required maxlength="16">
					<input type="submit" value="ID 중복 확인"> 
				
				</form>
				<hr>
				<div id="resultArea">
					<input type="button" value="ID 사용하기" id="btnUseId">
				</div>
			</div>
		</article>
	</body>
</html>