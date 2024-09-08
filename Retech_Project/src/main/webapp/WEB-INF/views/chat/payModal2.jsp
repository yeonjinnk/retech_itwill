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
			결제 완료
			<hr>
			비밀번호
			<input type="number" name="passwd" placeholder="입력해주세요"><br>
			
			
			
			
			
			<hr>
			<div class="modalBtn">
				<button type="submit" id="btnPay2Submit">구매내역 보기</button>&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" id="btnPay2Close">닫기</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">

			/*모달창 내 제출 버튼 클릭 시 모달창 닫음*/
			$("#btnPay2Submit").click(function(e) {
				console.log("테크페이(택배) 모달 제출 버튼 클릭됨!");
// 				e.preventDefault();
				$("#payModal2").hide();
				$("#payModal3").show();
			});
			
			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnPay2Close").click(function(e) {
				console.log("테크페이(택배) 모달 닫기 버튼 클릭됨!");
				e.preventDefault();
				$("#payModal2").hide();
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