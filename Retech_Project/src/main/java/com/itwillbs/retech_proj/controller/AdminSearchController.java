package com.itwillbs.retech_proj.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.retech_proj.HomeController;
import com.itwillbs.retech_proj.service.AdminService;
import com.itwillbs.retech_proj.service.RetechService;


@Controller
public class AdminSearchController {
	private static final Logger log = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private RetechService service; 
	// 검색어 관리 페이지
	@GetMapping("TotalSearchList")
	public String nowSearchList(HttpSession session, Model model) {
		String member_id = (String)session.getAttribute("sId");
		if(member_id == null || !member_id.equals("admin@naver.com")) {
			return "error/404";
		}
		List<Map<String,String>> searchList = service.getSearchList();
		
		model.addAttribute("searchList",searchList);
		log.info("실시간 인기검색어 TOP20 : " + searchList);
		return "admin/totalSearchList";
	}
}
