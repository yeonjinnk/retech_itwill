package com.itwillbs.retech_proj.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.retech_proj.service.AdminService;
import com.itwillbs.retech_proj.vo.MemberVO;


@Controller
public class AdminChart {
	@Autowired 
	private AdminService service;
	// 관리자 홈
	@GetMapping("AdminChart")
	public String memberJoin(HttpSession session, Model model) {
		if(session.getAttribute("sIsAdmin") == null) {
			model.addAttribute("msg", "관리자만 접속 가능한 페이지입니다.");
			model.addAttribute("targetURL", "./");
			
			 List<MemberVO> member = service.getMemberList();
//		      System.out.println(memberList);
		      // 회원 목록, 페이징 정보 Model 객체에 저장 -> admin_member_list.jsp 로 전달
		      model.addAttribute("member", member);
			
			
			return "result/fail";
		}
		return "admin/admin_chart";
	} 
}
