package com.itwillbs.retech_proj.mapper;

import java.util.List;
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
	int insertAccessToken(Map<String, Object> map);

	// 엑세스 토큰 정보 갱신
	int updateAccessToken(Map<String, Object> map);

	// 테크페이 초기 정보 여부 조회
	String selectPayInfoId(String id);
	
	// 테크페이 초기 정보 저장
	int insertPayInfo(String id);
	
	// 테크페이 비밀번호 정보 조회
	String selectPayPwd(String id);
	
	// 테크페이 잔액 정보 조회
	String selectPayBalance(String id);

	// 테크페이 비밀번호 정보 저장
	int updatePayPwd(@Param("id") String id, @Param("pay_pwd") String pay_pwd);

	// 관리자 엑세스토큰 조회
	BankToken selectAdminAccessToken();
	
	// 테크페이 내역 DB에 추가		
	int insertPayHistory(Map<String, Object> map2);

	// 테크페이 잔액 업데이트
	int updatePayBalance(Map<String, Object> map2);

	// 테크페이 사용 목록 불러오기	
	List<Map<String, Object>> selectPayHistory(Map<String, Object> map);

	// 테크페이 사용 목록 개수 세기(페이징)
	int selectPayHistoryCount(Map<String, Object> map);

	// 결제결과 불러오기
	Map<String, String> selectPaymentsResult(@Param("id") String id, @Param("trade_idx") String trade_idx);

	// 해당 상품 거래 상태 '결제완료'로 업데이트	
	int updateTradeStatus(@Param("id") String id, @Param("trade_idx") String trade_idx);

}
