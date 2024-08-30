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
	<!-- 상단 -->
	<div id="chatRoomArea"></div>
	<script type="text/javascript">
		$(function() {
			let room_id = "${param.room_id}";
			let sender_id = "${param.sender_id}";
			let receiver_id = "${param.receiver_id}";
			
			let room = {
				room_id : room_id,
				sender_id : sender_id,
				receiver_id : receiver_id
			};
			
			createChatRoom(room);
		// setInterval() 함수를 호출하여 0.5초(500 밀리초)마다 웹소켓 연결 상태를 감지하여
		// 연결이 됐을 경우 서버측으로 채팅방 초기화 메세지 전송
		let wsCheckInterval = setInterval(() => {
			if(ws != null && ws != undefined && ws.readyState === ws.OPEN) {
				console.log("1:1 채팅방 입장 및 웹소켓 연결 완료!");
				
				//서버측으로 초기화 메세지 전송
				//top.jsp 의 sendMessage() 함수 호출
				sendMessage("REQUEST_CHAT_LIST", "", "", room.room_id, "");
				console.log("REQUEST_CHAT_LIST 메세지 전송함!");
				// 현재 인터벌 작업 종료하기 위해 clearInterval() 함수 활용
				// => 함수 파라미터로 반복 인터벌 작업 수행하는 함수의 아이디를 전달
				clearInterval(wsCheckInterval);
			}
		}, 500);
		});
	
	</script>
</body>
</html>