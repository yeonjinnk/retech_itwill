package com.itwillbs.retech_proj.controller;

import java.security.PrivateKey;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.retech_proj.handler.BankValueGenerator;
import com.itwillbs.retech_proj.handler.RsaKeyGenerator;
import com.itwillbs.retech_proj.handler.TechPayIdxGenerator;
import com.itwillbs.retech_proj.service.TechPayService;
import com.itwillbs.retech_proj.vo.BankToken;
import com.itwillbs.retech_proj.vo.TechPayInfoVO;

@Controller
public class TechPayController {
	@Autowired
	private TechPayService techPayService;
	
	@Autowired
	private BankValueGenerator bankValueGenerator;	
	
	@Autowired
	private TechPayIdxGenerator techPayIdxGenerator;	
	
	// 로그를 사용하여 메세지를 다룰 현재 클래스 지정
	private static final Logger logger = LoggerFactory.getLogger(TechPayController.class);
	
	@GetMapping("TechPayMain")
	public String techPayMain(HttpSession session, Model model, HttpServletResponse response, Map<String, Object> map) {
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
		
		map.put("id", id);
		
		
		if(token == null) {
			System.out.println("토큰 없음");
			return "techpay/account_verify";			
		} else {
			return "techpay/techpay_info";			
		}
		
	}

	@GetMapping("AccVerify")
	public String accVerify(HttpSession session, Model model) {
		// 로그인 완료 되어 있는 회원만 테크페이 계좌연결 페이지로 진입 가능함
		String id = (String)session.getAttribute("sId");		
		if(id == null) {
			model.addAttribute("msg", "로그인한 후에 이용 할 수 있습니다!");
			model.addAttribute("isClose", true);
			model.addAttribute("targetURL", "MemberLogin");
			session.setAttribute("prevURL", "TechPayMain");
			
			return "result/fail";
		}		
		return "techpay/account_verify";
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
		
		// TechPayMapper - selectTokenInfo() 메서드 호출하여 테크페이 정보 테이블의 아이디 조회
		String payInfoId = techPayService.selectPayInfoId(id);

		// 테크페이 정보 테이블에 아이디가 없다면
		if(payInfoId == null) {
			// techPayService - registPayInfo() 메서드 호출하여 테크페이 초기 정보 저장
			int insertCount = techPayService.registPayInfo(id);
			
				// 정보 저장이 이루어졌다면
				if(insertCount > 0) {
					System.out.println("테크페이 초기 정보 저장 완료!");
					
					model.addAttribute("msg", "계좌 인증 완료!");
					model.addAttribute("isClose", true);
					model.addAttribute("targetURL", "TechPayMain");	
					return "result/success";
					
				} else {
					model.addAttribute("msg", "계좌 인증 실패!");
					return "result/fail";
				}
				
		// 테크페이 정보 테이블에 아이디가 있다면
		} else {
			model.addAttribute("msg", "계좌 인증 완료!");
			model.addAttribute("targetURL", "TechPayMain");		
			
			return "result/success";
		}
		
	}


	
	@GetMapping("PayManage")	
	public String payManage(TechPayInfoVO techPayInfoVO, HttpSession session, Model model) {
		// 회원 엑세스토큰 정보 저장된 BankToken객체 session에서 꺼내서 'token'으로 저장
		BankToken token = (BankToken)session.getAttribute("token");
		System.out.println("-------------PayManage - token : " + token);
		
		
//		 =============================== 아이디/패스워드 복호화 ===============================
//		System.out.println("암호화 된 패스워드 : " + techPayInfoVO.getPay_pwd()); // 테크페이 비밀번호 VO 가져오기 
		
		// 테크페이 비밀번호 암호화 과정에서 사용할 공개키/개인키 생성
//		Map<String, Object> rsaKey = RsaKeyGenerator.generateKey();
//		
//		session.setAttribute("RSAPrivateKey", rsaKey.get("RSAPrivateKey"));
//		model.addAttribute("RSAModulus", rsaKey.get("RSAModulus"));
//		model.addAttribute("RSAExponent", rsaKey.get("RSAExponent"));		
		
		
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
			model.addAttribute("targetURL", "AccVerify");
			// 계좌인증 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayManage");
			return "result/fail";	
			
		// API 응답코드가 "A0000"이 아닐 경우, 요청 처리 실패		
		} else if(!accountList.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", accountList.get("rsp_message"));
			return "result/fail";				
		}
		
		model.addAttribute("accountList", accountList);
		
		return "techpay/techpay_manage";		
	}	
	
	
	@GetMapping("PayPwdSet")
	public String payPwdSet(TechPayInfoVO techPayInfoVO, BCryptPasswordEncoder passwordEncoder, HttpSession session, Model model, @RequestParam Map<String, String> map) {
		String id = (String)session.getAttribute("sId");	
		String pay_pwd = map.get("pay_pwd");
		System.out.println("비밀번호설정 ----------------- pay_pwd : " + map.get("pay_pwd"));
		
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
		int updateCount = techPayService.setPayPwd(id, pay_pwd);
		
		if(updateCount > 0) {
			model.addAttribute("msg", "테크페이 비밀번호 설정 완료!");
			model.addAttribute("targetURL", "TechPayMain");	
			
			return "result/success";
		} else {
			model.addAttribute("msg", "테크페이 비밀번호 설정 실패!");
			System.out.println("테크페이 비밀번호 DB 저장 실패");			
			return "result/fail";
			
		}
		
	}	
	
	@GetMapping("AccountDetail")
	public String accountDetail(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		logger.info(">>>>>>>잔액 조회 요청 파라미터 : " + map);
		
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
		
		// 파라미터가 저장된 Map 객체에 BankToken 객체 추가
		map.put("token", token);
		
		
		// 2.3.1. 잔액조회 API
		Map<String, String> accountDetail = techPayService.getAccountDetail(map);
		System.out.println("---------------잔액조회 결과 : " + accountDetail);		
		
		// API 응답코드가 "A0000"이 아닐 경우, 요청 처리 실패
		if(!accountDetail.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", accountDetail.get("rsp_code"));
			return "result/fail";
		}
		
		model.addAttribute("accountDetail", accountDetail);
		model.addAttribute("account_holder_name", map.get("account_holder_name"));
		model.addAttribute("account_num_masked", map.get("account_num_masked"));
		
		
		return "techpay/account_detail";
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
		int count = techPayService.registAdminAccessToken(map);
		
		if(count > 0) {
			model.addAttribute("msg", "관리자 토큰 발급 성공!");
			model.addAttribute("targetURL", "TechPayMain");
			
			return "result/success";
		} else {
			model.addAttribute("msg", "관리자 토큰 발급 실패!");
			System.out.println("관리자 토큰 DB 저장 실패");
			
			return "result/fail";
		}
		
	}

	@GetMapping("CheckPayPwd")
	public String checkPayPwd(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		
		return "techpay/check_pay_pwd";
	}
	
	
	
	@GetMapping("PayCharge")	
	public String payCharge(HttpSession session, Model model) {
		// 회원 엑세스토큰 정보 저장된 BankToken객체 session에서 꺼내서 'token'으로 저장
		BankToken token = (BankToken)session.getAttribute("token");
		System.out.println("--------------token : " + token);
		
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
		
		// 2.2.3. 등록계좌조회 API
		// TechPayService - getBankAccountList() 메서드
		Map<String, Object> accountList = techPayService.getBankAccountList(token);
		System.out.println("------------- 등록계좌조회 결과 : " + accountList);
		logger.info(">>>>>>>>>>>>> 등록계좌조회 결과 : " + accountList);		

		// API 응답코드가 "A0000"이 아닐 경우, 요청 처리 실패		
		if(!accountList.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", accountList.get("rsp_message"));
			return "result/fail";			
		}	
		
		// Model 객체에 등록계좌조회 결과 저장
		model.addAttribute("accountList", accountList);		
		
		return "techpay/techpay_charge";		
	}
	
	@PostMapping("ChargeBankWithdraw")
	public String chargeBankWithdraw(@RequestParam Map<String, Object> map, HttpSession session, Model model, Map<String, Object> map2) {
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
		System.out.println("-------------------ChargeBankWithdraw - map : " + map);
		map.put("token", token);
		map.put("id", id);
		System.out.println("-------------------출금이체 요청 파라미터 : " + map);
		
		// 2.5.1. 출금이체 API
		// TechPayService - requestWithdraw() 메서드
		Map<String, String> chargeWithdrawResult = techPayService.requestWithdraw(map);
		System.out.println("------------- 출금이체 결과 : " + chargeWithdrawResult);

		// API 응답코드가 "A0000"이 아닐 경우, 요청 처리 실패
		if(!chargeWithdrawResult.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", chargeWithdrawResult.get("rsp_message"));
			return "result/fail";			
		}

		// Model 객체에 출금이체 결과 저장
		model.addAttribute("chargeWithdrawResult", chargeWithdrawResult);			
		
		// 테크페이 타입 지정
		int techpay_type = 1;
		
		// 테크페이 거래 시간 생성
		String techpay_tran_dtime = bankValueGenerator.getTranDTime();
		System.out.println("-------------techpay_tran_dtime : " + techpay_tran_dtime);
		
		// 테크페이 idx 생성
		String techpay_idx = techPayIdxGenerator.generateTechPayIdx(id, techpay_type);
		System.out.println("---------------------techpay_idx : " + techpay_idx);
		
		if(techpay_idx.length() != 10) {
			model.addAttribute("msg", "테크페이 idx 생성 오류! 관리자에게 문의 바랍니다!");		
			model.addAttribute("targetURL", "PayCharge");		
			return "result/fail";			
		}
		
		String tran_amt = "50000"; // 임의 금액 설정
		
		// 테크페이 잔액 최대 한도는 500만원
//	Object pay_balance = session.getAttribute("pay_balance");
//	System.out.println("===============ChargeBankWithdraw pay_balance : " + pay_balance);
		
		// 테크페이 잔액 업데이트에 필요한 정보 map 객체에 저장		
		map2.put("id", id);
		map2.put("tran_amt", tran_amt);
		map2.put("techpay_type", techpay_type);
		
		
		// 테크페이 내역 DB에 추가에 필요한 정보 map 객체에 저장		
		map2.put("techpay_idx", techpay_idx);
		map2.put("techpay_tran_dtime", techpay_tran_dtime);
		map2.put("pay_balance", session.getAttribute("pay_balance"));
		
		
		// 테크페이 잔액 업데이트 - 충전		
		// TechPayService - registPayBalance() 메서드
		int updateCount = techPayService.registPayBalance(map2);	
		
		if(updateCount > 0) {
			System.out.println("테크페이 잔액 업데이트(충전) 성공");
			
			// 테크페이 내역 DB에 추가
			// TechPayService - registPayHistory() 메서드
			int insertCount = techPayService.registPayHistory(map2);
			
			if(insertCount > 0) {
				return "techpay/techpay_charge_result";
			} else {
				model.addAttribute("msg", "테크페이 충전 실패!");
				System.out.println("테크페이 잔액 충전 내역 DB 저장 실패");
				return "result/fail";
			}		
			
		} else {
			model.addAttribute("msg", "테크페이 충전 실패!");
			System.out.println("테크페이 잔액 업데이트(충전) 실패");
			return "result/fail";
		}		
		
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

		// API 응답코드가 "A0000"이 아닐 경우, 요청 처리 실패
		if(!accountList.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", accountList.get("rsp_message"));
			return "result/fail";			
		}
		
		// Model 객체에 등록계좌조회 결과 저장
		model.addAttribute("accountList", accountList);				
		
		return "techpay/techpay_refund";
	}

		
	
	@PostMapping("RefundBankDeposit")
	public String refundBankDeposit(@RequestParam Map<String, Object> map, HttpSession session, Model model, Map<String, Object> map2) {
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
		
		String tran_amt = "70000"; // 임의 금액 설정
		
		
		String payBalanceStr = (String)session.getAttribute("pay_balance");
		int pay_balance = Integer.parseInt(payBalanceStr);
		int result_balance = pay_balance - Integer.parseInt(tran_amt);
		
		if(result_balance < 0) {
			model.addAttribute("msg", "테크페이 잔액이 환급 요청 금액보다 많아야 환급이 가능합니다!");
			System.out.println("테크페이 잔액 환급 실패 (잔액이 70,000원이하)");
			return "result/fail";
		} else {
			// 2.5.2. 입금 이체 API
			// TechPayService - requestDeposit() 메서드	
			Map<String, Object> refundDepositResult = techPayService.requestDeposit(map);
			System.out.println("------------- 입금이체 결과 : " + refundDepositResult);

			// API 응답코드가 "A0000"이 아닐 경우, 요청 처리 실패			
			if(!refundDepositResult.get("rsp_code").equals("A0000")) {
				model.addAttribute("msg", refundDepositResult.get("rsp_message"));
				return "result/fail";					
			}
				
			// Model 객체에 입금이체 결과 저장		
			model.addAttribute("refundDepositResult", refundDepositResult);
			
			// 테크페이 타입 지정
			int techpay_type = 2;
			
			
			// 테크페이 거래 시간 생성
			String techpay_tran_dtime = bankValueGenerator.getTranDTime();
			System.out.println("-------------techpay_tran_dtime : " + techpay_tran_dtime);
			
			
			// 테크페이 idx 생성
			String techpay_idx = techPayIdxGenerator.generateTechPayIdx(id, techpay_type);
			System.out.println("---------------------techpay_idx : " + techpay_idx);		
			
			
			// 테크페이 잔액 업데이트에 필요한 정보 map 객체에 저장	
			map2.put("id", id);		
			map2.put("techpay_type", techpay_type);	
			map2.put("tran_amt", tran_amt);	
			
			
			// 테크페이 내역 DB에 추가에 필요한 정보 map 객체에 저장		
			map2.put("techpay_idx", techpay_idx);
			map2.put("techpay_tran_dtime", techpay_tran_dtime);
			map2.put("pay_balance", session.getAttribute("pay_balance"));		
			
			
			// 테크페이 잔액 업데이트 - 환급
			// TechPayService - registPayBalance() 메서드
			int updateCount = techPayService.registPayBalance(map2);
			
			if(updateCount > 0) {
				System.out.println("테크페이 잔액 업데이트(환급) 성공");	
				
				// 테크페이 내역 DB에 추가
				// TechPayService - registPayHistory() 메서드
				int insertCount = techPayService.registPayHistory(map2);		
				
				if(insertCount > 0) {
					return "techpay/techpay_refund_result";
				} else {
					model.addAttribute("msg", "테크페이 환급 실패!");
					System.out.println("테크페이 잔액 환급 내역 DB 저장 실패");
					return "result/fail";
				}				
				
			} else {
				model.addAttribute("msg", "테크페이 환급 실패!");
				System.out.println("테크페이 잔액 업데이트(환급) 실패");
				return "result/fail";
			}
			
		}
		
	}
	
	@GetMapping("TechPayments")
	public String techPayments(HttpSession session, Model model, Map<String, String> map) {
		String id = (String)session.getAttribute("sId");		
		
		// 회원 엑세스토큰 정보 저장된 BankToken객체 session에서 꺼내서 'token'으로 저장
		BankToken token = (BankToken)session.getAttribute("token");		
		System.out.println("--------------TechPayments token : " + token);
		
		// 로그인 안 되어 있으면 로그인페이지로 이동
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			// 로그인 후 현재 페이지로 돌아옴
			session.setAttribute("prevURL", "PayManage");
			return "result/fail";
		}
		
		// 2.2.3. 등록계좌조회 API
		// TechPayService - getBankAccountList() 메서드
		Map<String, Object> accountList = techPayService.getBankAccountList(token);
		System.out.println("------------- 등록계좌조회 결과 : " + accountList);
		logger.info(">>>>>>>>>>>>> 등록계좌조회 결과 : " + accountList);		

		// API 응답코드가 "A0000"이 아닐 경우, 요청 처리 실패
		if(!accountList.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", accountList.get("rsp_message"));
			return "result/fail";			
		}	
		
		
		// Model 객체에 등록계좌조회 결과 저장
		model.addAttribute("accountList", accountList);				

		// 상품 금액 임의 설정
		int productAmount = 110000; // 상품 금액 임의 설정
		String paymentAmount = Integer.toString(productAmount);
		
		map.put("paymentAmount", paymentAmount);
		
		return "techpay/techpay_payments";
	}
	
	@PostMapping("TechPaymentsProcess")	
	public String techPaymentsProcess(HttpSession session, Model model, @RequestParam Map<String, String> map, Map<String, Object> map2) {
		String id = (String)session.getAttribute("sId");	
		
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
		
		// 테크페이 타입 지정
		int techpay_type = 3;

		// 테크페이 거래 시간 생성
		String techpay_tran_dtime = bankValueGenerator.getTranDTime();
		System.out.println("-------------techpay_tran_dtime : " + techpay_tran_dtime);
		
		// 테크페이 idx 생성
		String techpay_idx = techPayIdxGenerator.generateTechPayIdx(id, techpay_type);
		System.out.println("---------------------techpay_idx : " + techpay_idx);			
		
		String tran_amt = map.get("tran_amt");

		// 테크페이 잔액 업데이트에 필요한 정보 map 객체에 저장			
		map2.put("id", id);		
		map2.put("techpay_type", techpay_type);		
		map2.put("tran_amt", tran_amt);		
		
		// 테크페이 내역 DB에 추가에 필요한 정보 map 객체에 저장		
		map2.put("techpay_idx", techpay_idx);
		map2.put("techpay_tran_dtime", techpay_tran_dtime);
		map2.put("pay_balance", session.getAttribute("pay_balance"));			
		
		// 테크페이 잔액 업데이트 - 사용
		// TechPayService - registPayBalance() 메서드
		int updateCount = techPayService.registPayBalance(map2);
		
		if(updateCount > 0) {
			System.out.println("테크페이 잔액 업데이트(결제) 성공");
			
			// 테크페이 내역 DB에 추가
			// TechPayService - registPayHistory() 메서드
			int insertCount = techPayService.registPayHistory(map2);
			
			if(insertCount > 0) {
//				model.addAttribute("msg", "결제 완료!");
//				model.addAttribute("targetURL", "TechPayMain");
//				
//				return "result/success";
				return "techpay/techpay_payments_result";				
			} else {
				model.addAttribute("msg", "테크페이 결제 실패!");
				System.out.println("테크페이 결제 내역 DB 저장 실패");
				return "result/fail";
			}		
			
		} else {
			model.addAttribute("msg", "테크페이 충전 실패!");
			System.out.println("테크페이 잔액 업데이트(결제) 실패");
			return "result/fail";
		}			
		
		
	}
	
	@GetMapping("TechProfit")
	public String techProfit(HttpSession session, Model model, Map<String, Object> map2) {
		String id = (String)session.getAttribute("sId");	
		
		// 회원 엑세스토큰 정보 저장된 BankToken객체 session에서 꺼내서 'token'으로 저장
		BankToken token = (BankToken)session.getAttribute("token");			

		// 상품 금액 임의 설정
		String tran_amt = "150000"; // 상품 금액 임의 설정		
		
		// 테크페이 타입 지정
		int techpay_type = 4;

		// 테크페이 거래 시간 생성
		String techpay_tran_dtime = bankValueGenerator.getTranDTime();
		System.out.println("-------------techpay_tran_dtime : " + techpay_tran_dtime);
		
		// 테크페이 idx 생성
		String techpay_idx = techPayIdxGenerator.generateTechPayIdx(id, techpay_type);
		System.out.println("---------------------techpay_idx : " + techpay_idx);			

		// 테크페이 잔액 업데이트에 필요한 정보 map 객체에 저장	
		map2.put("id", id);
		map2.put("techpay_type", techpay_type);			
		map2.put("tran_amt", tran_amt);		
		
		// 테크페이 내역 DB에 추가에 필요한 정보 map 객체에 저장		
		map2.put("techpay_idx", techpay_idx);
		map2.put("techpay_tran_dtime", techpay_tran_dtime);
		map2.put("pay_balance", session.getAttribute("pay_balance"));			
		
		// 테크페이 잔액 업데이트 - 수익
		// TechPayService - registPayBalance() 메서드
		int updateCount = techPayService.registPayBalance(map2);

		if(updateCount > 0) {
			System.out.println("테크페이 잔액 업데이트(수익) 성공");
			
			// 테크페이 내역 DB에 추가
			// TechPayService - registPayHistory() 메서드
			int insertCount = techPayService.registPayHistory(map2);
			
			if(insertCount > 0) {
				return "techpay/techpay_profit_result";
			} else {
				model.addAttribute("msg", "테크페이 수익처리 실패!");
				System.out.println("테크페이 수익 내역 DB 저장 실패");
				return "result/fail";
			}		
			
		} else {
			model.addAttribute("msg", "테크페이 수익처리 실패!");
			System.out.println("테크페이 잔액 업데이트(수익) 실패");
			return "result/fail";
		}			
		
	}
}
