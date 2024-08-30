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
		return LocalDateTime.now().format(dtf);
	}
	
	//각 웹소켓 세션(채팅방 사용자)들에게 메세지를 전송하는 sendMessage() 메서드
	public void sendMessage(WebSocketSession session, ChatMessage chatMessage) throws Exception {
		//ChatMessage 객체를 JSON 문자열로 변환하여 클라이언트측으로 전송
		//자바스크립트 웹소켓 이벤트 중 ONMESSAGE 이벤트에 의한 onMessage() 함수 호출됨
		session.sendMessage(new TextMessage(gson.toJson(chatMessage)));
	}
	
	//룸 아이디 생성을 위한 getRoomId() 메서드 정의
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
		
		//INIT -> 기존 채팅방 있는지 확인 후, 있으면 기존 채팅방 목록 메세지에 추가해 전송
		if(chatMessage.getType().equals(ChatMessage.TYPE_INIT)) { // 채팅페이지 초기 진입 메세지
			System.out.println("!!!!!!! 채팅 메세지 타입 INIT !!!!!!!");
			// DB 에 저장된 기존 채팅방 목록(= 자신의 아이디가 포함된 채팅) 조회 후 목록 전송
			List<ChatRoom> chatRoomList = chatService.getChatRoomList(sender_id);
			System.out.println("기존 채팅방 목록 : " + chatRoomList);
			
			//조회 결과를 JSON 형식으로 변환하여 메세지로 설정
			chatMessage.setMessage(gson.toJson(chatRoomList));
			
			//sendMessage() 메서드 호출하여 클라이언트측으로 메세지 전송
			sendMessage(session, chatMessage);
			
		} else if(chatMessage.getType().equals(ChatMessage.TYPE_INIT_COMPLETE)) {
			System.out.println("!!!!!!! 채팅 메세지 타입 INIT_COMPLETE !!!!!!!");
			//채팅페이지 초기화 완료 메시지
			
			//--------------------------------------------------------------
			//1. 메세지에 수신자 아이디(receiver_id) 존재 유무
			//	A. 있으면 -> 2번
			//	B. 없으면 -> 채팅방 목록만 표시
			
			//2. 사용자(receiver_id) 접속 유무
			//	A. 접속 o -> 3번
			//	B. 접속 x -> 3번
			
			//3. DB에 상대방 아이디(dbReceiverId) 존재 여부
			// A. 존재 O -> 4번
			// B. 존재 X -> (서버 -> 클라이언트)오류메시지 전송
			
			//4. 기존 채팅방 존재 여부
			// A. 기존 채팅방 O -> 5-A번
			// B. 기존 채팅방 X -> 5-B번
			
			//5. 채팅방 작업
			// A. 채팅방 생성
			// B. 기존 채팅방 정보 가져오기
			
			//6. 메세지에 채팅방 및 추가 정보 설정
			// A. 다음 단계 위해 TYPE_START 메세지에 세팅
			// B. 기존 채팅방 및 생성한 채팅방 정보 메세지에 세팅
			
			//7. (서버 -> 클라이언트)메세지 전송
			//--------------------------------------------------------------
			
			//초기화 완료 메세지의 수신자 포함 여부 판별
			//1-A. 수신자 아이디(receiver_id) O
			if(!receiver_id.equals("")) {
				System.out.println("1-A. 수신자 아이디 있음!");
				
				//접속중 판별 위해 httpsessionid 필요 -> users에 저장되어 있음
				boolean isConnectUser = users.get(receiver_id) == null ? false : true;
				
				//2-B. 사용자 접속중 X
				if(!isConnectUser) {
					System.out.println("2-B. 사용자 접속 안함!");
					// DB에 (receiver_id)에 해당하는 ID 존재 판별 위해 아이디 조회
					String dbReceiverId = memberService.getMemberSearchId(receiver_id);
					
					//3-B. DB에 상대방 아이디 존재X
					if(dbReceiverId == null) {
						System.out.println("3-B. 상대방 아이디 존재하지 않음!");
						//(서버 -> 클라이언트)오류메시지 전송
						
						//메세지 세팅
						//ChatMessage(type, sender_id, receiver_id, room_id, message, send_time)
						
						//type : error, sender_id : 서버니까 "", receiver_id : 받는사람 sender, room_id : 없으니까 "", message : 에러메세지, send_time : 메세지 송수신시만 ""
						ChatMessage errorMessage = new ChatMessage
								(ChatMessage.TYPE_ERROR, "", sender_id, "", "사용자가 존재하지 않습니다!", "");
						
						//메세지 전송
						sendMessage(session, chatMessage);
						System.out.println("상대방 아이디 존재하지 않으므로 에러 메세지 전송함");
						return;
					} 
				} //2-A. 사용자(receiver_id) 접속중 O
				System.out.println("2-A. 사용자 접속 중임");
					//3-A. DB에 상대방 아이디 존재O 
					System.out.println("3-A. 상대방 아이디 존재함!");
					
					//상대방 존재할 경우 채팅방 표시(신규 채팅방 or 기존 채팅방)
					//4. 기존 채팅방 존재 여부 판별
					ChatRoom chatRoom = chatService.getChatRoom(sender_id, receiver_id);
					
					//4-B. 기존 채팅방 X
					if(chatRoom == null) {
						System.out.println("4-B. 기존 채팅방 없음 - 5-A. 새로운 채팅방 생성!");
						
						//5-A. 채팅방 생성
						
						//1) 방번호(room_id) 생성
						chatMessage.setRoom_id(getRoomId());
						System.out.println("5-A-1. 방번호 생성 후 채팅 메세지 chatMessage : " + chatMessage);
						
						//2) 새 채팅방 정보 저장을 위해 채팅방 담을 List 객체 생성
						//1개의 채팅방 정보(룸아이디, 제목, 사용자아이디, 상태)를 갖는 
						//ChatRoom 객체를 송신자와 수신자 각각에 대해 생성하여 List 객체에 추가
						List<ChatRoom> chatRoomList = new ArrayList<ChatRoom>();
						
						//3) List 객체에 채팅방 정보 추가
						//status 값은 정상적인 채팅방 표시로 1 전달
						//a) sender 측 채팅방 - receiver 님과의 대화
						chatRoomList.add(new ChatRoom(chatMessage.getRoom_id(), receiver_id + "님과의 대화", sender_id, receiver_id, 1));
						//b) receiver 측 채팅방 - sender 님과의 대화
						chatRoomList.add(new ChatRoom(chatMessage.getRoom_id(), sender_id + "님과의 대화", receiver_id, sender_id, 1));
						
						System.out.println("chatRoomList : " + chatRoomList);
						
						//3) 새 채팅방 정보(List)를 DB에 저장
						chatService.addChatRoom(chatRoomList);
						
						//6. 메세지에 채팅방 및 추가 정보 설정
						//6-A. 다음 단계 위해 TYPE_START 메세지에 세팅
						chatMessage.setType(ChatMessage.TYPE_START);
						
						//6-B. 생성한 채팅방 정보 메세지에 세팅
						//sender 측 채팅방을 보내야 함 그래서 index가 0
						chatRoom = chatRoomList.get(0);
						System.out.println("6-B. 생성한 chatRoom : " + chatRoom);
						chatMessage.setMessage(gson.toJson(chatRoom));
						
						//7. (서버 -> 클라이언트)메세지 전송
						sendMessage(session, chatMessage);
						System.out.println("7. 기존 채팅방 없을 시 생성한 chatRoom 정보 메세지 전송함");
					} else { //4-A. 기존 채팅방 O
						System.out.println("4-A. 기존 채팅방 있음! - 새로운 채팅방 생성 불필요!");
						
						//기존 채팅방이 존재하므로 DB 작업은 불필요
						//5-B. 기존 채팅방 정보 가져오기
						//6. 메세지에 채팅방 및 추가 정보 설정
						//채팅 메세지 객체 정보 설정
						//조회된 룸 아이디 저장
						chatMessage.setRoom_id(chatRoom.getRoom_id());
						
						//채팅 시작을 위한 START 타입 설정
						//6-A. 다음 단계 위해 TYPE_START 메세지에 세팅
						chatMessage.setType(ChatMessage.TYPE_START);
						
						//6-B. 기존 채팅방 정보 메세지에 세팅
						// => 조회된 채팅방 정보(ChatRoom 객체)를 JSON 으로 변환하여 저장
						chatMessage.setMessage(gson.toJson(chatRoom));
						
						//7. (서버 -> 클라이언트)메세지 전송
						sendMessage(session, chatMessage);
						System.out.println("7. 기존 채팅방 있을 시 조회한 chatRoom 정보 메세지 전송함");
					}
			//1-A. 수신자 아이디(receiver_id) X
			} else {
				//수신자 아이디 없을 경우 채팅방 목록만 표시하면 되므로
				//실제로는 else문 자체가 불필요
				System.out.println("1-B. 수신자 아이디 없음!");
			}
		} else if(chatMessage.getType().equals(ChatMessage.TYPE_REQUEST_CHAT_LIST)) {
			System.out.println("!!!!!!! 채팅 메세지 타입 REQUEST_CHAT_LIST !!!!!!!");

			//기존 채팅 내역 불러오기
			List<ChatMessage> chatMessageList = chatService.getChatMessageList(chatMessage.getRoom_id());
			
			//기존 채팅 내역 존재할 경우에만 클라이언트측으로 전송
			if(chatMessageList.size() > 0) {
				//채팅 내역을 JSON 형식으로 변환하여 메세지로 전송
				chatMessage.setMessage(gson.toJson(chatMessageList));
				sendMessage(session, chatMessage);
			}
		} else if(chatMessage.getType().equals(ChatMessage.TYPE_TALK)) {
			System.out.println("!!!!!!! 채팅 메세지 타입 TALK !!!!!!!");

			//채팅 메세지 DB 저장 요청
			chatService.addChatMessage(chatMessage);
			
			//현재 수신자가 접속해 있을 경우 상대방에게도 메세지 전송
			if(users.get(receiver_id) != null) { 
				//탐색된 receiver_id 에 해당하는 웹소켓 세션 객체의 세션 아이디를 활용하여
				//userSessions 객체의 웹소켓 세션 객체를 가져와서 메세지 전송 요청
				WebSocketSession receiver_ws = userSessions.get(users.get(receiver_id));
				
				sendMessage(receiver_ws, chatMessage);
				
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
	}

	
	
}
