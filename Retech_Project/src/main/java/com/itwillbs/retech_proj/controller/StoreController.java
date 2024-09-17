package com.itwillbs.retech_proj.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.retech_proj.service.MemberService;
import com.itwillbs.retech_proj.service.StoreService;
import com.itwillbs.retech_proj.vo.MemberVO;
import com.itwillbs.retech_proj.vo.OrderStoreVO;
import com.itwillbs.retech_proj.vo.ProductVO;
import com.itwillbs.retech_proj.vo.StoreVO;

@Controller
public class StoreController {
	@Autowired
	StoreService service;
	
	@Autowired
	 private MemberService memberService;
	
	@GetMapping("Review")
	public String review() {
		return "mypage/review_popup";
	}
	
	
	
	@GetMapping("Store")
	public String store() {
		return "store/store_list";
	}
	
	//상품 목록 출력 ajax..
	@ResponseBody
	@GetMapping("StoreProductList")
	public List<Map<String, Object>> productList(@RequestParam Map<String, String> map) {
		
		List<Map<String, Object>> productList = service.selectProductList(map);
		
		return productList;
	}
	
	@GetMapping("StoreDetail")
	public String storeDetail(@RequestParam int store_idx, StoreVO store, Model model, HttpSession session) {
		//상품 정보 조회
		Map<String, Object> Product = service.selectProduct(store_idx);
		System.out.println("Product : " + Product);
		
		
		
		model.addAttribute("Product", Product);
		return "store/store_detail";
	}
	
	//진행중..
	@GetMapping("StorePay")
	/*public String storePay(@RequestParam String order_store_item, @RequestParam int order_store_quantity, 
							@RequestParam int order_store_pay, Model model) {
		//상품 정보 조회
		int insertCount = service.insertPayProduct(order_store_item, order_store_quantity, order_store_pay);
		Map<String, Object> payProduct = service.selectPayProduct(order_store_item);
		model.addAttribute("payProduct", payProduct);*/
	public String storePay(@RequestParam("order_store_item") int store_idx, @RequestParam int order_store_quantity, 
			Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id != null) {
	//		System.out.println("store_idx" + store_idx);
				System.out.println("!!!!!!!!!스토어 결제하기 파라미터 조회 : " + store_idx + ", " + order_store_quantity);
				//상품 정보 조회
				Map<String, Object> Store = service.selectStore(store_idx);
				System.out.println("Store : " + Store);
				//멤버 정보 조회
				// 회원 정보 조회 (필요한 경우)
				MemberVO member = new MemberVO();
				member.setMember_id(id);
				member = memberService.getMember(member);
				model.addAttribute("member", member);
				int shippingCost = 3000;
				int amt = order_store_quantity * (int)Store.get("store_price");
				int order_store_pay = amt + shippingCost;
				model.addAttribute("Store", Store);
				model.addAttribute("order_store_quantity", order_store_quantity);
				model.addAttribute("order_store_pay", order_store_pay);
				model.addAttribute("amt", amt);
				return "store/store_pay";
		} else {
			model.addAttribute("msg", "로그인 후 스토어 결제 이용해주세요!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
	} 
	
	//스토어 결제 정보 저장하기
	@PostMapping("StorePay")
	public String SaveStorePay(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		System.out.println("!!!!!!!!!!!!결제 완료 후 들고온 파라미터!!!!!!!!!!! : " + map);
		
		//스토어 결제 정보 저장하기
		int isInsert = service.insertStorePay(map);
		if(isInsert > 0) {
			return "store/store_pay_completed";
		} else {
			model.addAttribute("msg", "결제 실패!");
			model.addAttribute("targetURL", "StoreProductList");
			return "result/fail";
		}
	}
	
	@GetMapping("PurchaseStoreHistory")
	public String purchaseStoreHistory(@RequestParam(value = "startRow", defaultValue = "0") int startRow,
            @RequestParam(value = "listLimit", defaultValue = "10") int listLimit,
            @RequestParam(value = "searchKeyword", defaultValue = "") String searchKeyword,
            Model model, HttpSession session) {

		String id = (String) session.getAttribute("sId");
		// 세션에 사용자 ID가 존재하는 경우
		if (id != null) {
			List<Map<String, Object>> storeHistoryList = service.getStoreHistory(id);
			System.out.println("주문한 스토어 내역 : " + storeHistoryList);
			 // 회원 정보 조회 (필요한 경우)
	           MemberVO member = new MemberVO();
	           member.setMember_id(id);
	           member = memberService.getMember(member);
	           
	           
		         //-------------리뷰 불러오기----------------------------
			       Float myStarRate = memberService.getStarRate(id);
			       System.out.println("불러온 리뷰 별점 myStarRate : " + myStarRate);
			       if(myStarRate != null) {
			    	   System.out.println("리뷰를 불러옵니다!!!");
			    	   member.setMember_starRate(myStarRate);
			       }
			       //---------------------------------------------------
	           
	           model.addAttribute("member", member);
			model.addAttribute("storeHistoryList", storeHistoryList);
		return "mypage/purchaseStorehistory";
		} else {
			return "result/fail";
		}
			
	
	}
}
