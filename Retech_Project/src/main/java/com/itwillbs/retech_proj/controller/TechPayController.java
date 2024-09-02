package com.itwillbs.retech_proj.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.retech_proj.service.TechPayService;
import com.itwillbs.retech_proj.vo.BankToken;

@Controller
public class TechPayController {
	@Autowired
	private TechPayService techPayService;
	
	// 로그를 사용하여 메세지를 다룰 현재 클래스 지정
	private static final Logger logger = LoggerFactory.getLogger(TechPayController.class);
	
	@GetMapping("TechPayMain")
	public String techPayMain(HttpSession session, Model model, HttpServletResponse response) {
		// 로그인 완료 되어 있는 회원만 테크페이 메인 페이지로 진입 가능함
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			
			// 로그인 페이지에서 로그인 완료 후, 테크메인 페이지로 다시 돌아옴
			session.setAttribute("prevURL", "TechPayMain");
			
			return "result/fail";
		
		// 페이 관리자 아이디로 접속 시, 테크페이 관리자 페이지로 진입함
		} else if (id.equals("payadmin@gmail.com")) {
			return "techpay/techpay_admin_main";	
		}
		
		// 핀테크 엑세스토큰 정보 조회하여 저장
		// => 실제 정보 조회는 로그인 시(MemberLogin - loginPro()) 수행되고 있지만
		//    현재 개발 서버(localhost)와 운영 서버(localhost)가 모두 이클립스가 관리하는 톰캣이므로
		//    코드 수정 후 저장 시 서버 reload 과정에서 세션 정보가 날아가는 현상이 생김
		// => 따라서, 해당 현상을 임시 방편으로 해결하기 위해 핀테크 메인 페이지 로딩 시 토큰도 조회
		// techPayService - getBankUserInfo() 메서드 호출하여 핀테크 사용자 관련 정보 조회(엑세스토큰 조회 위함)
		// => 파라미터 : 아이디   리턴타입 : BankToken(token)
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
		
		
		if(token == null) {
			System.out.println("토큰 없음");
			return "techpay/account_verify";			
		} else {
			return "techpay/techpay_info";			
		}
		
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
		
		// TechPayService - registAccessToken() 메서드 호출하여 토큰 관련 정보 저장
		// => 파라미터 : 세션 아이디, BankToken 객체
		// => 만약, 세션 아이디와 BankToken 객체를 하나로 묶어 전달하려면 Map<String, Object> 사용
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("token", token);
		
		techPayService.registAccessToken(map);		
		System.out.println("엑세스토큰 정보 저장 완료!");
		
		// 세션에 엑세스토큰 관리 객체(BankToken) 저장
		session.setAttribute("token", token);	
		
		
		// techPayService - registPayInfo() 메서드 호출하여 테크페이 초기 정보 저장
		techPayService.registPayInfo(id);
		System.out.println("테크페이 초기 정보 저장 완료!");
		
		model.addAttribute("msg", "계좌 인증 완료!");
		model.addAttribute("isClose", true);		
		model.addAttribute("targetURL", "TechPayMain");		
		
		return "result/success";
	}
	
	@GetMapping("AdminBankRequestToken")
	public String adminBankRequestToken(HttpSession session, Model model) {
		String id = (String)session.getAttribute("sId");		
		// 로그인 완료 되어 있는 회원만 테크페이 해당 페이지로 진입 가능함
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			session.setAttribute("prevURL", "AdminBankRequestToken");
			return "result/fail";
		// 페이 관리자 아이디가 아닌 회원은 해당 페이지 진입 불가능함
		} else if (!id.equals("payadmin@gmail.com"))	 {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result/fail";
		}
		
		// 2.1.2. 관리자 토큰발급 API (2-legged) - 관리자 엑세스토큰 발급용
		BankToken adminToken = techPayService.getAdminAccessToken();
		System.out.println("---------------관리자 토큰 발급 결과 : " + adminToken);

		// 요청 결과 판별
		// => BankToken 객체가 null 이거나 엑세스토큰 값이 null 일 경우 요청 에러 처리
		if(adminToken == null || adminToken.getAccess_token() == null) {
			model.addAttribute("msg", "토큰 발급 실패! 재인증 필요!");
			// 인증을 위해 새 창이 열려있으며 해당 창 닫기 위해 "isClose" 속성값에 true 값 저장
			model.addAttribute("isClose", true);
			return "result/fail";
		}	
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("token", adminToken);
		
		// TechPayService - registAdminAccessToken() 메서드 호출하여 관리자 토큰 관련 정보 저장
		techPayService.registAdminAccessToken(map);
		
		model.addAttribute("msg", "관리자 토큰 발급 성공!");
		model.addAttribute("targetURL", "TechPayMain");
		
		return "result/success";
	}
	
	@GetMapping("PayCharge")	
	public String payCharge(HttpSession session, Model model) {
		// 회원 엑세스토큰 정보 저장된 BankToken객체 session에서 꺼내서 'token'으로 저장
		BankToken token = (BankToken)session.getAttribute("token");
		
		// 1) 로그인 안 되어 있으면 로그인페이지로 이동
		// 2) session에 token 없거나 token에 엑세스 토큰 없으면 계좌인증페이지로 이동
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			// 로그인 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayCharge");
			return "result/fail";
		} else if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "계좌인증 필수!");
			model.addAttribute("targetURL", "TechPayMain");
			// 계좌인증 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayManage");
			return "result/fail";			
		}

		// 2.2.1. 사용자정보조회 API
		// TechPayService - getBankUserInfoFromApi() 메서드
		Map<String, Object> bankUserInfoFromApi = techPayService.getBankUserInfoFromApi(token);
		System.out.println("------------- 사용자정보조회 결과 : " + bankUserInfoFromApi);
		logger.info(">>>>>>>>>>>>> 사용자정보조회 결과 : " + bankUserInfoFromApi);		
		
		// Model 객체에 사용자정보조회 결과 저장
		model.addAttribute("bankUserInfoFromApi", bankUserInfoFromApi);		
		
		// 2.2.3. 등록계좌조회 API
		// TechPayService - getBankAccountList() 메서드
		Map<String, Object> accountList = techPayService.getBankAccountList(token);
		System.out.println("------------- 등록계좌조회 결과 : " + accountList);
		logger.info(">>>>>>>>>>>>> 등록계좌조회 결과 : " + accountList);		
		
		// Model 객체에 등록계좌조회 결과 저장
		model.addAttribute("accountList", accountList);		
		
		return "techpay/techpay_charge";		
	}
	
	@PostMapping("ChargeBankWithdraw")
	public String chargeBankWithdraw(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		// 회원 엑세스토큰 정보 저장된 BankToken객체 session에서 꺼내서 'token'으로 저장
		BankToken token = (BankToken)session.getAttribute("token");
		String id = (String)session.getAttribute("sId");
		
		// 1) 로그인 안 되어 있으면 로그인페이지로 이동
		// 2) session에 token 없거나 token에 엑세스 토큰 없으면 계좌인증페이지로 이동
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			// 로그인 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "ChargeBankWithdraw");
			return "result/fail";
		} else if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "계좌인증 필수!");
			model.addAttribute("targetURL", "TechPayMain");
			// 계좌인증 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayManage");
			return "result/fail";			
		}
		
		map.put("token", token);
		map.put("id", id);
		System.out.println("출금이체 요청 파라미터 : " + map);
		
		// 2.5.1. 출금이체 API
		// TechPayService - requestWithdraw() 메서드
		Map<String, String> chargeWithdrawResult = techPayService.requestWithdraw(map);
		System.out.println("------------- 출금이체 결과 : " + chargeWithdrawResult);
		
		// Model 객체에 출금이체 결과 저장
		model.addAttribute("chargeWithdrawResult", chargeWithdrawResult);			
		
		// 테크페이 잔액 충전
		// TechPayService - registCharge() 메서드
		String amt = "50000"; // 임의 금액 설정
		techPayService.registCharge(id, amt);
		
		return "techpay/techpay_charge_result";
	}
	
	@GetMapping("PayRefund")	
	public String payRefund(HttpSession session, Model model) {
		// 회원 엑세스토큰 정보 저장된 BankToken객체 session에서 꺼내서 'token'으로 저장
		BankToken token = (BankToken)session.getAttribute("token");
		
		// 1) 로그인 안 되어 있으면 로그인페이지로 이동
		// 2) session에 token 없거나 token에 엑세스 토큰 없으면 계좌인증페이지로 이동
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			// 로그인 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayRefund");
			return "result/fail";
		} else if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "계좌인증 필수!");
			model.addAttribute("targetURL", "TechPayMain");
			// 계좌인증 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayManage");
			return "result/fail";			
		}
		
		// 2.2.3. 등록계좌조회 API
		// TechPayService - getBankAccountList() 메서드
		Map<String, Object> accountList = techPayService.getBankAccountList(token);
		System.out.println("------------- 등록계좌조회 결과 : " + accountList);
		logger.info(">>>>>>>>>>>>> 등록계좌조회 결과 : " + accountList);		
		
		// Model 객체에 등록계좌조회 결과 저장
		model.addAttribute("accountList", accountList);				
		
		return "techpay/techpay_refund";
	}
	
	@PostMapping("RefundBankDeposit")
	public String refundBankDeposit(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		System.out.println("입금 이체 요청 파라미터 : " + map);
		
		String id = (String)session.getAttribute("sId");
		// 회원 엑세스토큰 정보 저장된 BankToken객체 session에서 꺼내서 'token'으로 저장
		BankToken token = (BankToken)session.getAttribute("token");
		
		// 1) 로그인 안 되어 있으면 로그인페이지로 이동
		// 2) session에 token 없거나 token에 엑세스 토큰 없으면 계좌인증페이지로 이동
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			// 로그인 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "RefundBankDeposit");
			return "result/fail";
		} else if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "계좌인증 필수!");
			model.addAttribute("targetURL", "TechPayMain");
			// 계좌인증 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayManage");
			return "result/fail";			
		}
				
		map.put("id", (String)session.getAttribute("sId"));
		System.out.println("입금 이체 요청 파라미터 : " + map);
		
		// 2.5.2. 입금 이체 API
		// TechPayService - requestDeposit() 메서드	
		Map<String, Object> refundDepositResult = techPayService.requestDeposit(map);
		System.out.println("------------- 입금이체 결과 : " + refundDepositResult);

		// Model 객체에 입금이체 결과 저장		
		model.addAttribute("refundDepositResult", refundDepositResult);
		
		// 테크페이 잔액 차감
		// TechPayService - registRefund() 메서드
		String amt = "70000"; // 임의 금액 설정
		techPayService.registRefund(id, amt);		
		
		return "techpay/techpay_refund_result";
	}
	
	@GetMapping("PayManage")	
	public String payManage(HttpSession session, Model model) {
		// 회원 엑세스토큰 정보 저장된 BankToken객체 session에서 꺼내서 'token'으로 저장
		BankToken token = (BankToken)session.getAttribute("token");
		System.out.println("-------------PayManage - token : " + token);
		
		// 1) 로그인 안 되어 있으면 로그인페이지로 이동
		// 2) session에 token 없거나 token에 엑세스 토큰 없으면 계좌인증페이지로 이동
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			// 로그인 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayManage");
			return "result/fail";
		} else if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "계좌인증 필수!");
			model.addAttribute("targetURL", "TechPayMain");
			// 계좌인증 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayManage");
			return "result/fail";			
		}
		
		// 2.2.3. 등록계좌조회 API
		// TechPayService - getBankAccountList() 메서드
		Map<String, Object> accountList = techPayService.getBankAccountList(token);
		System.out.println("------------- 등록계좌조회 결과 : " + accountList);
		logger.info(">>>>>>>>>>>>> 등록계좌조회 결과 : " + accountList);
		
		System.out.println(accountList.get("rsp_code"));
		
		// 액세스토큰 오류 시, 계좌인증 재진행
		if(accountList.get("rsp_code").equals("O0002")) {
			model.addAttribute("msg", "인증 오류! 계좌인증을 다시 진행해주세요!");
			model.addAttribute("targetURL", "AccVerrify");
			// 계좌인증 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayManage");
			return "result/fail";			
		}
		
		model.addAttribute("accountList", accountList);
		
		return "techpay/techpay_manage";		
	}
	
	@GetMapping("PayPwdSet")
	public String payPwdSet(HttpSession session, Model model, @RequestParam Map<String, String> map) {
		String id = (String)session.getAttribute("sId");	
		String pay_pwd = map.get("pay_pwd");
		System.out.println("pay_pwd : " + map.get("pay_pwd"));
		
		// 회원 엑세스토큰 정보 저장된 BankToken객체 session에서 꺼내서 'token'으로 저장
		BankToken token = (BankToken)session.getAttribute("token");		
		
		// 1) 로그인 안 되어 있으면 로그인페이지로 이동
		// 2) session에 token 없거나 token에 엑세스 토큰 없으면 계좌인증페이지로 이동
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			// 로그인 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayManage");
			return "result/fail";
		} else if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "계좌인증 필수!");
			model.addAttribute("targetURL", "TechPayMain");
			// 계좌인증 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayManage");
			return "result/fail";			
		}
		
		// TechPayService - registPayPwd() 메서드 호출하여 테크페이 비밀번호 정보 저장
		techPayService.setPayPwd(id, pay_pwd);
		
		model.addAttribute("msg", "비밀번호 설정 완료!");
		model.addAttribute("isClose", true);		
		model.addAttribute("targetURL", "PayManage");	
		
		return "result/success";
	}
	
	
}
