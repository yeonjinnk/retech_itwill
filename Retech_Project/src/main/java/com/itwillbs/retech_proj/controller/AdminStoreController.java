package com.itwillbs.retech_proj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminStoreController {
	//스토어 상품 관리
	@GetMapping("AdminStore")
	public String adminStore() {
		return "admin/admin_store";
	}
	
	//스토어 구매내역 관리
	@GetMapping("AdminBuyStore")
	public String AdminBuyStore() {
		return "admin/admin_store";
	}
	
	//채팅 신고 관리
	@GetMapping("AdminChatReport")
	public String adminChatReport() {
		return "admin/admin_store";
	}
	
	//채팅 관리
	@GetMapping("AdminChat")
	public String adminChat() {
		return "admin/admin_store";
	}
	
	//리뷰 관리
	@GetMapping("AdminReview")
	public String AdminReview() {
		return "admin/admin_store";
	}
}
