package com.itwillbs.retech_proj;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.retech_proj.service.MainProductService;
import com.itwillbs.retech_proj.vo.ProductVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	
	@Autowired
	private MainProductService mainProductService;

	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@GetMapping("/")
//	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
	    // 최근 업데이트 상품 불러오기
	    List<ProductVO> recentProducts = mainProductService.getRecentProducts();
	    System.out.println("최근 업데이트 상품 개수 ? " + recentProducts.size());	    
	    System.out.println("최근 업데이트 상품 목록 " + recentProducts);
	    
	    // model에 저장
	    model.addAttribute("recentProducts", recentProducts);

	    
	    // 인기 상품 불러오기
	    List<ProductVO> popularProducts = mainProductService.getPopularProducts();
	    System.out.println("인기 상품 개수 ? " + popularProducts.size());
	    System.out.println("인기 상품 목록 " + popularProducts);
	    
	    // model에 저장
	    model.addAttribute("popularProducts", popularProducts);
	    
	    return "main"; 
	}
	
}
