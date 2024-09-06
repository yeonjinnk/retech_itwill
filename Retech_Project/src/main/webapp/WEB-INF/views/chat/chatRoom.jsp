<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/chat/chatRoom.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
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
			
			/*거래하기 버튼 클릭 시 모달창 띄움*/
			$("#btnTrade").click(function() {
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
			
			/*테크페이(직거래) 버튼 클릭 시 모달창 띄움*/
			$("#btnDirect").click(function() {
				console.log("테크페이(직거래) 버튼 클릭됨!");
				$("#directModal").show();
				console.log("테크페이(직거래) 모달 띄움!");
			});
			
			/*신고하기 아이콘 클릭 시 모달창 띄움*/
			$("#btnReport").click(function() {
				console.log("신고하기 버튼 클릭됨!");
				$("#reportModal").show();
				console.log("신고하기 모달 띄움!");
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
				<div class="product_photo co01">
					<img id="pdImg">
				</div>
				<div class="co02">
					<div class="co02-1">판매중</div><br>
					<div class="co02-2">노트북</div><br>
					<div class="co02-2\3">10,000원</div>
				</div>
			</div>
			<div class="btnClose">
				<img src="${pageContext.request.contextPath}/resources/images/x_icon.png" id="closeChat" >
			</div>
		</div>
		<div class="art_secondRow">
			<div class="left">
				<!-- 판매자 '거래하기' 버튼 -->
				<button id="btnTrade"><span>거래하기</span></button>
				<!-- 구매자 '테크페이(택배)' 버튼 -->
				<button id="btnDelivery"><span>테크페이(택배)</span></button>
				<!-- 구매자 '테크페이(직거래)' 버튼 -->
				<button id="btnDirect"><span>테크페이(직거래)</span></button>
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
			<!-- 구매자 '테크페이(택배)' -->
			<div id="deliveryModal" class="modal">
				<jsp:include page="/WEB-INF/views/chat/deliveryModal.jsp"></jsp:include>
			</div>
			<!-- 구매자 '테크페이(직거래)' -->
			<div id="directModal" class="modal">
				<jsp:include page="/WEB-INF/views/chat/directModal.jsp"></jsp:include>
			</div>
			<!-- 신고하기 -->
			<div id="reportModal" class="modal">
				<jsp:include page="/WEB-INF/views/chat/reportModal.jsp"></jsp:include>
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
			let receiver_id = $(parent).find(".receiver_id").val();
			
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