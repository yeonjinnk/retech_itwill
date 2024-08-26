package com.itwillbs.retech_proj.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

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

}
