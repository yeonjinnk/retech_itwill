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
		<form action="DeliveryPay">
			거래하기 확인
			<hr>
			최종 거래금액 : 
			<input type="number" value="${newTrade.trade_amt}" disabled>원<br>
			배송지 입력<br>
			  <label for="postCode" class="title">주소</label>
	                <input type="text" name="buyer_postcode" id="postCode" placeholder="우편번호" required readonly>
	                <button type="button" id="btnSearchAddress">주소검색</button><br>
	                <input type="text" name="buyer_address1" id="address1" placeholder="기본주소" required readonly><br>
	                <input type="text" name="buyer_address2" id="address2" placeholder="상세주소">
	                
	                <input type="hidden" value="${sessionScope.sId}" name="buyer_id">
	                
					<input type="hidden" name="room_id" value="${param.room_id}">
					<input type="hidden" name="receiver_id" value="${param.receiver_id}">
					<input type="hidden" name="sender_id" value="${param.sender_id}">
					<input type="hidden" name="pd_idx" value="${param.pd_idx}">
					<input type="hidden" name="status" value="${param.status}">
			<hr>
			<div class="modalBtn">
				<button type="submit" id="btnDeliverySubmit">다음</button>&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" id="btnDeliveryClose">닫기</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
			/*모달창 내 제출 버튼 클릭 시 모달창 닫음*/
// 			$("#btnDeliverySubmit").click(function(e) {
// 				console.log("테크페이(택배) 모달 제출 버튼 클릭됨!");
// 				$("#deliveryModal").hide();
				
// 			});
			
			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnDeliveryClose").click(function(e) {
				console.log("테크페이(택배) 모달 닫기 버튼 클릭됨!");
// // 				e.preventDefault();
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