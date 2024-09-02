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
					<c:choose>
						<c:when test="${not empty sessionScope.sId}">
							<a href="javascript:void(window.open('ChatList?receiver_id=' + 'receiver@naver.com', '','width=600px,height=600px'))" class="top_link">
							채팅(sen)</a>
						</c:when>
						<c:when test="${empty sessionScope.sId}">
							<a href="ChatList" class="top_link">
							채팅(sen)</a>
						</c:when>
					</c:choose>
					</li>
					<li class="top_list">
					<!-- 채팅하기 새 창으로 열기 -->
					<!-- window.open 자바스크립트니까 javascript, 반환값 없으므로 void -->
					<!-- window.open(url, name(지정 시, 창 2개 열때 하나로 열수 있음), spec, ...) -->
					<c:choose>
						<c:when test="${not empty sessionScope.sId}">
							<a href="javascript:void(window.open('ChatList?receiver_id=' + 'sender@naver.com', '','width=600px,height=600px'))" class="top_link">
							채팅(rec)</a>
						</c:when>
						<c:when test="${empty sessionScope.sId}">
							<a href="ChatList" class="top_link">
							채팅(rec)</a>
						</c:when>
					</c:choose>
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
		function onMessage(event) {
			let data = JSON.parse(event.data);
			console.log("onMessage() 수신된 데이터 : " + JSON.stringify(data)); 
			
			//메세지 타입 판별
			
			if(data.type == "INIT") { //채팅페이지 초기 진입
				console.log("INIT 타입 - 채팅방 목록 초기화함!");
				//채팅방 목록 표시 영역 초기화
				$("#chatRoomListArea").empty();
				
				console.log("data.message : " + data.message);
				//전달받은 message 속성값에 채팅방 목록이 저장되어 
				//해당 목록을 다시 JSON 객체 형태로 파싱
				//복수개의 채팅방 목록이 배열 형태로 전달되므로 반복을 통해 객체 접근
				for(let room of JSON.parse(data.message)) {
					//appendChatRoomToRoomList() 함수 호출하여 채팅방 목록 표시
					appendChatRoomToRoomList(room);
				}
				
				//초기화 완료 메세지 전송
				//(클라이언트 -> 서버)
				//sendMessage(type, sender_id, receiver_id, room_id, message, pd_idx)
				sendMessage("INIT_COMPLETE", "", data.receiver_id, "", "");
				
			} else if(data.type == "ERROR") { //채팅 관련 오류
				console.log("ERROR 타입 - 채팅 오류임!");

				//사용자에게 오류메세지 표시 및 이전 페이지로 돌아가기
				alert(data.message + "\n이전 페이지로 돌아갑니다.");
				history.back();
				
			} else if(data.type == "START") { //채팅방 추가
				console.log("START 타입 - 채팅방 추가!");

				
				//채팅방 생성(표시) 및 채팅방 목록 표시
				//1. 채팅방 목록에 새 채팅방 추가를 위해 appendChatRoomToRoomList() 함수 호출
				//	(기존 대화내역이 없는 사용자와 채팅 시작 시 채팅방 목록에 새 채팅방 추가 위함)
				appendChatRoomToRoomList(JSON.parse(data.message));
			} else if(data.type == "REQUEST_CHAT_LIST") { //기존 채팅 메세지 내역 수신
				console.log("REQUEST_CHAT_LIST 타입 - 기존 메세지 수신!");

				//기존 채팅 내역이 저장된 message 내의 리스트 반복하여
				//appendMessageToTargetRoom() 메서드 호출하여 메세지 표시
				for(let message of JSON.parse(data.message)) {
					appendMessageToTargetRoom(message.type, message.sender_id, message.receiver_id, message.room_id, message.message, message.send_time);
				}
			} else if(data.type == "TALK") { //채팅 메세지 수신
				console.log("TALK 타입 - 채팅 메세지 수신!");

				//채팅방 생성(표시) 및 채팅방 목록 표시
				appendChatRoomToRoomList(data);
				createChatRoom(data);
				
				//appendMessageToTargetRoom() 함수 호출하여 수신된 메세지를 채팅방에 표시
				appendMessageToTargetRoom(data.type, data.sender_id, data.receiver_id, data.room_id, data.message, data.send_time);
			} else if(data.type == "LEAVE") { //채팅 종료 메세지 수신
				console.log("LEAVE 타입 - 채팅 종료!");

				appendMessageToTargetRoom(data.type, data.sender_id, data.receiver_id, data.room_id, data.message, data.send_time);
				disableRoom(data);
			}
		}
		// ======================================================================
		function onError() {
			console.log("onError()");
		}
		
		//전달받은 메세지를 웹소켓 서버측으로 전송하는 함수
		//파라미터 : 메세지타입, 송신자아이디, 수신자아이디, 채팅방아이디, 메세지
		function sendMessage(type, sender_id, receiver_id, room_id, message) {
			// WebSocket 객체의 send() 메서드 호출하여 서버측으로 메세지 전송
			// => 전송할 메세지를 toJsonString() 함수를 통해 JSON 형식으로 변환하여 전송
			ws.send(toJsonString(type, sender_id, receiver_id, room_id, message));
		}
		
			
		// ======================================================================
		// 채팅방 목록 영역에 1개 채팅방 정보를 추가하는 함수
		function appendChatRoomToRoomList(room) {
			console.log("appendChatRoomToRoomList 호출됨!")
			
			//클래스 선택자 중 "chatRoomList" 클래스를 갖는 요소를 찾아
			//해당 요소의 클래스에 룸아이디가 포함되어 있지 않을 경우
			//채팅방 목록에 새 채팅방 목록으로 추가
			if(!$(".chatRoomList").hasClass(room.room_id)) {
				//채팅방 제목과 채팅방 상태가 전달되지 않았을 경우 기본값 설정
				//제목은 상대방 아이디 + " 님과의 대화"로 설정하고
				//채팅방 상태는 1로 설정
				console.log("room.title : " + room.title + ", room.status : " + room.status);
				
				let title = room.title == undefined ? room.sender_id + " 님과의 대화" : room.title;
				let status = room.status == undefined ? 1 : room.status;
				
				//채팅방 상태가 2일 경우 채팅방 목록의 제목에 (종료) 추가
				if(status == 2) {
					title += " (종료)";
				}
				
				//새로 생성할 채팅방 목록 1개의 div 태그 작성
				//<div class="chatRoomList 룸아이디 status_상태">제목</div>
				let divRoom = "<div class='chatRoomList " + room.room_id + " status_" + status + "'>"
							+ title
							+ "</div>"
							
				$("#chatRoomListArea").append(divRoom);
							
				//해당 채팅방 목록 div 태그에 더블클릭 이벤트 핸들링
				$(".chatRoomList." + room.room_id).on("dblclick", function() {
					console.log("채팅방 목록 더블클릭 해 채팅창 열림!");
					window.open("ChatRoom?room_id=" + room.room_id + "&receiver_id=" + room.receiver_id + "&sender_id=" + room.sender_id + "&status=" + room.status,
								room.room_id, "width=600px, height=600px");
				});
			}
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
		
		//=========================================================================================
		// 상대방이 종료한 채팅방을 비활성화하는 함수
		function disableRoom(room) {
			console.log("disableRoom 함수 호출됨!");
			//룸아이디가 일치하는 채팅방 영역 탐색
			let chatRoom = $("#chatRoomArea").find("." + room.room_id);
			
			// 메세지 표시영역 색상 어둡게
			$(chatRoom).find(".chatMessageArea").css("background", "#CCCCCCAA");
			// 채팅방 제목에 종료 표시
			$(chatRoom).find(".chatTitleArea").text($(chatRoom).find(".chatTitleArea").text() + "(종료됨)");
			// 채팅 메세지 입력창과 전송 버튼 비활성화
			$(chatRoom).find(".chatMessage").prop("disabled", true);
			$(chatRoom).find(".btnSend").prop("disabled", true);
		}
		
		
	</script>

</c:if>


