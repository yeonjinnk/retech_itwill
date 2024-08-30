package com.itwillbs.retech_proj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.ChatMessage;
import com.itwillbs.retech_proj.vo.ChatRoom;

@Mapper
public interface ChatMapper {

	//기존 자신의 채팅방 목록 조회
	List<ChatRoom> selectChatRoomList(String sender_id);

	//기존 채팅방 존재 여부 확인을 위한 1개 채팅방 정보 조회
	ChatRoom selectChatRoom(@Param("sender_id") String sender_id, @Param("receiver_id") String receiver_id);

	//새 채팅방 생성(추가)
	void insertChatRoom(List<ChatRoom> chatRoomList);

	// 기존 채팅 내역 조회
	List<ChatMessage> selectChatMessageList(String room_id);

	//채팅 메세지 저장
	void insertChatMessage(ChatMessage chatMessage);

}
