<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/chat/report.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>
	<div class="modalOpen">
		<form action="">
			테크페이 비밀번호 입력
			<hr>
			비밀번호
			<input type="number" name="passwd" placeholder="입력해주세요"><br>
			
			
			
			
			
			<hr>
			<div class="modalBtn">
				<button type="submit" id="btnPay">결제하기</button>&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" id="btnDeliveryClose">닫기</button>
			</div>
		</form>
	</div>
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
			$("#btnDeliverySubmit").click(function(e) {
				console.log("테크페이(택배) 모달 제출 버튼 클릭됨!");
				e.preventDefault();
				$("#deliveryModal").hide();
			});
			
			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnDeliveryClose").click(function(e) {
				console.log("테크페이(택배) 모달 닫기 버튼 클릭됨!");
				e.preventDefault();
				$("#deliveryModal").hide();
			});
			
			//주소검색
			$("#btnSearchAddress").click(function() {
                new daum.Postcode({
                    oncomplete: function(data) { 
                        $("#postCode").val(data.zonecode);
                
                        let address = data.address;
                        if (data.buildingName !== '') {
                            address += " (" + data.buildingName + ")";
                        }
                
                        $("#address1").val(address);
                        $("#address2").focus();
                    }
                }).open();
            });
	  
	</script>
</body>
</html>