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
		신고하기
		<hr>
		<input type="radio" name="report" id="report"><label for="report">욕설 및 비방을 해요</label><br>
		<input type="radio" name="report" id="report2"><label for="report2">사기인 것 같아요</label><br>
		<input type="radio" name="report" id="report3"><label for="report3">거래 금지 품목을 팔아요</label><br>
		<input type="radio" name="report" id="report4"><label for="report4">상품 상태가 안 좋아요</label><br>
		<input type="radio" name="report" id="report5"><label for="report5">기타 부적절한 행위가 있어요</label><br>
		이미지는 최대 2장 등록 가능합니다.<br>
		<%-- 파일 첨부 형식은 input 태그의 type="file" 속성 활용 --%>
		<%-- 주의! 파일 업로드를 위해 form 태그 속성에 enctype 속성 필수!  --%>
		<input type="file" name="file1" id="img1" class="img" onchange="prevImg(this)" accept="image/*"> 
	<!-- 	accept 속성을 image/*로 지정할 경우 이미지파일만 업로드 가능 -->
		<input type="file" name="file2" id="img2" class="img" onchange="prevImg2(this)">
		<img id="prevImg" class="prevImg">
		<img id="prevImg2" class="prevImg">
		<br>
		<textarea rows="10" cols="40">내용을 입력하세요</textarea><br>
		<button type="submit" id="btnReportSubmit">신고하기</button>
		<button type="button" id="btnReportClose">닫기</button>
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
			$("#btnReportSubmit").click(function(e) {
				console.log("신고 제출하기 버튼 클릭됨!");
				e.preventDefault();
				$("#reportModal").hide();
			});
	  
			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnReportClose").click(function(e) {
				console.log("신고하기 모달 닫기 버튼 클릭됨!");
				e.preventDefault();
				$("#reportModal").hide();
			});
	  
	</script>
</body>
</html>