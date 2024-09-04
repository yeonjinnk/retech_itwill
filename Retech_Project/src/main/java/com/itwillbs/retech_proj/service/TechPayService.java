package com.itwillbs.retech_proj.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.handler.BankApiClient;
import com.itwillbs.retech_proj.mapper.TechPayMapper;
import com.itwillbs.retech_proj.vo.BankToken;

@Service
public class TechPayService {

	@Autowired 
	private BankApiClient bankApiClient;
	
	@Autowired
	private TechPayMapper mapper;
	
	// 핀테크 사용자 정보 조회(DB)
	public BankToken getBankUserInfo(String id) {
		// TechPayMapper - selectBankUserInfo()
		return mapper.selectBankUserInfo(id);
	}

	// 엑세스토큰 발급
	public BankToken getAccessToken(Map<String, String> authResponse) {
		// BankApiClient - requestAccessToken() 메서드 호출하여 엑세스토큰 발급 요청 수행
		return bankApiClient.requestAccessToken(authResponse);
	}

	// 엑세스토큰 저장
	public void registAccessToken(Map<String, Object> map) {
		// TechPayMapper - selectTokenInfo() 메서드 호출하여 아이디에 해당하는 토큰 정보 조회
		String id = mapper.selectId(map);
		System.out.println("토큰 아이디 정보 : " + id);
		
		// 조회된 아이디가 없을 경우(= 엑세스토큰 정보 없음) 새 엑세스토큰 정보 추가(INSERT) - insertAccessToken()
		// 조회된 아이디가 있을 경우(= 엑세스토큰 정보 있음) 새 엑세스토큰 정보 갱신(UPDATE) - updateAccessToken()
		if(id == null) {
			mapper.insertAccessToken(map);
		} else {
			mapper.updateAccessToken(map);
		}
	}
	
	// 테크페이 초기 정보 저장
	public void registPayInfo(String id) {
		mapper.insertPayInfo(id);
	}

	// 2.2.3. 등록계좌조회 API 
	public Map<String, Object> getBankAccountList(BankToken token) {
		return bankApiClient.requestAccountList(token);
	}

	// 테크페이 비밀번호 정보 조회
	public String getPayPwd(String id) {
		return mapper.selectPayPwd(id);
	}
	
	// 테크페이 잔액 정보 조회
	public String getPayBalance(String id) {
		return mapper.selectPayBalance(id);
	}

	// 테크페이 비밀번호 정보 저장
	public void setPayPwd(String id, String pay_pwd) {
		mapper.updatePayPwd(id, pay_pwd);
	}

	// 2.2.1. 사용자정보조회 API	
	public Map<String, Object> getBankUserInfoFromApi(BankToken token) {
		return bankApiClient.requestUserInfo(token);
	}

	// 2.5.1. 출금이체 API
	public Map<String, String> requestWithdraw(Map<String, Object> map) {
		return bankApiClient.requestWithdraw(map);
	}

	// 2.1.2. 관리자 토큰발급 API (2-legged) - 관리자 엑세스토큰 발급용
	public BankToken getAdminAccessToken() {
		return bankApiClient.requestAdminAccessToken();
	}

	// 관리자 엑세스토큰 저장
	public void registAdminAccessToken(Map<String, Object> map) {
		String id = mapper.selectId(map);
		System.out.println("관리자 엑세스 토큰 아이디 정보 : " + id);
		
		// 조회된 아이디가 없을 경우(= 엑세스토큰 정보 없음) 새 엑세스토큰 정보 추가(INSERT) - insertAccessToken()
		// 조회된 아이디가 있을 경우(= 엑세스토큰 정보 있음) 새 엑세스토큰 정보 갱신(UPDATE) - updateAccessToken()
		if(id == null) {
			System.out.println("-----------insertAccessToken-----------");
			mapper.insertAccessToken(map);
		} else {
			System.out.println("-----------updateAccessToken-----------");
			mapper.updateAccessToken(map);
		}		
	}

	// 2.5.2. 입금 이체 API
	public Map<String, Object> requestDeposit(Map<String, Object> map) {
		// TechPayMapper - selectAdminAccessToken() 메서드 호출하여 관리자 엑세스토큰 조회
		BankToken adminToken = mapper.selectAdminAccessToken();
		
		map.put("token", adminToken);
		
		return bankApiClient.requestDeposit(map);
	}

	// 테크페이 잔액 업데이트 - 충전, 환급, 사용, 수익
	public void registPayBalance(Map<String, Object> map2) {
		mapper.updatePayBalance(map2);
	}
	
	// 테크페이 내역 DB에 추가	
	public void registPayHistory(Map<String, Object> map2) {
		mapper.insertPayHistory(map2);
		System.out.println("map2(registPayHistory) : " + map2);
	}

	// 2.3.1. 잔액조회 API	
	public Map<String, String> getAccountDetail(Map<String, Object> map) {
		return bankApiClient.requestAccountDetail(map);
	}
	
	
	
}
