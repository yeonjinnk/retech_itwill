package com.itwillbs.retech_proj.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.retech_proj.service.ChatService;
import com.itwillbs.retech_proj.service.ProductService;
import com.itwillbs.retech_proj.service.ReviewService;
import com.itwillbs.retech_proj.vo.ReportChatVO;
import com.itwillbs.retech_proj.vo.TradeVO;

@Controller
public class ReviewController {
	@Autowired ReviewService service;

	//리뷰등록
	@ResponseBody
	@GetMapping("RegistReview")
	public int registReview(@RequestParam Map<String, String> map) {
		System.out.println("!!!!!!!!리뷰 등록 위해 넘어온 파라미터!!!! : " + map);
		
		int isInsert = service.insertReview(map);
		
		return isInsert;
	}
}
