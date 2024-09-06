<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/chat/chatList.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<%-- 현재 위치는 컨텍스트 루트(/MVC_Board = webapp) 이므로 inc 디렉토리의 top.jsp 지정 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<form id="chatList" method="post" action="chatRoom">
		<div id="chatListBody">
			<div class="chatTitle">
				<div class="titleText">채팅하기</div>
			</div>
			<!-- 채팅방 목록 -->
			<div id="chatRoomListArea"></div>
		</div>
	</form>
<script type="text/javascript">
	$(function() {
		startChat();
	});
	
	function startChat() {
		//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		//일단 임시로 둠.. 나중에 상점의 판매자 아이디를 가져와야
		let user_id = "${param.user_id}";
		let receiver_id = "${param.receiver_id}";
		console.log("receiver_id : " + receiver_id);
		
		//top.jsp에 WebSocket 객체를 ws 변수에 저장해놓았으므로 ws 변수 접근 가능
		console.log("웹소켓 객체 : " + ws); //1이면 연결된 상태
		
		//웹소켓 연결 상태 체크
		console.log("웹소켓 연결 상태 : " + ws.readyState);
		
		// setInterval() 함수를 호출하여 0.5초(500 밀리초)마다 웹소켓 연결 상태를 감지하여
		// 연결이 됐을 경우 서버측으로 채팅방 초기화 메세지 전송
		let wsCheckInterval = setInterval(() => {
			
			console.log("ws : " + ws);
			console.log("ws.readyState : " + ws.readyState);
			
			if(ws != null && ws != undefined && ws.readyState === ws.OPEN) {
				console.log("1:1 채팅방 입장 및 웹소켓 연결 완료!");
				console.log("로그인 세션아이디 : " + "${sessionScope.sId}");
				//서버측으로 초기화 메세지 전송
				//top.jsp 의 sendMessage() 함수 호출
				// function sendMessage(type, sender_id, receiver_id, room_id, message, pd_idx)
				sendMessage("INIT", "", "${sessionScope.sId}", "", "", "-1");
				
				// 현재 인터벌 작업 종료하기 위해 clearInterval() 함수 활용
				// => 함수 파라미터로 반복 인터벌 작업 수행하는 함수의 아이디를 전달
				clearInterval(wsCheckInterval);
			}
		}, 500);
		
	}
</script>
</body>
</html>