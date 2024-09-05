<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="${pageContext.request.contextPath}/resources/css/inc/top.css" rel="stylesheet">
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
	
	//알림
	
	//알림창 열림 상태 기본 false로
	let isAlarmListOpen = false;
	
// 	알림창 열고 닫는 함수
	function alarmListOpen() {
		console.log("알림창 여닫는 alarmListOpen 함수 호출됨!");
		if(!isAlarmListOpen) {//알림창 열기
			console.log("알림창 열기!");
			$(".layer_box").css("display", "");
			isAlarmListOpen = true;
			
			// 알림 목록에 DB에 저장된 알림 가져오는 함수
			let id = "${sessionScope.sId}";
// 			let id = sessionStorage.getItem('sId');
			console.log("로그인한 아이디 " + id);
			
			$.ajax({
				data: {
					'member_id': id
				},
				url: "AlarmCheck",
				type: "GET",
				success: function(data) {
					console.log("DB에서 알람 가져오기 성공!");
					
// 					let date;
					let year;
					let month;
					let day;
					let hours;
					let minutes;
					let formattedTime;
// 					console.log("가져온 데이터 확인 : " + data[0].room_id);
					console.log("가져온 time 데이터 확인 : " + Date(data[0].time));
					
					
					for(let alarmItem of data) {
// 					console.log("alarmItem.time : " + alarmItem.time);
					console.log(alarmItem.time.date);
					console.log(alarmItem.time.time);
					let date2 = alarmItem.time.date;
					let time2 = alarmItem.time.time;
					year = date2.year;
					month = date2.month;
					day = date2.day;
					hours = time2.hour;
					minutes = time2.minute;
					//알림 시간 포맷
// 					let date = new Date(alarmItem.time);
// 					console.log("date : " + date);
					
					 // 연도, 월, 일, 시, 분을 추출
// 				    year = date.getFullYear() % 100; // 2024
// 				    month = date.getMonth() + 1; // 월은 0부터 시작하므로 +1 필요
// 				    day = date.getDate();
// 				    hours = date.getHours();
// 				    minutes = date.getMinutes();
// 					console.log("year : " + year + ", month : " + month + ", day : " + day + ", hours : " + hours + ", minutes : " + minutes);
					
				    // 원하는 형식으로 문자열을 생성
				    formattedTime = year + "년 " + month + "월 " + day + "일 " + hours + "시 " + minutes + "분";
					console.log("formattedTime : " + formattedTime);
						// 알림 목록 html 태그 작성함
						let divAlarm = "<li class='alarmItem'>" // alarmItem 시작
							divAlarm += 	"<div class='alarmLink'>" // alarmLink 시작
							divAlarm +=		 "<div class='alarmTitle'>" // alarmTitle 시작
							divAlarm += 		"<span class='alarmTime'>" // alarmTime 시작
							divAlarm += 			formattedTime
							divAlarm += 		"</span>" // alarmTime 끝
							divAlarm += 		"</div>" // alarmTitle 끝
							divAlarm +=		 "<div class='alarmContent'>" // alarmContent 시작
							divAlarm +=		 	alarmItem.sender_id
							divAlarm +=		 	" : "
							divAlarm +=		 	alarmItem.message
							divAlarm += 	"</div>" // alarmContent 끝
							divAlarm += 	"</div>" // alarmLink 끝
							divAlarm += "</li>" // alarmItem 끝
							
							
						$("#alarmList").append(divAlarm);
						$("#alarmPoint").css("display", "");
						

						//해당 채팅방 목록 div 태그에 더블클릭 이벤트 핸들링
						$(".alarmLink").on("click", function() {
							console.log("알림 목록 클릭 해 채팅창 열림!");
							window.open("ChatRoom?room_id=" + alarmItem.room_id + "&receiver_id=" 
										+ alarmItem.receiver_id + "&sender_id=" + alarmItem.sender_id 
//			 							+ "&status=" + msg.status
										,alarmItem.room_id, "width=600px, height=600px");
						});
					}
				}, //success 끝
				error: function(request,status,error) {
					alert("code:"+request.status+"\n"
							+"message:"+request.responseText+"\n"
							+"error:"+error);
	 				console.log("DB 가져오기 실패");
				}
			});
			
			
			
			
		} else { //알림창 닫기
			console.log("알림창 닫기!");
			$(".layer_box").css("display", "none");
			isAlarmListOpen = false;
		}
	}

	//정렬 목록이 열려있을 때 다른 곳을 누르면 목록 닫히게 하는 함수
	$(document).on("click", function(event) {
		let target = $(event.target);
		
		//클릭된 요소의 가장 가까운 조상 중 .alarmLi 및 .layer_box 클래스를 가진 요소가 있는지 확인
		//length는 존재여부 확인 - 선택된 요소의 개수를 반환하는 속성
		//length가 0이면 선택된 요소 개수가 없
		//클릭된 요소가 .alarmLi 클래스의 자식 요소가 아니고
		//.layer_box 클래스의 자식 요소가 아닐 때
		if(!target.closest(".alarmLi").length && !target.closest(".layer_box").length) {
			console.log("알림창 외부 클릭 - 알림창 닫습니다!");
			//.layer_box를 닫습니다.
			$(".layer_box").css("display", "none");
			//닫으니까 isAlarmListOpen(열림 상태)를 false로 변경
			isAlarmListOpen = false;
		}
	});
	
	
	//알림 메세지
// 	let alarmMessage;
// 	let ws2;
	
	//로그인했을 경우만 알림 가능하게 하기 - 세션아이디 유무 판별
	let receiver = sessionStorage.getItem('sId');
	if(receiver != "") { //로그인 O
		//웹소켓 주소 설정 - 알림창 동기 설정
		
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
					<li class="top_list alarmLi">
						<a class="top_link" id="top_link1" onclick="alarmListOpen()">알림
							<!-- 채팅 수신 시 알림 포인터 -->
							<span id="alarmPoint" style="display: none;">● </span>
						</a>
						<div class="layer_box" id="alram1" style="display: none;">
							<div class="box_content">
								<%@ include file="/WEB-INF/views/alarm/alarm_list.jsp"%>
<%-- 								<jsp:include page="/WEB-INF/views/alarm/alarm_list.jsp"></jsp:include> --%>
							</div>
						</div>
					</li>
					<li class="top_list">
					<!-- 채팅하기 새 창으로 열기 -->
					<!-- window.open 자바스크립트니까 javascript, 반환값 없으므로 void -->
					<!-- window.open(url, name(지정 시, 창 2개 열때 하나로 열수 있음), spec, ...) -->
					<c:choose>
						<c:when test="${not empty sessionScope.sId}">
							<a href="javascript:void(window.open('ChatList?receiver_id=' + '${sessionScope.sId}', '${sessionScope.sId}','width=600px,height=600px'))" class="top_link">
							채팅</a>
						</c:when>
						<c:when test="${empty sessionScope.sId}">
							<a href="ChatList" class="top_link">
							채팅</a>
						</c:when>
					</c:choose>
					</li>
<!-- 					<li class="top_list"> -->
<!-- 					채팅하기 새 창으로 열기 -->
<!-- 					window.open 자바스크립트니까 javascript, 반환값 없으므로 void -->
<!-- 					window.open(url, name(지정 시, 창 2개 열때 하나로 열수 있음), spec, ...) -->
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${not empty sessionScope.sId}"> --%>
<!-- 							<a href="javascript:void(window.open('ChatList?receiver_id=' + 'sender@naver.com', '','width=600px,height=600px'))" class="top_link"> -->
<!-- 							채팅(rec)</a> -->
<%-- 						</c:when> --%>
<%-- 						<c:when test="${empty sessionScope.sId}"> --%>
<!-- 							<a href="ChatList" class="top_link"> -->
<!-- 							채팅(rec)</a> -->
<%-- 						</c:when> --%>
<%-- 					</c:choose> --%>
<!-- 					</li> -->
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
				sendMessage("INIT_COMPLETE", "", data.receiver_id, "", "", "");
				
			} else if(data.type == "ERROR") { //채팅 관련 오류
				console.log("ERROR 타입 - 채팅 오류임!");

				//사용자에게 오류메세지 표시 및 이전 페이지로 돌아가기
				alert(data.message + "\n이전 페이지로 돌아갑니다.");
				history.back();
				
			} else if(data.type == "START") { //채팅방 추가
				console.log("START 타입 - 채팅방 추가!");
				if(data.pd_idx == "") {
					console.log("상세페이지에서 채팅 아님!");
					//채팅방 생성(표시) 및 채팅방 목록 표시
					//1. 채팅방 목록에 새 채팅방 추가를 위해 appendChatRoomToRoomList() 함수 호출
					//	(기존 대화내역이 없는 사용자와 채팅 시작 시 채팅방 목록에 새 채팅방 추가 위함)
					appendChatRoomToRoomList(JSON.parse(data.message));
				} else {
					
					//연결 완료 후 채팅창 생성
					createChatRoom(data);
					//기존 채팅 내역을 불러오기 위한 요청 전송
// 					sendMessage("REQUEST_CHAT_LIST", data.sender_id, data.receiver_id, data.room_id, "", data.pd_idx);
				}
				
			} else if(data.type == "REQUEST_CHAT_LIST") { //기존 채팅 메세지 내역 수신
				console.log("REQUEST_CHAT_LIST 타입 - 기존 메세지 수신!");
				console.log("data.message : " + data.message);
// 				console.log("data.message.size() : " + data.message.size());
				let objs = data.message;
				console.log("objs : " + objs);
// 				console.log("Object.values(objs).length : " + Object.values(objs).length);
				if(data.message.length > 2) {
					//기존 채팅 내역이 저장된 message 내의 리스트 반복하여
					//appendMessageToTargetRoom() 메서드 호출하여 메세지 표시
					for(let message of JSON.parse(data.message)) {
						appendMessageToTargetRoom(message.type, message.sender_id, message.receiver_id, message.room_id, message.message, message.send_time);
					}
				} else {
					//연결 완료 후 채팅창 생성
					createChatRoom(data);
				}
				
				
			} else if(data.type == "TALK") { //채팅 메세지 수신
				console.log("TALK 타입 - 채팅 메세지 수신!");

				//알림 창에 목록 추가
				appendMsgToAlarm(data);
			
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
		function sendMessage(type, sender_id, receiver_id, room_id, message, pd_idx) {
			// WebSocket 객체의 send() 메서드 호출하여 서버측으로 메세지 전송
			// => 전송할 메세지를 toJsonString() 함수를 통해 JSON 형식으로 변환하여 전송
			console.log("type : " + type +"sender_id : " + sender_id +"receiver_id : " + receiver_id +"room_id : " + room_id +"message : " + message +"pd_idx : " + pd_idx);
			ws.send(toJsonString(type, sender_id, receiver_id, room_id, message, pd_idx));
			console.log("보낸 메세지 : " + toJsonString(type, sender_id, receiver_id, room_id, message, pd_idx));
		}
// 		이ㅓ
			
		// ======================================================================
		// 알림 창에 목록 추가
		function appendMsgToAlarm(msg) {
			console.log("!!!!!!!!!!!알림 창에 목록 추가하는 appendMsgToAlarm 함수 호출됨!");
			console.log("appendMsgToAlarm에 넘어온 데이터 확인 : " + msg);
			console.log("room_id : " + msg.room_id + ", receiver_id : " + msg.receiver_id
					+ ", sender_id : " + msg.sender_id + ", status : " + msg.status);
			console.log("msg.send_time : " + msg.send_time);
	
			//알림 시간 포맷
			let date = new Date(msg.send_time);
			console.log("date : " + date);
			
			 // 연도, 월, 일, 시, 분을 추출
		    let year = date.getFullYear() % 100; // 2024
		    let month = date.getMonth() + 1; // 월은 0부터 시작하므로 +1 필요
		    let day = date.getDate();
		    let hours = date.getHours();
		    let minutes = date.getMinutes();
			console.log("year : " + year + ", month : " + month + ", day : " + day + ", hours : " + hours + ", minutes : " + minutes);
			
		    // 원하는 형식으로 문자열을 생성
		    let formattedTime = year + "년 " + month + "월 " + day + "일 " + hours + "시 " + minutes + "분";
			console.log("formattedTime : " + formattedTime);
			
			
			//알림 개수 제한
			// 알림 목록의 개수 구하기
			let alarmListCount = $(".alarmItem").length;
			console.log("클래스가 alarmItem인 요소의 개수 : " + alarmListCount);
			
			// 알림 목록 7개 넘어가면 오래된 알림 삭제
			if(alarmListCount > 7) {
				$(".alarmItem").last().remove();
				console.log("알림이 7개 넘어가면 오래된 알림 삭제함!");
			}
			
			// 알림 목록 html 태그 작성함
			let divAlarm = "<li class='alarmItem'>" // alarmItem 시작
				divAlarm += 	"<div class='alarmLink'>" // alarmLink 시작
				divAlarm +=		 "<div class='alarmTitle'>" // alarmTitle 시작
				divAlarm += 		"<span class='alarmTime'>" // alarmTime 시작
				divAlarm += 			formattedTime
				divAlarm += 		"</span>" // alarmTime 끝
				divAlarm += 		"</div>" // alarmTitle 끝
				divAlarm +=		 "<div class='alarmContent'>" // alarmContent 시작
				divAlarm +=		 	msg.sender_id
				divAlarm +=		 	" : "
				divAlarm +=		 	msg.message
				divAlarm += 	"</div>" // alarmContent 끝
				divAlarm += 	"</div>" // alarmLink 끝
				divAlarm += "</li>" // alarmItem 끝
				
				
			$("#alarmList").prepend(divAlarm);
			$("#alarmPoint").css("display", "");
			
			//해당 채팅방 목록 div 태그에 더블클릭 이벤트 핸들링
			$(".alarmLink").on("click", function() {
				console.log("알림 목록 클릭 해 채팅창 열림!");
				window.open("ChatRoom?room_id=" + msg.room_id + "&receiver_id=" 
							+ msg.receiver_id + "&sender_id=" + msg.sender_id 
// 							+ "&status=" + msg.status
							,msg.room_id, "width=600px, height=600px");
			});
		
			//알림 내용을 DB에 저장하기
			$.ajax({
				data: {
					'sender_id':msg.sender_id,
					'message': msg.message,
					'room_id': msg.room_id,
					'time': msg.send_time
				},
				url: "AlarmRemember",
				type: "POST",
				success: function(data) {
					console.log("성공한 boolean 값 : " + data);
					console.log("알림 내용 DB에 저장 성공!");
				},
				error: function(request, status, error) {
// 					alert("code:"+request.status+"\n"
// 							+"message:"+request.responseText+"\n"
// 							+"error:"+error);
	 				console.log("알림 내용 DB 저장 실패");
				}
			});
			
			
			
			
		} //appendMsgToAlarm 함수 끝
		
// 		// prepend 될 때마다 알림 표시
// 		function onItemPrepended() {
// 	        console.log("New item prepended.");
// 	        // 여기에서 추가된 항목에 대한 작업을 수행할 수 있습니다.
// 	        // 예를 들어, 새 항목에 클릭 이벤트를 추가하는 등.
// 	        $(".alarmItem").last().on('click', function() {
// 	            console.log("Alarm item clicked!");
// 	        });
		
		
// 		function openChatRoom() {
			
// 		}
		
		// ======================================================================
		// 알림 목록에 DB에 저장된 알림 가져오는 함수
// 		$(function() {
		
// 		});
			
// 		function appendMsgToAlarm(msg) {}
		
		
		
		
		
		
		// ======================================================================
		// 채팅방 목록 영역에 1개 채팅방 정보를 추가하는 함수
		function appendChatRoomToRoomList(room) {
			console.log("appendChatRoomToRoomList 호출됨!");
			
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
							+ "<div class='title'>" //title 시작
							+ title
							+ "</div>" //title 끝
							+ "<div class='message'>" //message 시작
							+ "<div class='message-avatar'>" //message-avatar 시작
							+ "<img src='https://ssl.pstatic.net/static/pwe/address/img_profile.png'>"
							+ "</div>" //message-avatar 끝
							+ "<div class='message-body'>" //message-body 시작
							+ "<div class='message-body-heading'>" //message-bod-heading 시작
							+ "<h5>"
							+ room.receiver_id
							+ "</h5>"
							+ "<span>"
							+ room.last_send_time
							+ "</span>"
							+ "</div>" //message-bod-heading 끝
							+ "<p>"
							+ room.last_message
							+ "</p>"
							+ "</div>" //message-body 끝
							+ "</div>" //message 끝
							+ "</div>";
							
				$("#chatRoomListArea").append(divRoom);
							
				//해당 채팅방 목록 div 태그에 더블클릭 이벤트 핸들링
				$(".chatRoomList." + room.room_id).on("dblclick", function() {
					console.log("채팅방 목록 더블클릭 해 채팅창 열림!");
					window.open("ChatRoom?room_id=" + room.room_id + "&receiver_id=" 
								+ room.receiver_id + "&sender_id=" + room.sender_id + "&status=" + room.status,
								room.room_id, "width=600px, height=600px");
				});
			}
		}
		
		// ======================================================================
		// 전달받은 메세지타입과 메세지를 JSON 형식 문자열로 변환하는 toJsonString() 함수
		function toJsonString(type, sender_id, receiver_id, room_id, message, pd_idx) {
			// 전달받은 파라미터들을 하나의 객체로 묶어 JSON 타입 문자열로 변환 후 리턴
			let data = {
				type : type,
				sender_id : sender_id,
				receiver_id : receiver_id,
				room_id : room_id,
				message : message,
				pd_idx : pd_idx
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


