package com.itwillbs.retech_proj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChatController {

	@GetMapping("Report")
	public String report() {
		return "chat/report";
	}
}
