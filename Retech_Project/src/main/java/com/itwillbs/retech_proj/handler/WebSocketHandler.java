package com.itwillbs.retech_proj.handler;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
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
		if(chatMessage.getType().equals(ChatMessage.TYPE_INIT)) { // 채팅페이지 초기 진입 메세지
			// DB 에 저장된 기존 채팅방 목록(= 자신의 아이디가 포함된 채팅) 조회 후 목록 전송
			List<ChatRoom> chatRoomList = chatService.getChatRoomList(sender_id);
			System.out.println("기존 채팅방 목록 : " + chatRoomList);
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
