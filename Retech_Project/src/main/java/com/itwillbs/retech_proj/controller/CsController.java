package com.itwillbs.retech_proj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CsController {
	@GetMapping("Cs")
	public String cs() {
		return "cs/cs";
	}

}
