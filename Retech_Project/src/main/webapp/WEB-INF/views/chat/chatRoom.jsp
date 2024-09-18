<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/chat/chatRoom.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
/*=======================바뀐부분시작==============================*/
 
    $(document).ready(function() {
        $('#btnPayNext').click(function() {
            // Redirect to the TechPayments servlet
            window.location.href = 'TechPayments?trade_idx=' + ${newTrade.trade_idx};
        });
        
        $('#btnPayClose').click(function() {
            // Close the modal
            $('#payModal').hide();
        });
    });

    $(document).ready(function() {
        $('#btnPayNext-direct').click(function() {
            // Redirect to the TechPayments servlet
            window.location.href = 'TechPayments?trade_idx=' + ${newTrade.trade_idx};
        });
        
        $('#btnPayClose').click(function() {
            // Close the modal
            $('#payModal').hide();
        });
    });
    
/*========================바뀐부분끝=======================*/

</script>
</head>
<body>
	<script type="text/javascript">
		let pd_idx2 = "${param.pd_idx}";
		$(function() {
		console.log("pd_idx : " + pd_idx2)
			/*모달창 기본 숨김*/
			$("#tradeModal").hide();
			$("#deliveryModal").hide();
			
			
			$("#directModal").hide();
			$("#reportModal").hide();
			$("#payModal").hide();
			$("#payModal2").hide();
			$("#payModal3").hide();
			
			
			$("#payModal-direct").hide();
			$("#payModal2-direct").hide();
			$("#payModal3-direct").hide();
			
			/*거래하기 버튼 클릭 시 모달창 띄움*/
			$(".btnTrade").click(function() {
				console.log("거래하기 버튼 클릭됨!");
				$("#tradeModal").show();
				console.log("거래하기 모달 띄움!");
			});
			
			/*테크페이(택배) 버튼 클릭 시 모달창 띄움*/
			$("#btnDelivery").click(function() {
				console.log("테크페이(택배) 버튼 클릭됨!");
				$("#deliveryModal").show();
				console.log("테크페이(택배) 모달 띄움!");
			});
			
			
			/*========================================================*/
			/*테크페이(택배) 모달창*/
			
			/*모달창 내 제출 버튼 클릭 시 모달창 닫음*/
			$("#btnDeliveryNext").click(function(e) {
				console.log("테크페이(택배) 모달 제출 버튼 클릭됨!");
				$("#payModal0").hide();
				$("#payModal").show();
			});
			
			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnDeliveryClose").click(function(e) {
				console.log("테크페이(택배) 모달 닫기 버튼 클릭됨!");
// // 				e.preventDefault();
				$("#deliveryModal").hide();
			});
			
			/*========================================================*/
			/*테크페이 결제 모달창*/
			

			
			
			/*=======================원래부분시작==============================*/
			
			/*모달창 내 제출 버튼 클릭 시 모달창 닫음*/
			$("#btnPayNext").click(function(e) {
				console.log("테크페이(택배) 모달 제출 버튼 클릭됨!");
// 				e.preventDefault();
				$("#payModal").hide();
				$("#payModal2").show();
			});
			
			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnPayClose").click(function(e) {
				console.log("테크페이(택배) 모달 닫기 버튼 클릭됨!");
				e.preventDefault();
				$("#payModal").hide();
			});
			
			/*========================원래부분끝=======================*/
			
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
			
			/*========================================================*/
			/*테크페이 비밀번호 입력 모달창*/
			
			/*모달창 내 제출 버튼 클릭 시 모달창 닫음*/
			$("#btnPay2Next").click(function(e) {
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
			
			/*========================================================*/
			/*테크페이 결제완료 모달창*/
			/*모달창 내 제출 버튼 클릭 시 모달창 닫음*/
			$("#btnPay3Submit").click(function(e) {
				console.log("테크페이(택배) 모달 제출 버튼 클릭됨!");
// 				e.preventDefault();
				$("#payModal3").hide();
// 				$("#payCompletedModal").show();
			});
			
			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnPay3Close").click(function(e) {
				console.log("테크페이(택배) 모달 닫기 버튼 클릭됨!");
				e.preventDefault();
				$("#payModal3").hide();
			});
			
			
			
			
			
			
			
			/*테크페이(직거래) 버튼 클릭 시 모달창 띄움*/
			$("#btnDirect").click(function() {
				console.log("테크페이(직거래) 버튼 클릭됨!");
				$("#directModal").show();
				$("#payModal-direct").show();
				console.log("#payModal-direct 하이드인지 쇼인지 : " + $('#payModal-direct').is(':visible'));
				console.log("테크페이(직거래) 모달 띄움!");
			});
			
			/* --------------------------------------------------- */
			$("#btnPayNext-direct").click(function(e) {
				console.log("테크페이(택배) 모달 제출 버튼 클릭됨!");
// 				e.preventDefault();
				$("#payModal-direct").hide();
				$("#payModal2-direct").show();
			});
			
			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnPayClose-direct").click(function(e) {
				console.log("테크페이(택배) 모달 닫기 버튼 클릭됨!");
				e.preventDefault();
				$("#payModal-direct").hide();
			});
			/* --------------------------------------------------- */
			$("#btnPay2Next-direct").click(function(e) {
				console.log("테크페이(택배) 모달 제출 버튼 클릭됨!");
// 				e.preventDefault();
				$("#payModal2-direct").hide();
				$("#payModal3-direct").show();
			});
			
			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnPay2Close-direct").click(function(e) {
				console.log("테크페이(택배) 모달 닫기 버튼 클릭됨!");
				e.preventDefault();
				$("#payModal2-direct").hide();
			});
			
			/* --------------------------------------------------- */
			$("#btnPay3Submit-direct").click(function(e) {
				console.log("테크페이(택배) 모달 제출 버튼 클릭됨!");
// 				e.preventDefault();
				$("#payModal3-direct").hide();
			});
			
			/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnPay3Close-direct").click(function(e) {
				console.log("테크페이(택배) 모달 닫기 버튼 클릭됨!");
				e.preventDefault();
				$("#payModal3-direct").hide();
			});
			
			
			
			
			
			/*모달창 내 제출 버튼 클릭 시 모달창 닫음*/
// 			$("#btnDeliverySubmit").click(function(e) {
// 				console.log("테크페이(택배) 모달 제출 버튼 클릭됨!");
// 				$("#deliveryModal").hide();
// 				$("#payModal").show();
				
// 			});
			/*신고하기 아이콘 클릭 시 모달창 띄움*/
			$("#btnReport").click(function() {
				console.log("신고하기 버튼 클릭됨!");
				$("#reportModal").show();
				console.log("신고하기 모달 띄움!");
			});
			
			
			
			/*등록한 이미지 미리보기1*/
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
		  
			/*등록한 이미지 미리보기2*/
			function readFile2(input){
			  	let reader = new FileReader(); //파일 읽는 기능
			    
			    reader.onload = function(e){ //파일 읽었을 때 콜백 함수
			    	$('#prevImg2').attr('src', e.target.result); //파일URL을 미리보기란 이미지 src 속성으로
			    }
			    reader.readAsDataURL(input.files[0]);
			  }
			  
			  $("#img2").change(function(){
			    readFile2(this);
			  });
		  

				/*모달창 내 제출 버튼 클릭 시 모달창 닫음*/
				$("#btnReportSubmit").click(function(e) {
					console.log("신고 제출하기 버튼 클릭됨!");
//	 				e.preventDefault();
					$("#reportModal").hide();
				});
		  
				/*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
				$("#btnReportClose").click(function(e) {
					console.log("신고하기 모달 닫기 버튼 클릭됨!");
					e.preventDefault();
					$("#reportModal").hide();
				});
			
		});
	</script>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<%-- 현재 위치는 컨텍스트 루트(/MVC_Board = webapp) 이므로 inc 디렉토리의 top.jsp 지정 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<!-- 상단 -->
	<div class="chatRoomSubject" id="chatRoomSubject">
		<div class="subjectText">
		
		</div>
		<div class="top">
			<div class="art_firstRow">
				<div class="product_photo co01"><br><br>
					<c:choose>
						<c:when test="${not empty product.pd_image1}">
	                    	<img src="${pageContext.request.contextPath}/resources/img/main/${productInfo.pd_image1}" class="product-image"/>
	                    </c:when>
	                    <c:otherwise>
	                    	<img src="https://st.depositphotos.com/52259964/54244/v/450/depositphotos_542449510-stock-illustration-isometric-laptop-linear-icon-empty.jpg" class="product-image"/>
	                    </c:otherwise>
					</c:choose>
				</div>
				<div class="co02">
					<div class="co02-1">${productInfo.pd_status}</div><br>
					<div class="co02-2">${productInfo.pd_subject}</div><br>
					<div class="co02-2\3">
					<fmt:formatNumber pattern="#,###" value="${productInfo.pd_price }" />원</div>
				</div>
			</div>
			<div class="btnClose">
				<img src="${pageContext.request.contextPath}/resources/images/x_icon.png" id="closeChat" >
			</div>
		</div>
		<div class="art_secondRow">
			<div class="left">
				<c:choose>
					<c:when test="${sessionScope.sId eq productInfo.member_id and newTrade.trade_status == 1}">
						<button class="btnTrade" disabled><span>거래하기</span></button>
					</c:when>
					<c:when test="${sessionScope.sId eq productInfo.member_id and newTrade == null}">
						<button class="btnTrade"><span>거래하기</span></button>
					</c:when>
					<c:when test="${sessionScope.sId eq productInfo.member_id}">
<!-- 						<button class="btnTrade" disabled><span>거래하기</span></button> -->
						<button class="btnTrade" ><span>거래하기</span></button>
					</c:when>
					<c:when test="${newTrade.trade_type eq 1}">
						<button id="btnDelivery"><span>테크페이(택배)</span></button>
					</c:when>
					<c:when test="${newTrade.trade_type eq 2}">
						<button id="btnDirect"><span>테크페이(직거래)</span></button>
					</c:when>
				</c:choose>
			</div>
			<div class="right">
				<!-- 신고하기 버튼 -->
				<img src="${pageContext.request.contextPath}/resources/images/chat_report_img.png" id="btnReport" >
				<span id="reportTitle">신고하기</span>
			</div>
		</div>
		<!-- 닫기 x 아이콘 -->
		
		<!-- 모달창 영역 -->
		<div class="modalArea">
			<!-- 판매자 '거래하기' -->
			<div id="tradeModal" class="modal">
				<jsp:include page="/WEB-INF/views/chat/tradeModal.jsp"></jsp:include>
			</div>
			
			
<!-- 			<div class="modalOpEen"> -->
				<!-- 구매자 '테크페이(택배)' -->
				<div id="deliveryModal">
					<form action="DeliveryPay">
						<div id="payModal0" class="modal">
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
					                <input type="hidden" value="${newTrade.trade_idx}" name="trade_idx">
					                
									<input type="hidden" name="room_id" value="${param.room_id}">
									<input type="hidden" name="receiver_id" value="${param.receiver_id}">
									<input type="hidden" name="sender_id" value="${param.sender_id}">
									<input type="hidden" name="pd_idx" value="${param.pd_idx}">
									<input type="hidden" name="status" value="${param.status}">
							<hr>
							<div class="modalBtn">
								<button type="button" id="btnDeliveryNext">다음</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" id="btnDeliveryClose">닫기</button>
							</div>
						</div>
						<!-- ======================================================================================= -->
						<div id="payModal" class="modal">
							테크페이 결제
							<hr>
							최종 거래금액 : 
							<input type="number" value="${newTrade.trade_amt}" disabled>원<br>
							<hr>
							<div class="modalBtn">
				                <input type="hidden" value="${newTrade.trade_idx}" name="trade_idx">
					<!-- 		<button type="submit" id="btnAdd">충전하기</button>&nbsp;&nbsp;&nbsp;&nbsp; -->
								<button type="button" id="btnPayNext">다음</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" id="btnPayClose">닫기</button>
							</div>
						</div>
						<!-- ======================================================================================= -->
						<div id="payModal2" class="modal">
							결제 완료
							<hr>
							비밀번호
							<input type="number" name="passwd" placeholder="입력해주세요"><br>
								
							<hr>
							<div class="modalBtn">
								<button type="button" id="btnPay2Next">결제하기</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" id="btnPay2Close">닫기</button>
							</div>
						</div>
						<!-- ======================================================================================= -->
						<div id="payModal3" class="modal">
							결제 완료
							<hr>
							${newTrade.trade_amt}원 결제 완료
								
							<hr>
							<div class="modalBtn">
								<button type="submit" id="btnPay3Submit">구매내역 보기</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" id="btnPay3Close">닫기</button>
							</div>
						</div>
					</form>
				</div>
<!-- 			</div> -->
							
		<!-- ===================================================================================================== -->
<!-- 			<div class="modalOpen"> -->
				<!-- 구매자 '테크페이(직거래)' -->
				<div id="directModal">
					<form action="directPay">
						<div id="payModal-direct" class="modal">
							테크페이 결제
							<hr>
							최종 거래금액 : 
							<input type="number" value="${newTrade.trade_amt}" disabled>원<br>
							<hr>
							<div class="modalBtn">
				                <input type="hidden" value="${newTrade.trade_idx}" name="trade_idx">
					<!-- 		<button type="submit" id="btnAdd">충전하기</button>&nbsp;&nbsp;&nbsp;&nbsp; -->
								<button type="button" id="btnPayNext-direct">다음</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" id="btnPayClose-direct">닫기</button>
							</div>
						</div>
						<!-- ======================================================================================= -->
						<div id="payModal2-direct" class="modal">
							결제 완료
							<hr>
							비밀번호
							<input type="number" name="passwd" placeholder="입력해주세요"><br>
								
							<hr>
							<div class="modalBtn">
								<button type="button" id="btnPay2Next-direct">결제하기</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" id="btnPay2Close-direct">닫기</button>
							</div>
						</div>
						<!-- ======================================================================================= -->
						<div id="payModal3-direct" class="modal">
							결제 완료
							<hr>
							${newTrade.trade_amt}원 결제 완료
								
							<hr>
							<div class="modalBtn">
								<button type="submit" id="btnPay3Submit-direct">구매내역 보기</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" id="btnPay3Close-direct">닫기</button>
							</div>
						</div>
				</form>
			</div>
<!-- 		</div> -->
				
				
			
			<!-- 신고하기 -->
			<div id="reportModal" class="modal">
				<form action="RegistReport">
					신고하기
					<hr>
					<input type="radio" name="report_chat_reason" value="0" id="report"><label for="report">욕설 및 비방을 해요</label><br>
					<input type="radio" name="report_chat_reason" value="1" id="report2"><label for="report2">사기인 것 같아요</label><br>
					<input type="radio" name="report_chat_reason" value="2" id="report3"><label for="report3">거래 금지 품목을 팔아요</label><br>
					<input type="radio" name="report_chat_reason" value="3" id="report4"><label for="report4">상품 상태가 안 좋아요</label><br>
					<input type="radio" name="report_chat_reason" value="4" id="report5"><label for="report5">기타 부적절한 행위가 있어요</label><br>
					<hr>
					이미지는 최대 2장 등록 가능합니다.<br>
					<%-- 파일 첨부 형식은 input 태그의 type="file" 속성 활용 --%>
					<%-- 주의! 파일 업로드를 위해 form 태그 속성에 enctype 속성 필수!  --%>
					<div class="">
						<input type="file" name="file1" id="img1" class="img" onchange="prevImg(this)" accept="image/*"> 
					<!-- 	accept 속성을 image/*로 지정할 경우 이미지파일만 업로드 가능 -->
						<input type="file" name="file2" id="img2" class="img" onchange="prevImg2(this)">
					</div>
					<div class="">
						<img id="prevImg" class="prevImg">
						<img id="prevImg2" class="prevImg">
					</div>
					<hr>
					<textarea rows="5" cols="55" name="report_chat_content">내용을 입력하세요</textarea><br>
					<hr>
					<div class="modalBtn">
						<button type="submit" id="btnReportSubmit">신고하기</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" id="btnReportClose">닫기</button>
					</div>
					
					<input type="hidden" name="report_chat_reporter_id" value="${sessionScope.sId}">
					<input type="hidden" name="report_chat_reportee_id" value="">
					<input type="hidden" name="report_chat_chatroom_idx" value="">
		<!-- 			<input type="hidden" name="report_chat_datetime" value=""> -->
					<input type="hidden" name="report_chat_status" value="0">
		<!-- 			<input type="hidden" name="report_chat_reason" value=""> -->
		<!-- 			<input type="hidden" name="report_chat_content" value=""> -->
					<input type="hidden" name="report_chat_img1" value="">
					<input type="hidden" name="report_chat_img2" value="">
					<input type="hidden" name="room_id" value="${param.room_id}">
					<input type="hidden" name="receiver_id" value="${param.receiver_id}">
					<input type="hidden" name="sender_id" value="${param.sender_id}">
					<input type="hidden" name="pd_idx" value="${param.pd_idx}">
					<input type="hidden" name="status" value="${param.status}">
				</form>
			</div>
		</div>
	</div>
	<!-- 채팅창 -->
	<div id="chatRoomArea">
	
	</div>
	<script type="text/javascript">
	
		$(function() {
			startChat();
		});
		
		function startChat() {
			console.log("startChat 호출됨!");
			
			//페이지 로딩 완료 시점에는 top.jsp 페이지도 포함되어 있으므로
			//해당 페이지에서 생성한 자바스크립트의 WebSocket 객체가 ws 변수에 저장되어 있음
			//따라서 현재 chatRoom.jsp 페이지에서 ws 변수에 접근 가능
			
			//setInterval() 함수를 호출하여 0.5초(500밀리초)마다 웹소켓 여결 상태를 감지하여
			//연결이 됐을 경우 서버측으로 채팅방 초기화 메세지 전송
			//화살표 함수
			
			let wsCheckInterval = setInterval(() => {
				console.log("ws : " + ws);
				console.log("ws.readyState : " + ws.readyState);
				if(ws != null && ws != undefined && ws.readyState == ws.OPEN) { //연결 성공 시
					console.log("1:1 채팅방 입장 및 웹소켓 연결 완료!");
				
					clearInterval(wsCheckInterval);
// 					console.log("${param.room_id}" +", " + "${param.receiver_id}"+", " + "${param.sender_id}" + ", " + "${param.status}");
					let roomId = "${param.room_id}";
					let receiverId = "${param.receiver_id}";
					let senderId = "${param.sender_id}";
					let status2 = "${param.status}";
					console.log("receiver_id : " + receiverId);
					
					if(roomId != "" && receiverId != "" && senderId != ""&& status2 != "") {
						let data = {
								room_id : roomId,
								receiver_id : receiverId,
								sender_id : senderId,
								status : status2
						};
						console.log("data : " + data);
						//연결 완료 후 채팅창 생성
						createChatRoom(data);
					} else {
						let sender_id = "${sessionScope.sId}";
						let pd_idx = "${param.pd_idx}";
						console.log("pd_idx : " + pd_idx);
						console.log("상품 상세페이지에서 채팅창 열기!");
						sendMessage("INIT_COMPLETE", sender_id, receiverId, "", "", pd_idx);
// 						console.log("상품 페이지 데이터 data :" + data);
						
					}
				}
			}, 2000);
			
		}
		
		// ======================================================================
		//채팅방 영역에 1개의 채팅방 생성(표시)하는 함수
// 		function createChatRoom(room) {
// 			console.log("createChatRoom 함수 호출됨!");
			
// 			console.log(JSON.stringify(room));
			
// 			//수신자가 세션 아이디와 동일할 경우
// 			//방 생성에 필요한 receiver_id 값을 송신자 아이디로 변경, 아니면 그대로 사영
// 			let receiver_id = room.receiver_id == "${sId}" ? room.sender_id : room.receiver_id;
			
// 			//클래스 선택자 중 "chatRoom" 클래스를 갖는 요소를 찾아
// 			//해당 요소의 클래스에 룸아이디가 포함되어 있지 않을 경우
// 			//채팅방 영역에 새 채팅방 1개 추가
// 			if(!$(".chatRoom").hasClass(room.room_id)) {
// 				console.log("채팅방 표시 시작!");
				
// 				//생성할 채팅방 div 태그 문자열을 변수에 저장
// 				//생성할 채팅방 hidden 태그에 채팅방의 룸아이디와 수신자아이디를 저장
// 				let divRoom = '<div class="chatRoom ' + room.room_id + '">'
// 				+ '	<div class="chatTitleArea">&lt;' + receiver_id + '&gt;</div>'
// 				+ '	<div class="chatMessageArea"></div>'
// 				+ '	<div class="commandArea">'
// 				+ '		<input type="hidden" class="room_id" value="' + room.room_id + '">'
// 				+ '		<input type="hidden" class="receiver_id" value="' + receiver_id + '">'
// 				+ '		<input type="text" class="chatMessage" onkeypress="checkEnter(event)">'
// 				+ '		<input type="button" class="btnSend" value="전송" onclick="send(this)">'
// // 				+ '		<span class="fileArea">'
// // 				+ '			<label for="file"><img src="${pageContext.request.servletContext.contextPath}/resources/images/clip.png"></lable>'
// // 				+ '			<input type="file" id="file" onchange="sendFile(this)">'
// // 				+ '		</span><br>'
// // 				+ '		<input type="button" class="btnCloseRoom" value="닫기" onclick="closeRoom(this)">'
// 				+ '		<input type="button" class="btnQuitRoom" value="종료" onclick="quitRoom(this)">'
// 				+ '	</div>'
// 				+ '</div>';
				
// 				//ID 선택자 "chatRoomArea"영역에 채팅방 1개 추가
// 				$("#chatRoomArea").append(divRoom);
				
// 				//기존 채팅 내역을 불러오기 위한 요청 전송
// 				sendMessage("REQUEST_CHAT_LIST", "", receiver_id, room.room_id, "", room.pd_idx);
				
// 				//채팅방 상태(status)가 2일 경우(상대방이 채팅을 종료)
// 				//채팅방 표시하되 비활성화 상태로 표시하기 위해
// 				//disableRoom() 함수 호출
// 				if(room.status == 2) {
// 					disableRoom(room);
// 				}
// 			}
// 		}
	
		// =========================================================================
		// 채팅 메세지 입력창 엔터키 입력을 판별하는 함수
		function checkEnter(event) {
			console.log("엔터키 입력 판별 checkEnter 함수 호출됨!");
			console.log("이벤트 event : " + event);
			
			//누른 키의 코드값(event.keyCode) 가져와서 엔터키(코드값 13)인지 판별
			if(event.keyCode == 13) {
				//메세지를 전송하는 send() 함수 호출하여 이벤트 발생 요소 객체 전달
				send(event.target);
			}
		}
		
		// ===========================================================================
		// 전송 버튼 클릭 시 채팅 메세지를 전송하는 함수(파라미터로 태그 요소 객체 전달받음)
		function send(elem) {
			console.log("엔터키 입력 및 전송 버튼 클릭! send 함수 호출됨!");
			
			//메세지가 입력된 채팅방 구분
			//1) 전달받은 요소 객체의 부모 요소(class="commandArea") 탐색 => parent() 메서드 활용
			let parent = $(elem).parent(); //commandArea 클래스 선택자 내의 요소가 객체로 리턴됨
			
			//2) 해당 부모 요소의 자식 요소의 value 값에 접근 => find() 메서드 활용
			let inputElement = $(parent).find(".chatMessage"); //텍스트박스 요소 가져오기
			let message = $(inputElement).val();
			console.log("입력한 message : " + message);
			let room_id = $(parent).find(".room_id").val();
// 			let receiver_id = $(parent).find(".receiver_id").val();
			let receiver_id = "${param.receiver_id}";
			console.log("receiver_id 무엇??"+ receiver_id);
			//입력메세지 비어있을 경우 입력창 포커스 요청 후 작업 종료
			if(message == "") {
				$(inputElement).focus();
				return;
			}
			
			//채팅 메세지를 서버로 전송할 sendMessage() 함수 호출
			sendMessage("TALK", "${sId}", receiver_id, room_id, message, pd_idx2);
			
			//자신의 채팅창에 입력한 메세지 출력을 위해 appendMessageToTargetRoom() 함수 호출
			appendMessageToTargetRoom("TALK", "${sId}", receiver_id, room_id, message);
			
			//채팅 메세지 입력창 초기화 후 포커스 요청
			$(inputElement).val("");
			$(inputElement).focus();
		}
		
		//=================================================================================
		//채팅창에 메세지를 출력하는 함수
		function appendMessageToTargetRoom(type, sender_id, receiver_id, room_id, message, send_time) {
			console.log("채팅창 메세지 출력 appendMessageToTargetRoom 함수 호출됨!");
			console.log("입력한 메세지가 잘 나오나 : " + message);
			//----------------------------------------------------------------------------------------
			//메세지 타입에 따라 정렬 위치 다르게 표시하기 위한 div 태그 생성
			let div_message = "";
			console.log("sender_id가 누구일까요 : " + sender_id);
			console.log("sId가 누구일까요 : " + "${sId}");
			console.log("send_time은 어떻게 될까요 : " + send_time);
			
			//-----------------------------------------------------------------------------------------
			//채팅 메세지 날짜 변환하기
			//send_time 값이 비어있을 경우(undefined 현재 시스템 날짜 설정
			let date;
			let hours;
			let minutes;
			if(send_time == undefined) {
				date = new Date();
				console.log("send_time이 비어있으므로 date 객체 생성 date : " + date);
			} else {
				date = new Date(send_time);
			}
				hours = String(date.getHours()).padStart(2, '0');
				minutes = String(date.getMinutes()).padStart(2, '0');
			
			//기본적으로 시각(시:분)은 표시되므로 먼저 전송 시각 저장
			send_time = hours + ":" + minutes;
			
			//----------날짜가 오늘이 아닐 경우 전송 날짜를 추가----------------------------------------
			let now = new Date(); //시스템 날짜를 기준으로 Date 객체 생성
			console.log("date.getMonth() : " + date.getMonth());
			console.log("now.getMonth() : " + now.getMonth());
			if(date.getMonth() != now.getMonth() || date.getDate() != now.getDate()) {
				send_time = (date.getMonth() + 1) + "/" + date.getDate() + " " + send_time;
			}
			
			//---------전송 날짜가 올해가 아닐 경우 전송 연도도 추가
			console.log("date.getFullYear() : " + date.getFullYear());
			console.log("now.getFullYear() : " + now.getFullYear());
			if(date.getFullYear() != now.getFullYear()) {
				send_time = date.getFullYear() + "년 " + send_time;
			}
			
					
			//메세지 타입 판별
			if(type != "TALK") { //시스템 메세지
				console.log("시스템 메세지임!");
				//가운데 정렬을 통해 메세지만 표시
				div_message = "<div class='message message_align_center'><span class='chat_text'>" + message + "</span></div>";
			} else if(sender_id == "${sId}") { // 자신의 메세지(송신자가 자신인 경우)
				console.log("내가 입력한 메세지임!");
				// 우측 정렬을 통해 메세지만 표시
				div_message = "<div class='my-chat-box'><span class='send_time'>" + send_time + "</span><span class='chat my-chat'>" + message + "</span></div>";
			} else if(receiver_id == "${sId}") { // 상대방 메세지(수신자가 자신인 경우)
				console.log("상대방이 보낸 메세지임!");
				// 좌측 정렬을 통해 상대방 아이디와 메세지 표시
				div_message = "<div class='chat-box'><div class='sender_id'>" + sender_id + "</div><span class='chat'>" + message + "</span><span class='send_time'>" + send_time + "</span></div>";
			}
			
			//룸 아이디가 일치하는 채팅방 영역 탐색
			let chatRoom = $("#chatRoomArea").find("." + room_id);
			
			console.log("메세지 추가 시작함!");
			//해당 채팅방 영역의 채팅 메세지 영역(".chatMessageArea") 탐색하여 메세지 추가
			$(chatRoom).find(".chatMessageArea").append(div_message);
			
			console.log("메세지 추가 했음!");
			
			let chatMessageArea = $(chatRoom).find(".chatMessageArea");
			
			//채팅 메세지 출력창의 스크롤바를 항상 맨 밑으로 유지
			//div 영역의 크기 대신 스크롤바의 크기를 구한 뒤 (요소 (배열 0번의 인덱스)의 scrollHeight)
			//해당 크기를 채팅 메세지 표시 영역의 스크롤바 위치로 지정
			$(chatRoomArea).scrollTop($(chatRoomArea)[0].scrollHeight);
			
			
			
		}
		
		//================================================================================================
		//채팅방 1개 대화 종료
		function quitRoom(elem) {
			if(confirm("해당 대화방을 종료하시겠습니까?")) {
				let parent = $(elem).parent(); //닫기 버튼의 부모(commandArea) 탐색
				
				//단 부모의 부모 탐색 대신 부모 요소의 자식들 중 room_id 를 탐색하여
				//chat_room 클래스 선택자에 룸 아이디가 동일한 요소를 제거해도 동일함
				let room_id = $(parent).find(".room_id").val(); //룸 아이디 가져오기
				console.log("room_id : " + room_id);
				
				let receiver_id = $(parent).find(".receiver_id").val(); //수신자 아이디 가져오기
				console.log("receiver_id : " + receiver_id);
				
				//클래스 선택자가 chatRoom 이면서 room_id인 채팅방 1개 요소 제거
				$(".chatRoom." + room_id).remove();
				
				// 클래스 선택자가 chatRoomList 이면서 room_id 인 채팅방 목록 1개 요소 제거
				$(".chatRoomList." + room_id).remove();
				
				// 채팅방 종료를 위해 서버로 종료 신호 전송
				// => 메세지 타입 : "LEAVE", 송신자 아이디, 수신자 아이디, 룸 아이디 전송
				//sendMessage(type, sender_id, receiver_id, room_id, message, pd_idx)
				sendMessage("LEAVE", "${sId}", receiver_id, room_id, "", pd_idx2);
				
				window.close();
			}
			
		
		
		}
		
		//===========================================================================================
		//x 아이콘 클릭 시, 팝업 닫기
		$("#closeChat").click(function() {
			if(confirm("채팅창을 닫으시겠습니까?")) {
				window.close();
			}
			
		});
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	</script>
</body>
</html>