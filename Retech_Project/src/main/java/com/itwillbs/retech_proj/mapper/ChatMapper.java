package com.itwillbs.retech_proj.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.ChatMessage;
import com.itwillbs.retech_proj.vo.ChatRoom;
import com.itwillbs.retech_proj.vo.TradeVO;

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

	//상품 정보 가져오기
	Map<String, Object> selectProduct(int pd_idx);

	//거래 정보 저장하기
	int updateTrade(TradeVO trade);

	//저장한 거래 정보 조회하기
	TradeVO selectTrade(int pd_idx);

	//택배 주소 입력
	int updateAddress(@Param("buyer_id") String buyer_id, @Param("buyer_postcode") String buyer_postcode,
						@Param("buyer_address1") String buyer_address1, @Param("buyer_address2") String buyer_address2);

	//신고 입력하기
	int insertReport(Map<String, Object> map);

	  //--------------------거래 테이블에 추가 ---------------------------------
    //상품 등록 시 거래 테이블에도 상품 번호랑 거래상태를 insert함
	void insertTrade(@Param("pd_idx") int pd_idx, @Param("member_id") String member_id);

	 //등록한 상품 번호 들고오기
	int selectPdIDX(String member_id);


}
