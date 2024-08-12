package com.itwillbs.retech_proj.controller;

import org.springframework.web.bind.annotation.GetMapping;

public class NoticeController {
	@GetMapping("Notice")
	public String notice() {
		return "notice/notice";
	}
}
