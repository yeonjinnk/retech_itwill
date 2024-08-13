package com.itwillbs.retech_proj.controller;

import org.springframework.web.bind.annotation.GetMapping;

public class FaqController {
	@GetMapping("Faq")
	public String faq() {
		return "faq/faq";
	}
}
