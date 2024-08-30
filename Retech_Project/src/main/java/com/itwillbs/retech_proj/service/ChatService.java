package com.itwillbs.retech_proj.service;

import java.util.List;

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
	public ChatRoom getChatRoom(String sender_id, String receiver_id) {
		return mapper.selectChatRoom(sender_id, receiver_id);
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

}
