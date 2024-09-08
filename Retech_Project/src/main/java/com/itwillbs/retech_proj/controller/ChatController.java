package com.itwillbs.retech_proj.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.retech_proj.service.ChatService;
import com.itwillbs.retech_proj.service.ProductService;
import com.itwillbs.retech_proj.vo.ReportChatVO;
import com.itwillbs.retech_proj.vo.TradeVO;

@Controller
public class ChatController {
	@Autowired ChatService service;

	
	@GetMapping("Report")
	public String report() {
		return "chat/report";
	}
	
	@GetMapping("ChatList")
	public String chatList(HttpSession session, Model model) {
		//로그인 판별위해 session에서 sId 받아와서 id로 저장
		String id = (String)session.getAttribute("sId");
		
		if(id == null) { //로그인x
			model.addAttribute("msg", "로그인 필수!"); //alert창
			model.addAttribute("targetURL", "MemberLogin"); //로그인창으로 돌아감
		return "result/fail";
		} //로그인 O
		
		return "chat/chatList";
	}
	
	
	
	@GetMapping("ChatRoom")
	public String chatRoom(@RequestParam int pd_idx, Model model, HttpSession session) {
		System.out.println("chatRoom 파라미터 pd_idx 잘 넘어왓나 : " + pd_idx);
		
		  // 세션에서 거래 정보 가져오기
//	    TradeVO newTrade = (TradeVO) session.getAttribute("newTrade");
//	    System.out.println("세션에서 가져온 정보 newTrade : " + newTrade);
//	    model.addAttribute("newTrade", newTrade);
		
		//상품 정보 얻어오기
		Map<String, Object> productInfo = service.getProduct(pd_idx);
		System.out.println("얻어온 상품 정보는 무엇일까 : " + productInfo);
		
		
		//저장한 거래정보 들고 다시가야지..
				TradeVO newTrade = service.getTrade(pd_idx);
				System.out.println("들고온 거래정보 조회하기 : " + newTrade);
				model.addAttribute("newTrade", newTrade);
		model.addAttribute("productInfo", productInfo);
		
		return "chat/chatRoom";
	}
	
//	@PostMapping("ChatRoom")
//	public String chatRoom(@RequestParam String seller_id, @RequestParam int pd_idx) {
//		System.out.println("챗룸 넘어온 파라미터 확인 : " + seller_id + pd_idx);
//		return "chat/chatRoom?receiver_id"+seller_id;
//	}
	
	
	@PostMapping("ReportRegist")
	public String reportRegist(ReportChatVO reportChat) {
		System.out.println("넘어온 데이터(reportChat) : " + reportChat);
		return"";
	}
	
	@ResponseBody
	@PostMapping("AlarmRemember")
	public boolean alarmRemember(@RequestParam Map<String, String> alarmInfo, HttpSession session) {
		alarmInfo.put("member_id", (String)session.getAttribute("sId"));
		System.out.println("DB에 저장할 알람 정보 : " + alarmInfo);
		boolean isInsert = service.insertAlarm(alarmInfo);
		
		System.out.println("알람 DB에 잘 들어갔나 : " + isInsert);
		return isInsert;
	}
	
	@ResponseBody
	@GetMapping("AlarmCheck")
	public List<HashMap<String, Object>> alarmCheck(@RequestParam Map<String, String> map) {
		System.out.println("DB에서 알람 가져오는 alarmCheck 호출됨!");
		System.out.println("id 잘 넘어왔나 : " + map);
		List<HashMap<String, Object>> alarmMap = service.getAlarmList(map);
		System.out.println("알람 리스트 : " + alarmMap);
		
		return alarmMap;
	}
	
	@GetMapping("SelectTrade")
	public String selectTrade(TradeVO trade, @RequestParam Map<String, Object> map, @RequestParam("pd_idx") int pd_idx, Model model, HttpSession session) {
		//판매자가 거래하기 후 호출되는 함수
		System.out.println("=======================================================");
		System.out.println("!!!!판매자가 거래하기에 정보 입력함!!!!!");
		
		System.out.println("채팅룸에서 파라미터 잘 넘어왔나 : " + map);
		System.out.println("거래방식 선택하고 넘어온 정보 조회 trade : " + trade);
		String roomId = (String)map.get("room_id");
		String receiverId = (String)map.get("receiver_id");
		String senderId = (String)map.get("sender_id");
		String status = (String)map.get("status");
		System.out.println("map 객체에 있는 파라미터를 변수로 저장함!");
		
		trade.setTrade_buyer_id(receiverId);
		trade.setTrade_seller_id(senderId);
		trade.setTrade_pd_idx(pd_idx);
		trade.setTrade_status(1);
		
		//저장하기 전 최종 파라미터 조회
		System.out.println("거래 저장하기 전 trade : " + trade);
		
		//거래 정보 저장
		int insertCount = service.insertTrade(trade);
		System.out.println("거래 정보 잘 저장했나 : " + insertCount);
		
		//저장한 거래정보 들고 다시가야지..
		TradeVO newTrade = service.getTrade(pd_idx);
		System.out.println("들고온 거래정보 조회하기 : " + newTrade);
		model.addAttribute("newTrade", newTrade);
		
		 // 세션에 거래 정보 저장
	    session.setAttribute("newTrade", newTrade);
		
		//정보를 다시 들고 가야 하니까 redirect..
		return "redirect:/ChatRoom?room_id=" + roomId + "&receiver_id=" + receiverId 
				+ "&sender_id=" + senderId + "&status=" + status + "&pd_idx=" + pd_idx;
	}
	
	@GetMapping("DeliveryPay")
	public String deliveryPay(@RequestParam String buyer_postcode, @RequestParam String buyer_address1, @RequestParam String buyer_address2,
			@RequestParam String buyer_id, @RequestParam Map<String, Object> map, @RequestParam("pd_idx") int pd_idx) {
		System.out.println("===================================================================");
		System.out.println("주소입력 하기 위한 파라미터 잘 넘어왔는지 : buyer_postcode = " + buyer_postcode + ", buyer_address1 =" + buyer_address1
				+ ", buyer_address2=" + buyer_address2
				+ ", buyer_id=" + buyer_id + ", map=" + map + ", pd_idx=" + pd_idx);
		
		//택배 주소 입력
		int insertAddress = service.inputAddress(buyer_id);
		
		System.out.println(" 택배 주소 입력 성공했는지 : " + insertAddress);
		
		String roomId = (String)map.get("room_id");
		String receiverId = (String)map.get("receiver_id");
		String senderId = (String)map.get("sender_id");
		String status = (String)map.get("status");
		System.out.println("map 객체에 있는 파라미터를 변수로 저장함!");
		
		
		//정보를 다시 들고 가야 하니까 redirect..
		return "redirect:/ChatRoom?room_id=" + roomId + "&receiver_id=" + receiverId 
				+ "&sender_id=" + senderId + "&status=" + status + "&pd_idx=" + pd_idx;
	}
	
	
//	@PostMapping
}
