package com.itwillbs.retech_proj;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.retech_proj.service.MainProductService;
import com.itwillbs.retech_proj.service.TechPayService;
import com.itwillbs.retech_proj.vo.BankToken;
import com.itwillbs.retech_proj.vo.ProductVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private MainProductService mainProductService;
	
	@Autowired
	private TechPayService techPayService;

	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@GetMapping("/")
//	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, Model model) {
		
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
	    
		// 핀테크 엑세스토큰 정보 조회하여 저장
		// => 실제 정보 조회는 로그인 시(MemberLogin - loginPro()) 수행되고 있지만
		//    현재 개발 서버(localhost)와 운영 서버(localhost)가 모두 이클립스가 관리하는 톰캣이므로
		//    코드 수정 후 저장 시 서버 reload 과정에서 세션 정보가 날아가는 현상이 생김
		// => 따라서, 해당 현상을 임시 방편으로 해결하기 위해 핀테크 메인 페이지 로딩 시 토큰도 조회
		// techPayService - getBankUserInfo() 메서드 호출하여 핀테크 사용자 관련 정보 조회(엑세스토큰 조회 위함)
		// => 파라미터 : 아이디   리턴타입 : BankToken(token)
		String id = (String)session.getAttribute("sId");
		BankToken token = techPayService.getBankUserInfo(id);
		System.out.println("-------------TechPayMain - token : " + token);
		
		// 조회 결과를 세션 객체에 저장
		session.setAttribute("token", token);
		
		// 테크페이 비밀번호 정보 조회
		String pay_pwd = techPayService.getPayPwd(id);
		System.out.println("pay_pwd : " + pay_pwd);
		
		// 조회 결과를 세션 객체에 저장
		session.setAttribute("pay_pwd", pay_pwd);
		
		// 테크페이 잔액 정보 조회
		String pay_balance = techPayService.getPayBalance(id);
		System.out.println("pay_balance : " + pay_balance);
		
		// 조회 결과를 세션 객체에 저장
		session.setAttribute("pay_balance", pay_balance);
	    
	    
	    return "main"; 
	}
	
}
