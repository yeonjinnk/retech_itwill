<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	function confirmLogout() {
		let isLogout = confirm("로그아웃 하시겠습니까?");
		// isLogout 변수값이 true 일 경우 로그아웃 작업을 수행할
		// "MemberLogout" 서블릿 요청
		if (isLogout) {
			location.href = "MemberLogout";
		}
	}
</script>
<!-- 탑 최상단 영역 -->
<div class="header_top">
	<div class="top_inner">
		<div class="top_left_blank">
		</div>
		<div class="top_menu">
			<nav class="top_menu_container">
				<ul class="top_area">
					<li class="top_list">
						<a href="TechPayMain" class="top_link" id="top_link1">테크페이</a>
					</li>
					<li class="top_list">
					<!-- 채팅하기 새 창으로 열기 -->
					<!-- window.open 자바스크립트니까 javascript, 반환값 없으므로 void -->
					<!-- window.open(url, name(지정 시, 창 2개 열때 하나로 열수 있음), spec, ...) -->
						<a href="javascript:void(window.open('ChatList','chat','width=600px,height=600px'))" class="top_link">
						채팅하기</a>
					</li>
					<li class="top_list">
						<a href="ProductRegistForm" class="top_link">판매하기</a>
					</li>
						<c:choose>
							<c:when test="${empty sessionScope.sId}"> <%-- 로그인 상태가 아닐 경우 --%>
								<li class="top_list">
								 	<a href="MemberLogin" class="login top_link">로그인</a>
								</li>
							</c:when>
							<c:otherwise> <%-- 로그인 상태일 경우 --%>
								<li class="top_list">
									<a href="SaleHistory" class="top_link">${sessionScope.sName}님</a>
								</li>
								<li class="top_list">
									<a href="javascript:confirmLogout()" class="top_link">로그아웃</a>
								</li>
								
								<!-- 관리자 계정일 경우 관리자 페이지 링크 표시 -->
								<c:if test="${sessionScope.sIsAdmin eq 'Y'}">
									<li class="top_list">
										<a href="AdminHome" class="top_link">관리자페이지</a>
									</li>
								</c:if>
							</c:otherwise>
						</c:choose>
				</ul>
			</nav>
		</div>
	</div>
</div>
<!-- 탑 로고 및 메뉴,], 검색어 영역 -->
<div class="header_main">
	<div class="main_inner">
		<div class="logo">
			<a href="./" class="logo"><img src="${pageContext.request.servletContext.contextPath}/resources/images/logo.png" height="70" width="140"></a>
		</div>
		<div class="main_menu">
			<nav class="menu_container">
				<ul class="menu_area">
					<li class="menu_list">
						<a href="ProductList" class="menu_link" id="menu_link1">상품</a>
					</li>
					<li class="menu_list">
						<a href="Store" class="menu_link">스토어</a>
							<ul class="sub_menu">
								<li><a href="#">키스킨</a></li>
								<li><a href="#">마우스패드</a></li>
								<li><a href="StoreDetail">받침대</a></li>
								<li><a href="#">파우치</a></li>
							</ul>
					</li>
					<li class="menu_list">
						<a href="Notice" class="menu_link">고객센터</a>
					</li>
					
				</ul>
				<ul class="main_search">
					<li>
						<input type="text" placeholder="검색어를 입력하세요" width="120">
					</li>
				</ul>
			</nav>
		</div>
	</div>
</div>

<%-- 로그인 상태일 경우에만 채팅 관련 스크립트를 클라이언트 측으로 전송 --%>
<c:if test="${not empty sId}">
	<script>
		//websocket 객체가 저장될 변수 선언
		let ws;
		
		//0.페이지 로딩 완료 시 채팅방 입장을 위해 웹소켓 연결을 수행할 connect() 함수 호출
		$(function() {
			connect();
		});
		
		//0.최초 1회 웹소켓 연결을 수행하는 connect() 함수 정의
		function connect() {
			//요청 주소 생성(웹소켓 기본 프로토콜은 ws, 보안 프로토콜은 wss)
			//EL 활용하여 request 객체 정보 추출을 통해 현재 서버 주소 지정 가능
			let ws_base_url = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}";
			//ws://localhost:8081/retech_proj
// 			console.log(ws_base_url);
			
			//WebSocket 객체 생성하여 서버측에 웹소켓 통신 연결 요청(최초 연결을 위한 handshaking 수행)
			//=> 파라미터 : 웹소켓 요청을 위한 프로토콜 및 URL(ws://주소:포트/매핑주소)
			ws = new WebSocket(ws_base_url + "/echo");
			//서버(스프링)에서 WebSocketHandler 구현체의 afterConnectionEstablished() 메서드 자동 호출됨
			
			//WebSocket 객체의 onxxx 이벤트에 각 함수 연결하여 특정 웹소켓 이벤트 발생 시 작업 수행
			ws.onopen = onOpen; //웹소켓 연결 시
			ws.onclose = onClose; //웹소켓 연결 해제 시
			ws.onmessage = onMessage; //웹소켓 메세지 수신 시
			ws.onerror = onError; //웹소켓 에러 시
		}
		
		//1. 웹소켓 연결 시
		function onOpen() {
			console.log("onOpen()");
		}
		// ======================================================================
		function onClose() {
			console.log("onClose()");
		}
		// ======================================================================
		//(서버 => 클라이언트) 
		//수신한 메세지 확인
		function onMessage(event) {
			console.log("onMessage() event : " + event); //[object MessageEvent]
			let data = JSON.parse(event.data);
			console.log("onMessage() data : " + data); //[object Object]
			console.log("onMessage() 수신된 데이터 : " + JSON.stringify(data)); //{"type":"INIT","sender_id":"sender@naver.com","receiver_id":"receiver@naver.com","room_id":"","message":"[]"}
			console.log("수신된 데이터 data.type : " + data.type); //수신된 데이터 data.type : INIT
			
			//메세지 타입 판별
			//INIT이면 서버측에 INIT 보내고 기존 채팅방 목록 추가해서 다시 받았으므로
			//받은 채팅방 목록을 채팅방 목록 영역에 뿌리자
			if(data.type == "INIT") {//채팅페이지 초기 진입
				console.log("INIT 판별됨!");
				//채팅방 목록 표시 영역 초기화
// 				$("chatRoomListArea").empty();
			
				//전달받은 message 속성값에 채팅방 목록이 저장되어 왔으므로
				//해당 목록을 다시 JSON 객체 형태로 파싱
				//복수개의 채팅방 목록이 배열 형태로 전달되므로 반복을 통해 객체 접근
				for(let room of JSON.parse(data.message)) {
					//appendChatToRoomList() 함수 호출하여 채팅방 목록 표시
					appendChatRoomToRoomList(room);
				}
				
				//(클라이언트 => 서버) 
				//초기화 완료 메세지 전송
				//메세지 타입 : INIT_COMPLETE, 수신자 아이디도 함께 전송
				sendMessage("INIT_COMPLETE", "", data.receiver_id, "", "");
				console.log("INIT_COMPLETE 서버로 전송함");
			} else if(data.type == "ERROR") { //채팅 관련 오류 - DB에 상대방 ID 존재하지 않을 때
				console.log("ERROR 판별됨!");
				//사용자에게 오류메세지 표시 및 이전 페이지로 돌아가기
				alert(data.message + "\n이전 페이지로 돌아갑니다.");
				history.back();
			} else if(data.type == "START") { //채팅방 추가
				console.log("START 판별됨!");
				//채팅방 생성(표시) 및 채팅방 목록 표시
				//1. 채팅방 목록에 새 채팅방 추가를 위해 appendChatRoomToRoomList() 함수 호출
				//	 (기존 대화내역이 없는 사용자와 채팅 시작 시 채팅방 목록에 새 채팅방 추가 위함)
				appendChatRoomToRoomList(JSON.parse(data.message));
				
				//2. 채팅방 표시 위해 createChatRoom() 함수 호출
// 				createChatRoom(data);
				
			}
		}
		// ======================================================================
		function onError() {
			console.log("onError()");
		}
		
		//전달받은 메세지를 웹소켓 서버측으로 전송하는 함수
		//파라미터 : 메세지타입, 송신자아이디, 수신자아이디, 채팅방아이디, 메세지
		function sendMessage(type, sender_id, receiver_id, room_id, message) {
			console.log("sendMessage 호출됨!");
			// WebSocket 객체의 send() 메서드 호출하여 서버측으로 메세지 전송
			// => 전송할 메세지를 toJsonString() 함수를 통해 JSON 형식으로 변환하여 전송
			ws.send(toJsonString(type, sender_id, receiver_id, room_id, message));
			console.log("sendMessage 전송됨!");
		}
		
		// ======================================================================
		// 채팅방 목록 영역에 1개 채팅방 정보를 추가하는 함수
		function appendChatRoomToRoomList(room) {
			console.log("appendChatRoomToRoomList 함수 호출됨 ");
// 			console.log("room : " + room);
// 			console.log("room_id : " + room.room_id);
// 			console.log("status : " + room.status);
			
			//클래스 선택자 중 "chatRoomList"클래스를 갖는 요소를 찾아
			//해당 요소의 클래스에 룸아이디가 포함되어 있지 않을 경우
			//채팅방 목록에 새 채팅방 목록으로 추가
			if(!$(".chatRoomList").hasClass(room.room_id)) {
				//채팅방 제목과 채팅방 상태가 전달되지 않았을 경우 기본값 설정
				//제목은 상대방 아이디 + " 님과의 대화"로 설정하고
				//채팅방 상태는 1로 설정
				console.log("room.title : " + room.title + ", room.status : " + room.status);
				
				let title = room.title == undefined ? room.sender_id + " 님과의 대화" : room.title;
				let status = room.status == undefined ? 1: room.status;
				
				//채팅방 상태(status)가 2일 경우 채팅방 목록의 제목에 (종료) 추가
				if(status == 2) {
					title += " (종료)";
				}
				
				//새로 생성할 채팅방 목록 1개의 div 태그 작성
				//<div class="chatRoomList 룸아이디 status_ 상태">제목</div>
				let divRoom = "<div class='chatRoomList " + room.room_id + " status_" + status + "'>"
							+ title
							+ "</div>";
				
				$("#chatRoomListArea").append(divRoom);
				console.log("채팅방 목록에 채팅방 추가함!");
			
				//해당 채팅방 목록 div 태그에 더블클릭 이벤트 핸들링
				//복수개의 class 선택자 검색이므로 마침표로 연결
				
				$(".chatRoomList." + room.room_id).on("dblclick", function() {
					console.log("채팅방 목록 클릭해 채팅창 열기!");
					let chatWindow = window.open("ChatRoom?room_id=" + room.room_id + "&sender_id=" + room.sender_id + "&receiver_id=" + room.receiver_id, room.room_id, "width=600px,height=600px");
					//채팅방 1개 생성하도록 createChatRoom() 함수 호출
					
				});
				
			}
			
		} 
		
		// ======================================================================
		// 채팅방 영역에 1개의 채팅방 생성(표시)하는 함수
		function createChatRoom(room) {
			console.log("createChatRoom 함수 호출됨 ");
			console.log(JSON.stringify(room));
			
			// 수신자가 세션 아이디와 동일할 경우
			// 방 생성에 필요한 receiver_id 값을 송신자 아이디로 변경, 아니면 그대로 사용
			let receiver_id = room.receiver_id == "${sId}" ? room.sender_id : room.receiver_id;
			
			//클래스 선택자 중 "chatRoom" 클래스를 갖는 요소를 찾아
			//해당 요소의 클래스에 룸아이디가 포함되어 있지 않을 경우
			//채팅방 영역에 새 채팅방 1개 추가
			if(!$(".chatRoom").hasClass(room.room_id)) {
				console.log("채팅방 표시 시작!");
				console.log("room.room_id : " + room.room_id);
				console.log("receiver_id : " + receiver_id);
				
				//생성할 채팅방 div 태그 문자열을 변수에 저장
				//생성할 채팅방 hidden 태그에 채팅방의 룸아이디와 수신자아이디를 저장
				//<div class="chatRoom 룸아이디">
				//	<div class="chatTitleArea">&lt;수신자아이디&gt;</div>
				//	<div class="chatMessageArea"></div>
				//	<div class="commandArea">
				//		<input type="hidden" class="room_id" value="룸아이디">
				//		<input type="hidden" class="receiver_id" value="수신자아이디">
				//		<input type="text" class="chatMessage" onkeypress="checkEnter(event)">
				//		<input type="button" class="btnSend" value="전송" onclick="send(this)">
				//		<input type="button" class="btnCloseRoom" value="닫기" onclick="closeRoom(this)">
				//		<input type="button" class="btnQuitRoom" value="종료" onclick="quitRoom(this)">
				//	</div>
				//</div>
				let divRoom = '<div class="chatRoom ' + room.room_id + '">'
				+ '	<div class="chatTitleArea">&lt;' + receiver_id + '&gt;</div>'
				+ '	<div class="chatMessageArea"></div>'
				+ '	<div class="commandArea">'
				+ '		<input type="hidden" class="room_id" value="' + room.room_id + '">'
				+ '		<input type="hidden" class="receiver_id" value="' + receiver_id + '">'
				+ '		<input type="text" class="chatMessage" onkeypress="checkEnter(event)">'
				+ '		<input type="button" class="btnSend" value="전송" onclick="send(this)">'
// 				+ '		<input type="button" class="btnCloseRoom" value="닫기" onclick="closeRoom(this)">'
				+ '		<input type="button" class="btnQuitRoom" value="종료" onclick="quitRoom(this)">'
				+ '	</div>'
				+ '</div>';
				
// 				console.log("divRoom : " + divRoom);
				//id선택자 chatRoomArea 영역에 채팅방 1개 추가
				$("#chatRoomArea").append(divRoom);
				console.log("채팅방 표시 시작됨!");

				//(클라이언트 -> 서버)
				//기존 채팅 내역을 불러오기 위한 요청 전송
// 				sendMessage("REQUEST_CHAT_LIST", "", "", room.room_id, "");
// 				console.log("REQUEST_CHAT_LIST 메세지 전송함!");
				//채팅방 상태(status)가 2일 경우(상대방이 채팅을 종료)
				//채팅방 표시하되 비활성화 상태로 표시하기 위해
				//disableRoom() 함수 호출
// 				if(room.status == 2) {
// 					disableRoom(room);
// 				}
				
			}
			
		}
		
		
		//======================================================================
		//채팅방 1개 대화 종료
		function quitRoom(elem) {
			if(confirm("해당 대화방을 종료하시겠습니까?")) {
				
				let parent = $(elem).parent(); //닫기 버튼의 부모 탐색
				let room_id = $(parent).find(".room_id").val(); //룸 아이디 가져오기
				console.log("room_id : " + room_id);
				
				let receiver_id = $(parent).find(".receiver_id").val(); //수신자 아이디 가져오기
				console.log("receiver_id : " + receiver_id);
				
				//클래스 선택자가 chatRoom 이면서 room_id인 채팅방 목록 1개 요소 제거
				$(".chatRoom." + room_id).remove();
				
				//클래스 선택자가 chatRoomList 이면서 room_id 인 채팅방 목록 1개 요소 제거
				$(".chatRoomList." + room_id).remove();
				
				//채팅방 종료를 위해 서버로 종료 신호 전송
				sendMessage("LEAVE", "{sId}", receiver_id, room_id, "");
				console.log("새 창 닫기!");
				window.close();
			}
		}
		
		
		
		
		//======================================================================
		//채팅 메세지 입력창 엔터키 입력을 판별하는 함수
		function checkEnter(event) {
			if(event.keyCode == 13) {
				console.log("채팅 메세지 입력창 엔터키 입력됨!");
				//메세지를 전송하는 send() 함수 호출하여 이벤트 발생 요소 객체 전달
				send(event.target);
				console.log("event.target : " + event.target);
			}
		} 
		
		//======================================================================
		//전송 버튼 클릭 시 채팅 메세지를 전송하는 함수(파라미터로 태그 요소 객체 전달받음)
		function send(elem) {
			console.log("send() 호출됨!");
			//메세지가 입력된 채팅방 구분
			//1) 전달받은 요소 객체의 부모 요소(class="commandArea") 탐색 => parent() 메서드 활용
			let parent = $(elem).parent(); //commandArea 클래스 선택자 내의 요소가 객체로 리턴됨
			console.log("parent : " + $(parent).html()); //해당 요소 태그 확인
			
			//2) 해당 부모 요소의 자식 요소의 value 값에 접근 => find() 메서드 활용
			let inputElement = $(parent).find(".chatMessage"); //텍스트박스 요소 가져오기
			let message = $(inputElement).val();
			let room_id = $(parent).find(".room_id").val();
			let receiver_id = $(parent).find(".receiver_id").val();
// 			console.log("message : " + message + ", room_id : " + room_id + ", receiver_id : " + receiver_id);

			//입력메세지 비어있을 경우 입력창 포커스 요청 후 작업 종료
			if(message == "") {
				$(inputElement).focus();
				return;
			}

			//채팅 메세지를 서버로 전송할 sendMessage() 함수 호출
			sendMessage("TALK", "{sId}", receiver_id, room_id, message);
			
			//자신의 채팅창에 입력한 메세지 출력을 위해 appendMessageToTargetRoom() 함수 호출
			//sendMessage() 함수 호출 파라미터와 동일하게 전달
			appendMessageToTargetRoom("TALK", "{sId}", receiver_id, room_id, message);
			
			//채팅 메세지 입력창 초기화 후 포커스 요청
			$(inputElement).val("");
			$(inputElement).focus();

		}
		
		// ======================================================================
		// 채팅창에 메세지를 출력하는 함수
		function appendMessageToTargetRoom(type, sender_id, receiver_id, room_id, message, send_time) {
			console.log("appendMessageToTargetRoom 호출됨!");
			//메세지 타입에 따라 정렬 위치 다르게 표시하기 위한 div 태그 생성
			let div_message = "";
			
			//메세지 타입 판별
			if(type != "TALK") { //시스템 메세지
				//가운데 정렬을 통해 메세지만 표시
				div_message = "<div class='mesasge message_align_center'><span class='chat_text'>" + message + "</span></div>";
			} else if(sender_id == "${sId}") { // 자신의 메세지(송신자가 자신인 경우)
				// 우측 정렬을 통해 메세지만 표시
				div_message = "<div class='message message_align_right'><span class='send_time'>" + send_time + "</span><span class='chat_text'>" + message + "</span></div>";
			} else if(receiver_id == "${sId}") { // 상대방 메세지(수신자가 자신인 경우)
				// 좌측 정렬을 통해 상대방 아이디와 메세지 표시
				div_message = "<div class='message message_align_left'><div class='sender_id'>" + sender_id + "</div><span class='chat_text'>" + message + "</span><span class='send_time'>" + send_time + "</span></div>";
			}
			
			//룸 아이디가 일치하는 채팅방 영역 탐색
			let chatRoom = $("#chatRoomArea").find("." + room_id);
			
			//해당 채팅방 영역의 채팅 메세지 영역(".chatMessageArea") 탐색하여 메세지 추가
			$(chatRoom).find(".chatMessageArea").append(div_message);
			
			let chatMessageArea = $(chatRoom).find(".chatMessageArea");
			
			//채팅 메세지 출력창의 스크롤바를 항상 맨 밑으로 유지
			//div영역의 크기 대신 스크롤바의 크기를 구한 뒤(요소의 scrollHeight)
			//해당 크기를 채팅 메세지 표시 영역의 스크롤바 위치로 지정
			$(chatMessageArea).scrollTop($(chatMessageArea)[0].scrollHeight);
		}
		
		// ======================================================================
		// 전달받은 메세지타입과 메세지를 JSON 형식 문자열로 변환하는 toJsonString() 함수
		function toJsonString(type, sender_id, receiver_id, room_id, message) {
			// 전달받은 파라미터들을 하나의 객체로 묶어 JSON 타입 문자열로 변환 후 리턴
			let data = {
				type : type,
				sender_id : sender_id,
				receiver_id : receiver_id,
				room_id : room_id,
				message : message
			};
			
			// JSON.stringify() 메서드 호출하여 객체 -> JSON 문자열로 변환
			return JSON.stringify(data);
		}
		
		
	</script>

</c:if>


