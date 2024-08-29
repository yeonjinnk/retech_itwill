package com.itwillbs.retech_proj.vo;

import lombok.Data;

//2.1.2. 토큰발급 API - 사용자 토큰발급 API (3-legged) 요청에 대한 응답 데이터 관리할 클래스 정의
// => 멤버변수로 응답 데이터 파라미터명과 1:1로 대응하는 멤버변수 선언
//    (주의! 자동으로 파싱되어야 하기 때문에 파라미터명과 멤버변수명이 완벽하게 일치해야함)
@Data
public class BankToken {
	private String id;
	private String access_token;
	private String token_type;
	private String expires_in;
	private String refresh_token;
	private String scope;
	private String user_seq_no;
	private String user_ci;
	private String fintech_use_num;
	// -----------------------------
	private String client_use_code; // 관리자 토큰용
	// -----------------------------
	private String name; // 관리자 토큰용
	
}













