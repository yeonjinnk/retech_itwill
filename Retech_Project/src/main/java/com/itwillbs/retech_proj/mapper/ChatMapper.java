package com.itwillbs.retech_proj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.retech_proj.vo.ChatRoom;

@Mapper
public interface ChatMapper {

	//기존 자신의 채팅방 목록 조회
	List<ChatRoom> selectChatRoomList(String sender_id);

}
