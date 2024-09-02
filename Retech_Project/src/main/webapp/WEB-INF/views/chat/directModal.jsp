<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/chat/report.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body>
	<form action="">
		거래하기 확인
		<hr>
		정말 상대방과 거래하시겠습니까?<br>
		최종 거래금액을 입력하고 진행하실 거래방법을 눌러주세요.<br>
		최종 거래금액 : 
		<input type="number" placeholder="거래금액을 입력해주세요.">원<br>
		<input type="radio" name="trade" id="direct" value="direct">
			<label for="direct">직거래</label>
		<input type="radio" name="trade" id="delivery" value="delivery">
			<label for="delivery">택배거래</label>
		<hr>
		<button type="submit"  id="btnDirectSubmit">신고하기</button>
		<button type="button" id="btnDirectClose">닫기</button>
	</form>
	<script type="text/javascript">
		function readFile(input){
		  	let reader = new FileReader(); //파일 읽는 기능
		    
		    reader.onload = function(e){ //파일 읽었을 때 콜백 함수
		    	$('#prevImg').attr('src', e.target.result); //파일URL을 미리보기란 이미지 src 속성으로
		    }
		    reader.readAsDataURL(input.files[0]);
		  }
		  
		  $("#img1").change(function(){
		    readFile(this);
		  });
	  
			/*모달창 내 제출 버튼 클릭 시 모달창 닫음*/
			$("#btnDirectSubmit").click(function(e) {
				console.log("테크페이(직거래) 모달 제출 버튼 클릭됨!");
				e.preventDefault();
				$("#directModal").hide();
			});
			
			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnDirectClose").click(function(e) {
				console.log("테크페이(직거래) 모달 닫기 버튼 클릭됨!");
				e.preventDefault();
				$("#directModal").hide();
			});
	  
	</script>
</body>
</html>