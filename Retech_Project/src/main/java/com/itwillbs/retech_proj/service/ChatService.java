package com.itwillbs.retech_proj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.ChatMapper;
import com.itwillbs.retech_proj.vo.ChatRoom;

@Service
public class ChatService {
	@Autowired
	private ChatMapper mapper;
	
	//기존 채팅방 목록 조회
	public List<ChatRoom> getChatRoomList(String sender_id) {
		return mapper.selectChatRoomList(sender_id);
	}

}
