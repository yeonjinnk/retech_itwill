package com.itwillbs.retech_proj.handler;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.itwillbs.retech_proj.service.ChatService;
import com.itwillbs.retech_proj.service.MemberService;
import com.itwillbs.retech_proj.vo.ChatMessage;
import com.itwillbs.retech_proj.vo.ChatRoom;

public class WebSocketHandler extends TextWebSocketHandler {

	//=====================================================================================================
	
	//접속한 클라이언트(사용자)들에 대한 정보를 저장하기 위한 Map 객체 생성
	//key : 웹소켓 세션 아이디(문자열)
	//value : 웹소켓 세션 객체(WebSocketSession 타입 객체)
	//멀티쓰레딩 환경에서 락을 통해 안전하게 데이터 접근 위해 HashMap 대신 ConcurrentHashMap 타입 사용
	private Map<String, WebSocketSession> userSessions = new ConcurrentHashMap<String, WebSocketSession>();
	//------------------------------------------------------------------------------------------------------
	//접속한 사용자의 아이디와 WebSocketSession 객체 아이디 관리할 Map 객체 생성
	//웹소켓은 페이지 이동시 갱신되므로 sId 속성값과 연결
	//=> 사용자 아이디 통해 상대방의 WebSocketSession 객체에 접근 가능
	//key : HttpSession 세션 아이디(문자열)
	//value : 웹소켓 세션 객체(WebSocketSession 타입 객체)
	private Map<String, String> users = new ConcurrentHashMap<String, String>();
	//------------------------------------------------------------------------------------------------------
	//JSON 데이터 파싱 작업을 처리할 Gson 객체 생성
	private Gson gson = new Gson();
	//------------------------------------------------------------------------------------------------------
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ChatService chatService;
	//=====================================================================================================
	
	//WebSocketSession 객체에서 HttpSession 객체의 세션 아이디 꺼내서 리턴하는 메서드
	private String getHttpSessionId(WebSocketSession session) {
//		System.out.println("session : " + session);
//			//session : StandardWebSocketSession[id=64c2ffc1-ad82-d58c-0597-4c067a4f24b1, uri=ws://localhost:8081/retech_proj/echo]
//		System.out.println("session.getAttributes() : " + session.getAttributes());
//			//session.getAttributes() : {sNickName=관리자, HTTP.SESSION.ID=9EB9CC749657555EE20E7706DDB51FB7, sName=관리자, sIsAdmin=Y, sId=admin@naver.com}
//		System.out.println("session.getAttributes().get(\"sId\") : " + session.getAttributes().get("sId"));
//			//session.getAttributes().get("sId") : admin@naver.com
//		System.out.println("session.getAttributes().get(\"sId\").toString() : " + session.getAttributes().get("sId").toString());
//			//session.getAttributes().get("sId").toString() : admin@naver.com

		//session에서 map객체로 꺼내고(getAttributes) key를 찾아서(get("sId")) Object를 String으로 변환
		return session.getAttributes().get("sId").toString();
	}
	//------------------------------------------------------------------------------------------------------
	//WebSocketSession 객체에서 WebSocketSession 객체의 아이디 꺼내서 리턴하는 메서드
	private String getWebSocketSessionId(WebSocketSession session) {
		return session.getId();
	}
	
	// 현재 시스템의 날짜 및 시각 정보를 yyyy-MM-dd HH:mm:ss 형태로 변환하여 리턴하는 메서드
	private String getDateTimeForNow() {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
		System.out.println("시스템 시간날짜 구하기 위한 getDateTimeForNow 호출됨!");
		System.out.println("시스템 시간은 얼마일까요 : " + LocalDateTime.now().format(dtf));
		return LocalDateTime.now().format(dtf);
	}
	
	//(서버 -> 클라이언트)
	//각 웹소켓 세션(채팅방 사용자)들에게 메세지를 전송하는 sendMessage() 메서드
	public void sendMessage(WebSocketSession session, ChatMessage chatMessage) throws Exception{
		//chatmessage 객체를 JSON 문자열로 변환하여 클라이언트측으로 전송
		//자바스크립트 웹소켓 이벤트 중 onmessage 이벤트에 의한 onMessage() 함수 호출됨
		session.sendMessage(new TextMessage(gson.toJson(chatMessage)));
	}
	
	//룸아이디 생성을 위한 getRoomId() 메서드 정의
	private String getRoomId() {
		return UUID.randomUUID().toString();
	}
	//=====================================================================================================
	
	//------------------------------------------------------------------------------------------------------
	//웹소켓을 통해 통신을 수행하는 과정에서 자동으로 호출될 메서드를 오버라이딩
	
	//1) 최초 웹소켓 연결 시 스프링에서도 WebSocket 관련 객체가 생성되며, 이 때 자동으로 호출되는 메서드
	//top.jsp의 connect() 함수 websocket 객체 생성 시 자동 호출
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("웹소켓 연결됨(afterConnectionEstablished)");
		
		//userSessions Map 객체에 저장
		//key : 웹소켓 세션아이디, value : 웹소켓 세션
		userSessions.put(getWebSocketSessionId(session), session);
		
		//users Map 객체에 저장
		//key : HttpSession 아이디, value : 웹소켓 세션아이디
		users.put(getHttpSessionId(session), getWebSocketSessionId(session));
		
		System.out.println("저장한 userSessions : " + userSessions); //저장한 userSessions : {64c2ffc1-ad82-d58c-0597-4c067a4f24b1=StandardWebSocketSession[id=64c2ffc1-ad82-d58c-0597-4c067a4f24b1, uri=ws://localhost:8081/retech_proj/echo]}

		System.out.println("저장한 users : " + users); //저장한 users : {admin@naver.com=64c2ffc1-ad82-d58c-0597-4c067a4f24b1}
		
		//keySet : Map객체의 key만..
		System.out.println("클라이언트 목록(" + userSessions.keySet().size() + "명) : " + userSessions); //클라이언트 목록(1명) : {64c2ffc1-ad82-d58c-0597-4c067a4f24b1=StandardWebSocketSession[id=64c2ffc1-ad82-d58c-0597-4c067a4f24b1, uri=ws://localhost:8081/retech_proj/echo]}

		System.out.println("사용자 목록(" + users.keySet().size() + "명) : " + users); //사용자 목록(1명) : {admin@naver.com=64c2ffc1-ad82-d58c-0597-4c067a4f24b1}

		
	}

	//메세지 수신 시 자동으로 호출되는 메서드
	//top.jsp의 sendMessage 통해 수신됨(JSON 형식 문자열)
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("메세지 수신됨(handleTextMessage)");
		System.out.println("수신된 메세지 : " + message.getPayload()); //수신된 메세지 : {"type":"INIT","sender_id":"","receiver_id":"receiver@naver.com","room_id":"","message":""}
		
		// 수신된 메세지(JSON 형식 문자열)를 ChatMessage 타입 객체로 변환 => gson.fromJson() 활용
		ChatMessage chatMessage = gson.fromJson(message.getPayload(), ChatMessage.class);
		System.out.println("chatMessage : " + chatMessage); //chatMessage : ChatMessage(type=INIT, sender_id=, receiver_id=receiver@naver.com, room_id=, message=, send_time=null)
		System.out.println("메세지 수신 시각 : " + getDateTimeForNow()); //메세지 수신 시각 : 2024-08-29T20:23:36
		// -----------------------------------------------------------------------------------
		// 송신자 아이디와 수신자 아이디를 가져와서 변수에 저장
		String sender_id = getHttpSessionId(session);
		String receiver_id = chatMessage.getReceiver_id();
		System.out.println("송신자 : " + sender_id + ", 수신자 : " + receiver_id);
		
		// ChatMessage 객체에 송신자 아이디 설정
		chatMessage.setSender_id(sender_id);
		
		// -----------------------------------------------------------------------------------
		// 수신된 메세지 타입 판별
		
		//1. 채팅페이지 초기 진입
		// -> 기존 채팅방 목록 조회 후 전송
		if(chatMessage.getType().equals(ChatMessage.TYPE_INIT)) { // 채팅페이지 초기 진입 메세지
			// DB 에 저장된 기존 채팅방 목록(= 자신의 아이디가 포함된 채팅) 조회 후 목록 전송
			List<ChatRoom> chatRoomList = chatService.getChatRoomList(sender_id);
			System.out.println("기존 채팅방 목록 : " + chatRoomList);
			
			chatMessage.setReceiver_id("");
			//조회 결과를 JSON 형식으로 변환하여 메세지로 설정
			chatMessage.setMessage(gson.toJson(chatRoomList));
			
			//(서버->클라이언트) 
			//메세지 전송
			sendMessage(session, chatMessage);
			
			System.out.println("INIT : 기존 채팅방 목록 조회 후 전송함");
			System.out.println("보내는 메세지 : " + chatMessage);
		// -----------------------------------------------------------------------------------
		//2. 채팅페이지 초기화 완료
		//기본) 상대방 있고 접속해 있으면 채팅방 목록에 생성해 띄움.
		//그 외에는 오류메세지나 채팅방 목록 띄우지 않음.
		} else if(chatMessage.getType().equals(ChatMessage.TYPE_INIT_COMPLETE)) {
			
			//1. 메세지에 수신자 포함 여부
			// 1-A. 수신자 O -> 2번
			// 1-B. 수신자 X -> 메세지 전송 X
			
			//2. 상대방 접속 여부
			// 2-A. 접속 O -> 4번
			// 2-B. 접속 X -> 3번
			
			//3. DB에 상대방 ID 검색
			// 3-A. 존재 O -> 4번
			// 3-B. 존재 X -> 오류메세지 전송
			
			//4. 채팅방 조회
			// 4-A. 기존 채팅방 O -> 6번
			// 4-B. 기존 채팅방 X -> 5. 채팅방 생성
			
			//5. 채팅방 생성
			// 5-1. 방번호 생성
			// 5-2. 송신자 수신자 각각 생성해서 2개의 채팅방 생성
			
			//6. 메세지 설정 및 전송
			// 6-1. 설정) 채팅 시작 위한 START 타입 설정
			// 6-2. 설정) 채팅방 정보 설정(룸아이디, 방제목, 송신자, 수신자, 상태값)
			// 6-3. 전송) 메세지 전송(sendMessage)
			
			//---------------------------------------------------------------------------------------------------------------------------
			
			//1. 메세지에 수신자 포함 여부
			//receiver.id 가 "" 인지 아닌지
			
			// 1-A. 수신자 O -> 2번
			if(!receiver_id.equals("")) {
				System.out.println("1-A. 수신자 아이디 있음!");
				
				//2. 상대방 접속 여부
				//users.get(receiver_id) 가 null인지 아닌지
				
				// 2-B. 접속 X -> 3번
				if(users.get(receiver_id) == null) {
					System.out.println("2-B. 수신자 접속 X -> 3. DB에 수신자 검색!");
					
					//3. DB에 상대방 ID 검색
					//member 테이블에서 receiver_id와 같은 member_id 검색
					
					String dbReceiverId = memberService.getMemberId(receiver_id);
					
					// 3-B. 존재 X -> 오류메세지 전송
					if(dbReceiverId == null) {
						System.out.println("3-B. DB에 수신자 ID X -> 오류메세지 전송!");
						
						//메세지 설정
						//ChatMessage(type, sender_id, receiver_id, room_id, message, send_time)
						ChatMessage errorMessage = new ChatMessage(ChatMessage.TYPE_ERROR, "", sender_id, "", "사용자가 존재하지 않습니다!", "", "");
						
						//(서버 -> 클라이언트) 메세지 전송
						sendMessage(session, errorMessage);
						System.out.println("INIT_COMPLETE : DB에 수신자 X -> 오류메세지 전송!");
						System.out.println("보내는 메세지 : " + chatMessage);

					} // 3-B 끝.
					
					System.out.println("3-A. 존재 O -> 4번 채팅방 조회함!");
				} // 2-B 끝.
				
				//4. 채팅방 조회
				//상대방 존재할 경우 신규 or 기존 채팅방 표시
				
				//상대방과의 기존 채팅방 존재 여부 확인
				ChatRoom chatRoom = chatService.getChatRoom(sender_id, receiver_id);
				System.out.println("4. 채팅방 조회함!");
				
				// 4-B. 기존 채팅방 X -> 5. 채팅방 생성
				if(chatRoom == null) {
					System.out.println("4-B. 기존 채팅방 X -> 5. 채팅방 생성 필요");
					
					//5. 채팅방 생성
					System.out.println("5. 채팅방 생성 시작함!");
					
					// 5-1. 방번호 생성
					chatMessage.setRoom_id(getRoomId());
					System.out.println("5-1. 방번호 생성 후 채팅메세지 : " + chatMessage);
					
					
					// 5-2. 송신자 수신자 각각 생성해서 2개의 채팅방 생성
					//List 객체에 추가
					List<ChatRoom> chatRoomList = new ArrayList<ChatRoom>();
					
					//chatRoom(room_id, title, sender_id, receiver_id, status)
					//송신자 채팅방
					chatRoomList.add(new ChatRoom(chatMessage.getRoom_id(), "상대방 id : " + receiver_id, sender_id, receiver_id, 1, "", ""));
					//수신자 채팅방
					chatRoomList.add(new ChatRoom(chatMessage.getRoom_id(), "상대방 id : " + sender_id, receiver_id, sender_id, 1, "", ""));
					
					System.out.println("5-1. 생성한 채팅방 리스트 chatRoomList : " + chatRoomList);
					//송,수신자 채팅방 총 2개 DB에 저장
					chatService.addChatRoom(chatRoomList);
					
					//6. 메세지 설정 및 전송
					// 6-1. 설정) 채팅 시작 위한 START 타입 설정
					chatMessage.setType(ChatMessage.TYPE_START);
					
					// 6-2. 설정) 채팅방 정보 설정(룸아이디, 방제목, 송신자, 수신자, 상태값)
					// 조회된 채팅방 정보(chatRoom 객체)를 JSON으로 변환하여 저장
					chatRoom = chatRoomList.get(0);
					chatMessage.setMessage(gson.toJson(chatRoom));
					
					// 6-3. 전송) 메세지 전송(sendMessage)
					sendMessage(session, chatMessage);
					System.out.println("INIT_COMPLETE : 상대방과 기존 채팅방 없으므로 채팅방 생성 후 전송!");
					System.out.println("보내는 메세지 : " + chatMessage);

					
				} else {
					// 4-A. 기존 채팅방 O -> 6. 채팅방 조회 
					System.out.println("4-A. 기존 채팅방 O -> 6. 채팅방 조회!");
					
					//채팅방 목록에 띄울 날짜, 마지막메세지 조회
					Map<String, String> lastInfo = chatService.getLastInfo(sender_id, receiver_id);
					System.out.println("마지막 정보 조회 : " + lastInfo);
					if(lastInfo != null) { //마지막 메세지 있을 때
						System.out.println("마지막 메세지 있음!");
						chatRoom.setLast_message(lastInfo.get("message"));
						chatRoom.setLast_send_time(lastInfo.get("send_time"));
						
						//조회된 룸 아이디 저장
						chatMessage.setRoom_id(chatRoom.getRoom_id());
						
						//6. 메세지 설정 및 전송
						// 6-1. 설정) 채팅 시작 위한 START 타입 설정
						chatMessage.setType(ChatMessage.TYPE_START);
						
						// 6-2. 설정) 채팅방 정보 설정(룸아이디, 방제목, 송신자, 수신자, 상태값)
						// 조회된 채팅방 정보(chatRoom 객체)를 JSON으로 변환하여 저장
						chatMessage.setMessage(gson.toJson(chatRoom));
						
						// 6-3. 전송) 메세지 전송(sendMessage)
						sendMessage(session, chatMessage);
						System.out.println("INIT_COMPLETE : 상대방과 채팅방 있으므로 기존 채팅방 전송!");
						System.out.println("보내는 메세지 : " + chatMessage);
						
					} else {
						System.out.println("마지막 메세지 없음!");
						//6. 메세지 설정 및 전송
						// 6-1. 설정) 채팅 시작 위한 START 타입 설정
						chatMessage.setType(ChatMessage.TYPE_START);
						
						
						//조회된 룸 아이디 저장
						chatMessage.setRoom_id(chatRoom.getRoom_id());
//						// 6-2. 설정) 채팅방 정보 설정(룸아이디, 방제목, 송신자, 수신자, 상태값)
//						// 조회된 채팅방 정보(chatRoom 객체)를 JSON으로 변환하여 저장
//						chatRoom = chatRoomList.get(0);
//						chatMessage.setMessage(gson.toJson(chatRoom));
						
						// 6-3. 전송) 메세지 전송(sendMessage)
						sendMessage(session, chatMessage);
//						System.out.println("INIT_COMPLETE : 상대방과 기존 채팅방 없으므로 채팅방 생성 후 전송!");
						System.out.println("보내는 메세지 : " + chatMessage);
						
					}

				}
				
			} else {
				// 1-B. 수신자 X -> 메세지 전송 X
				System.out.println("1-B. 수신자 아이디 없음! - 메세지 전송 X");
			}
			
		// -----------------------------------------------------------------------------------
		//3. 채팅 내역 전송
		} else if(chatMessage.getType().equals(ChatMessage.TYPE_REQUEST_CHAT_LIST)) {
			
			//기존 채팅 내역 조회 요청
			List<ChatMessage> chatMessageList = chatService.getChatMessageList(chatMessage.getRoom_id());
			
			//기존 채팅 내역 존재할 경우에만 클라이언트측으로 전송
//			if(chatMessageList.size() > 0) {
				//채팅 내역을 JSON 형식으로 변환하여 메세지로 전송
				chatMessage.setMessage(gson.toJson(chatMessageList));
				sendMessage(session, chatMessage);
				
				System.out.println("REQUEST_CHAT_LIST : 기존 채팅 내역 전송함!");
				System.out.println("보내는 메세지 : " + chatMessage);

//			}
		} else if(chatMessage.getType().equals(ChatMessage.TYPE_TALK)) {
		// -----------------------------------------------------------------------------------
		//4. 뷰페이지에 입력한 채팅 내역 DB에 저장 및 수신자에게 입력받은 채팅 전송
			
			//현재 시스템 날짜 및 시각 정보 저장하기
			chatMessage.setSend_time(getDateTimeForNow());
			
			//알림 타입 설정
//			chatMessage.setAlarm(ChatMessage.ALARM_RECEIVE);
			
			System.out.println("대화내용 저장 위해 addChatMessage 메서드 호출함!");
			//채팅 메세지 DB 저장 요청
			chatService.addChatMessage(chatMessage);
			
			System.out.println("대화 저장함!");
			//채팅 메세지 전송할 사용자 확인(user 객체에 receiver_id를 통해 판별
			if(users.get(receiver_id) != null) { //현재 수신자가 접속해 있을 경우
				
				//수신자에게 메세지 보내야 하기에 수신자의 웹소켓을 가져와야 함.
				
				//탐색된 receiver_id에 해당하는 웹소켓 세션 객체의 세션 아이디를 활용하여
				//userSessions 객체의 웹소켓 세션 객체를 가져와서 메세지 전송 요청
				WebSocketSession receiver_ws = userSessions.get(users.get(receiver_id));
				
				sendMessage(receiver_ws, chatMessage);
				System.out.println("TALK : 입력받은 채팅 DB 저장 & 수신자에게 메세지 전송함!");
				System.out.println("보내는 메세지 : " + chatMessage);


			} else {
				System.out.println("수신자가 접속해 있지 않음!");
			}
			
		} else if(chatMessage.getType().equals(ChatMessage.TYPE_LEAVE)) {
		// -----------------------------------------------------------------------------------
		//5. 채팅방 종료
			
			//채팅방 상태값 변경(자신 = 0, 상대방 = 2)
			chatService.quitChatRoom(chatMessage.getRoom_id(), chatMessage.getSender_id());
			
			//현재 시스템 날짜 및 시각 정보 저장하기
			chatMessage.setSend_time(getDateTimeForNow());
			
			//나갔습니다 메세지 저장
			chatMessage.setMessage(chatMessage.getSender_id() + " 님이 나갔습니다.");
			
			//채팅 메세지 DB 저장 요청
			chatService.addChatMessage(chatMessage);
			
			//채팅 종료 신호를 상대방에게도 전달
			//채팅 메세지 전송할 사용자 확인
			//user 객체에 receiver_id를 통해 판별
			if(users.get(receiver_id) != null) { //현재 수신자가 접속해 있을 경우
				//탐색된 receiver_id에 해당하는 웹소켓 세션 객체의 세션 아이디를 활용하여
				//userSessions 객체의 웹소켓 세션 객체를 가져와서 메세지 전송 요청
				WebSocketSession receiver_ws = userSessions.get(users.get(receiver_id));
				
				sendMessage(receiver_ws, chatMessage);
				System.out.println("LEAVE : 채팅방 상태값 변경 & 나갔습니다 메세지 저장 & 상대방에게도 퇴장 전송!");
				System.out.println("보내는 메세지 : " + chatMessage);

			}
		}
	}

	//
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("웹소켓 오류 발생(handleTransportError)");
	}

	//웹소켓 연결 해제 시 자동으로 호출되는 메서드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("웹소켓 연결 해제됨(afterConnectionClosed)");
		
		//클라이언트 정보가 저장된 Map 객체(userSessions) 내에서
		//종료 요청이 발생한 웹소켓 세션 객체 제거
		//Map 객체의 remove() 메서드 호출하여 전달받은 WebSocketSession 객체의 아이디를 키로 지정
		userSessions.remove(getWebSocketSessionId(session));
		
		//사용자 정보가 저장된 Map 객체(users) 내에서
		//종료 요청이 발생한 웹소켓의 세션 아이디 제거(널스트링으로 변경)
		//Map객체의 remove() 메서드 호출하여 HttpSession 객체의 세션 아이디를 키로 지정
		//단, HttpSession 객체의 세션 아이디(users의 키)는 유지
		users.put(getHttpSessionId(session), "");
		
		System.out.println("클라이언트 목록(" + userSessions.keySet().size() + "명) : " + userSessions);
		System.out.println("사용자 목록(" + users.keySet().size() + "명) : " + users);
	}

	
	
}
