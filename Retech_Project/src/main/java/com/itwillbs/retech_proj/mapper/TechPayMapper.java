package com.itwillbs.retech_proj.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.BankToken;

@Mapper
public interface TechPayMapper {
	// 핀테크 사용자 정보 조회
	BankToken selectBankUserInfo(String id);

	// 핀테크 사용자 아이디 정보 조회 -> 아이디 리턴
	String selectId(Map<String, Object> map);

	// 엑세스 토큰 정보 추가
	void insertAccessToken(Map<String, Object> map);

	// 엑세스 토큰 정보 갱신
	void updateAccessToken(Map<String, Object> map);

	// 테크페이 초기 정보 저장
	void insertPayInfo(String id);

	// 테크페이 비밀번호 정보 조회
	String selectPayPwd(String id);
	
	// 테크페이 잔액 정보 조회
	String selectPayBalance(String id);

	// 테크페이 비밀번호 정보 저장
	void updatePayPwd(@Param("id") String id, @Param("pay_pwd") String pay_pwd);

	// 관리자 엑세스토큰 조회
	BankToken selectAdminAccessToken();
	
	// 테크페이 잔액 충전
//	void updatePayBalance(@Param("id") String id, @Param("tran_amt") String tran_amt);

	// 테크페이 잔액 환급
//	void updatePayBalance2(@Param("id") String id, @Param("amt") String amt);

	// 테크페이 잔액 차감 - 사용	
//	void updatePayBalance3(@Param("id") String id, @Param("paymentAmount") String paymentAmount);

	// 테크페이 잔액 충전 - 수익		
//	void updatePayBalance4(@Param("id") String id, @Param("profitAmount") String profitAmount);

	// 테크페이 내역 DB에 추가		
	void insertPayHistory(Map<String, Object> map);

	// 테크페이 잔액 업데이트
	void updatePayBalance(Map<String, Object> map2);

}
