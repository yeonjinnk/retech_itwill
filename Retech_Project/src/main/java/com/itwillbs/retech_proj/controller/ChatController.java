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
import com.itwillbs.retech_proj.vo.ReportChatVO;

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
	public String chatRoom(ReportChatVO reportChat) {
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
	
	
//	@PostMapping
}
