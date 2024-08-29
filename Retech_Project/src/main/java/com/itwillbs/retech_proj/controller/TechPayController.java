package com.itwillbs.retech_proj.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.retech_proj.service.TechPayService;
import com.itwillbs.retech_proj.vo.BankToken;

@Controller
public class TechPayController {
	@Autowired
	private TechPayService techPayService;
	
	// 로그를 사용하여 메세지를 다룰 현재 클래스 지정
	private static final Logger logger = LoggerFactory.getLogger(TechPayController.class);
	
	@GetMapping("TechPayMain")
	public String techPayMain(HttpSession session, Model model) {
		// 로그인 완료 되어 있는 회원만 테크페이 메인 페이지로 진입 가능함
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			
			// 로그인 페이지에서 로그인 완료 후, 테크메인 페이지로 다시 돌아옴
			session.setAttribute("prevURL", "TechPayMain");
			
			return "result/fail";
		}

		// 핀테크 엑세스토큰 정보 조회하여 저장
		// => 실제 정보 조회는 로그인 시(MemberLogin - loginPro()) 수행되고 있지만
		//    현재 개발 서버(localhost)와 운영 서버(localhost)가 모두 이클립스가 관리하는 톰캣이므로
		//    코드 수정 후 저장 시 서버 reload 과정에서 세션 정보가 날아가는 현상이 생김
		// => 따라서, 해당 현상을 임시 방편으로 해결하기 위해 핀테크 메인 페이지 로딩 시 토큰도 조회
		// techPayService - getBankUserInfo() 메서드 호출하여 핀테크 사용자 관련 정보 조회(엑세스토큰 조회 위함)
		// => 파라미터 : 아이디   리턴타입 : BankToken(token)
		BankToken token = techPayService.getBankUserInfo(id);
		
		// 조회 결과를 세션 객체에 저장
		session.setAttribute("token", token);
		
		
		return "techpay/techpay_main";
	}
	
	// 2.1.1. 사용자인증 API (3-legged)
	// 요청을 통해 사용자 인증 및 계좌 등록 수행 후 API 서버로부터 요청이 전달되도록 지정한 콜백(callback) 주소
	// => 콜백 주소 : http://localhost:8081/retech_proj/callback
	@GetMapping("callback")
	public String auth(@RequestParam Map<String, String> authResponse, HttpSession session, Model model) {
		System.out.println("인증 결과 : " + authResponse);
		
		// Logger 객체를 활용하여 콘솔에 로그 메세지로 출력
		// 단순 확인용이므로 로그 심각도를 info 레벨로 지정
		logger.info(">>>>>>>>>>>>>>> 인증 결과 : " + authResponse);
		
		// 로그인 완료 되어 있는 회원만 테크페이 해당 페이지로 진입 가능함
		String id = (String)session.getAttribute("sId");		
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("isClose", true);
			model.addAttribute("targetURL", "MemberLogin");
			session.setAttribute("prevURL", "TechPayMain");
			
			return "result/fail";
		}
		
		// --------------------------------------------------------------------------------------
		// 2.1.2. 토큰발급 API - 사용자 토큰발급 API (3-legged) 요청	
		// TechPayService - getAccessToken() 메서드 호출하여 엑세스 토큰 발급 요청
		BankToken token = techPayService.getAccessToken(authResponse);
		logger.info(">>>>>>>>>>>>> 엑세스토큰 정보 : " + token);		
		
		// 요청 결과 판별
		// => BankToken 객체가 null 이거나 엑세스토큰 값이 null 일 경우 요청 에러 처리
		if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "토큰 발급 실패! 재인증 필요!");
			// 인증을 위해 새 창이 열려있으며 해당 창 닫기 위해 "isClose" 속성값에 true 값 저장
			model.addAttribute("isClose", true);
			return "result/fail";
		}		
		
		// TechPayService - registAccessToken() 메서드 호출하여 토큰 관련 정보 저장 요청
		// => 파라미터 : 세션 아이디, BankToken 객체
		// => 만약, 세션 아이디와 BankToken 객체를 하나로 묶어 전달하려면 Map<String, Object> 사용
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("token", token);
		techPayService.registAccessToken(map);		
		System.out.println("엑세스토큰 정보 저장 완료!");
		
		// 세션에 엑세스토큰 관리 객체(BankToken) 저장
		session.setAttribute("token", token);	
		
		model.addAttribute("msg", "계좌 인증 완료!");
		model.addAttribute("isClose", true);		
		model.addAttribute("targetURL", true);		
		
		return "result/success";
	}
	
	@GetMapping("PayInfo")
	public String payInfo() {
		return "techpay/techpay_info";
	}
	
	
	@GetMapping("AccVerrify")
	public String accVerify() {
		return "techpay/account_verify";
	}
	
	
	
}
