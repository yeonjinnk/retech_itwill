package com.itwillbs.retech_proj.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.retech_proj.service.ProductService;
import com.itwillbs.retech_proj.vo.ProductVO;


@Controller
public class ProductController {
	@Autowired
	   private ProductService service;
	
	//중고상품목록페이지
	//최신순으로 정렬
	@GetMapping("ProductList")
	public String productList(@RequestParam(defaultValue = "1") int pageNum,
			ProductVO product, Model model, HttpSession session) {
		//공통코드 사용하여 카테고리별로 목록 표시
		
		
		
		
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호

		//ProductService - getProductList() 호출하여 게시물목록 조회요청
		//파라미터 : (검색타입,검색어), 시작행번호, 목록갯수
		List<ProductVO> productList = service.getProductList(startRow, listLimit);
		
		//페이징처리 위한 계산작업----------------------------------------------------
		//1. ProductService - getProductListCount() 호출하여 전체게시물 수 조회요청
		int listCount = service.getProductListCount();
		//2. 전체페이지 목록 개수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		model.addAttribute("productList",productList);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("listCount", listCount);//전체게시물수
		
		return"product/product_list";
	}
	//판매하기 클릭시 상품 등록 페이지로 이동
	@GetMapping("ProductRegistForm")
	public String productRegistForm(HttpSession session, Model model) {
		//미로그인시 "로그인이 필요합니다." 문구 출력 후 이전 페이지로 돌아감
		//임시로 주석 처리
//		String member_id = (String)session.getAttribute("member_id");
//		System.out.println("member_id : " + member_id);
//		if(member_id == null) {
//			model.addAttribute("msg", "로그인이 필요합니다.");
//			return"result/fail";
//		}
		return"product/product_regist_form";
	}
	//상품 등록 처리
	@ResponseBody
	@PostMapping("ProductRegistPro")
	public String productRegistPro(ProductVO product, HttpSession session, Model model, HttpServletResponse request) {
		
		
		
		
		return"";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	   
}
