package com.itwillbs.retech_proj.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.ChatMessage;
import com.itwillbs.retech_proj.vo.ChatRoom;

@Mapper
public interface ChatMapper {

	//기존 자신의 채팅방 목록 조회
	List<ChatRoom> selectChatRoomList(String sender_id);

	//해당 사용자와의 기존 채팅방 조회(파라미터 2개 주의!)
	ChatRoom selectChatRoom(@Param("sender_id") String sender_id,@Param("receiver_id") String receiver_id, @Param("pd_idx")int pd_idx);

	//새 채팅방 생성(추가)
	void insertChatRoom(List<ChatRoom> chatRoomList);

	//기존 채팅 내역 조회
	List<ChatMessage> selectChatMessageList(String room_id);

	//채팅 메세지 저장
	void insertChatMessage(ChatMessage chatMessage);

	//채팅방 종료
	void updateChatRoomStatusForQuitRoom(@Param("room_id") String room_id, @Param("sender_id") String sender_id);

	//채팅방 목록에 띄울 날짜, 마지막메세지 조회
	Map<String, String> selectLastInfo(@Param("sender_id") String sender_id, @Param("receiver_id") String receiver_id);

	//DB에 알람 정보 저장하기
	boolean insertAlarm(Map<String, String> alarmInfo);

	//DB에서 알람 가져오기
	List<HashMap<String, Object>> selectAlarm(Map<String, String> map);

}
