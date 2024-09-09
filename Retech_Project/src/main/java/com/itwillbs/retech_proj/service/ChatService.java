package com.itwillbs.retech_proj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.ChatMapper;
import com.itwillbs.retech_proj.vo.ChatMessage;
import com.itwillbs.retech_proj.vo.ChatRoom;
import com.itwillbs.retech_proj.vo.TradeVO;

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

	//상품 정보 가져오기
	public Map<String, Object> getProduct(int pd_idx) {
		return mapper.selectProduct(pd_idx);
	}

	//거래 정보 저장하기
	public int updateTrade(TradeVO trade) {
		return mapper.updateTrade(trade);
	}

	//저장한 거래 정보 조회하기
	public TradeVO getTrade(int pd_idx) {
		return mapper.selectTrade(pd_idx);
	}

	//택배 주소 입력
	public int updateAddress(String buyer_id, String buyer_postcode, String buyer_address1, String buyer_address2) {
		return mapper.updateAddress(buyer_id, buyer_postcode, buyer_address1, buyer_address2);
	}

	//신고 입력하기
	public int registChatReport(Map<String, Object> map) {
		return mapper.insertReport(map);
	}

	  //--------------------거래 테이블에 추가 ---------------------------------
    //상품 등록 시 거래 테이블에도 상품 번호랑 거래상태를 insert함
	public void insertTrade(int pd_idx, String member_id) {
		mapper.insertTrade(pd_idx, member_id);
	}

    //등록한 상품 번호 들고오기

	public int getPdIDX(String member_id) {
		// TODO Auto-generated method stub
		return mapper.selectPdIDX(member_id);
	}

	//택배 주소 입력

	//저장한 거래 정보 조회하기
//	public TradeVO getTrade(int pd_idx) {
//		return mapper.selectTrade(pd_idx);
//	}

}
