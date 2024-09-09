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

import com.itwillbs.retech_proj.service.StoreService;
import com.itwillbs.retech_proj.vo.ProductVO;
import com.itwillbs.retech_proj.vo.StoreVO;

@Controller
public class StoreController {
	@Autowired
	StoreService service;
	
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
	public String storeDetail(@RequestParam int store_idx, StoreVO store, Model model) {
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
			Model model) {
//		System.out.println("store_idx" + store_idx);
		System.out.println("!!!!!!!!!스토어 결제하기 파라미터 조회 : " + store_idx + ", " + order_store_quantity);
		//상품 정보 조회
		Map<String, Object> Store = service.selectStore(store_idx);
		System.out.println("Store : " + Store);
		
		int shippingCost = 3000;
		int amt = order_store_quantity * (int)Store.get("store_price");
		int order_store_pay = amt + shippingCost;
		model.addAttribute("Store", Store);
		model.addAttribute("order_store_quantity", order_store_quantity);
		model.addAttribute("order_store_pay", order_store_pay);
		model.addAttribute("amt", amt);
		return "store/store_pay";
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
	
	
	
}
