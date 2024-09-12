package com.itwillbs.retech_proj.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.retech_proj.service.AdminService;


@Controller
public class AdminController {
	@Autowired 
	private AdminService adminService;
	// 관리자 홈
	@GetMapping("AdminHome")
	public String memberJoin(HttpSession session, Model model) {
		if(session.getAttribute("sIsAdmin") == null) {
			model.addAttribute("msg", "관리자만 접속 가능한 페이지입니다.");
			model.addAttribute("targetURL", "./");
			return "result/fail";
		}
		return "admin/admin_chart";
	} 
}
