package com.itwillbs.retech_proj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.ChatMapper;
import com.itwillbs.retech_proj.vo.ChatMessage;
import com.itwillbs.retech_proj.vo.ChatRoom;

@Service
public class ChatService {
	@Autowired
	private ChatMapper mapper;
	
	//기존 채팅방 목록 조회
	public List<ChatRoom> getChatRoomList(String sender_id) {
		return mapper.selectChatRoomList(sender_id);
	}

	//기존 채팅방 존재 여부 확인을 위한 1개 채팅방 정보 조회
	public ChatRoom getChatRoom(String sender_id, String receiver_id, int pd_idx) {
		return mapper.selectChatRoom(sender_id, receiver_id, pd_idx);
	}

	//새 채팅방 생성(추가)
	public void addChatRoom(List<ChatRoom> chatRoomList) {
		mapper.insertChatRoom(chatRoomList);
	}

	//기존 채팅 내역 조회
	public List<ChatMessage> getChatMessageList(String room_id) {
		return mapper.selectChatMessageList(room_id);
	}

	//채팅 메세지 저장
	public void addChatMessage(ChatMessage chatMessage) {
		mapper.insertChatMessage(chatMessage);
	}

	//채팅방 종료
	public void quitChatRoom(String room_id, String sender_id) {
		mapper.updateChatRoomStatusForQuitRoom(room_id, sender_id);
	}

	//채팅방 목록에 띄울 날짜, 마지막메세지 조회
	public Map<String, String> getLastInfo(String sender_id, String receiver_id) {
		return mapper.selectLastInfo(sender_id, receiver_id);
	}

	//DB에 알람 정보 저장하기
	public boolean insertAlarm(Map<String, String> alarmInfo) {
		return mapper.insertAlarm(alarmInfo);
	}

	//DB에서 알람 가져오기
	public List<HashMap<String, Object>> getAlarmList(Map<String, String> map) {
		return mapper.selectAlarm(map);
	}

}
