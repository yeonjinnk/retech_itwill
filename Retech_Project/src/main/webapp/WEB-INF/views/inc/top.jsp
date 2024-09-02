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
						<a href="javascript:void(window.open('ChatList','','width=600px,height=600px'))" class="top_link">
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
								<c:if test="${sessionScope.sIsAdmin eq 1}">
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


