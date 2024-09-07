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
	<div class="modalOpen">
		<form action="SelectTrade">
			거래하기 확인
			<hr>
			정말 상대방과 거래하시겠습니까?<br>
			최종 거래금액을 입력하고 진행하실 거래방법을 눌러주세요.<br>
			최종 거래금액 : 
			<input type="number" id="trade_amt" name="trade_amt" min="0" placeholder="거래금액을 입력해주세요.">원<br>
			<input type="radio" name="trade_type" id="direct" value="2">
				<label for="direct">직거래</label>
			<input type="radio" name="trade_type" id="delivery" value="1">
				<label for="delivery">택배거래</label>
			<hr>
			<div class="modalBtn">
				<button type="submit" id="btnTradeSubmit" onclick="alert('입력하신 정보로 거래하시겠습니까?\n입력 후 수정은 불가합니다.')">거래하기</button>&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" id="btnTradeClose">닫기</button>
				
				<input type="hidden" name="room_id" value="${param.room_id}">
				<input type="hidden" name="receiver_id" value="${param.receiver_id}">
				<input type="hidden" name="sender_id" value="${param.sender_id}">
				<input type="hidden" name="pd_idx" value="${param.pd_idx}">
				<input type="hidden" name="status" value="${param.status}">
				
			</div>
		</form>
	</div>
	<script type="text/javascript">

			/*모달창 내 제출 버튼 클릭 시 모달창 닫음*/
			$("#btnTradeSubmit").click(function(e) {
				console.log("거래하기 모달 제출 버튼 클릭됨!");
// 				let trade_amt = $("#trade_amt").val();
// 				let tradeType = $("input[name='trade_type']:checked").val(); // 체크된 라디오 버튼의 값 가져오기
				 // 폼 제출
			    $(this).closest("form").submit();
				$("#tradeModal").hide();
			});

			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnTradeClose").click(function(e) {
				console.log("거래하기 모달 닫기 버튼 클릭됨!");
				e.preventDefault();
				$("#tradeModal").hide();
			});
	  
	</script>
</body>
</html>