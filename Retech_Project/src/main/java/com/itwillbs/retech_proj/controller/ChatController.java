package com.itwillbs.retech_proj.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChatController {

	@GetMapping("Report")
	public String report() {
		return "chat/report";
	}
	
	//채팅방 목록
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
	
	//채팅방 1개 열기
	@GetMapping("ChatRoom")
	public String chatRoom() {
		return "chat/chatRoom";
	}
}
