package com.itwillbs.retech_proj.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TechPayController {

	// 로그를 사용하여 메세지를 다룰 현재 클래스 지정
	private static final Logger logger = LoggerFactory.getLogger(TechPayController.class);
	
	@GetMapping("TechPayMain")
	public String techPayMain(HttpSession session, Model model) {
		// 로그인 완료 되어 있는 회원만 테크페이 메인 페이지로 진입 가능함
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			
			// 로그인 페이지에서 로그인 완료 후, 테크메인 페이지로 다시 돌아옴
			session.setAttribute("prevURL", "TechPayMain");
			
			return "result/fail";
		}
		
		
		
		return "techpay/techpay_main";
	}
	
}
