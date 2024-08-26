package com.itwillbs.retech_proj.handler;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Component;

@Component
public class BankValueGenerator {
	
	// 거래고유번호(참가기관) 자동 생성을 위한 getBankTranId() 메서드 정의
	// => 고유번호 생성 형식 : 이용기관코드(10자리) + 생성주체구분코드("U") + 이용기관 부여번호(9자리)
	public String getBankTranId(String client_use_code) {
		String bank_tran_id = "";
		
		// 이용기관 부여번호(9자리) 생성 => 난수 활용
		// 미리 정의해 놓은 GenerateRandomCode - getRandomCode() 메서드 사용
		bank_tran_id = client_use_code + "U" + GenerateRandomCode.getRandomCode(9).toUpperCase();
		
		return bank_tran_id;
	}

	// 작업 요청일시(거래시간 등) 자동 생성하기 위한 getTranDTime() 메서드 정의
	// => 파라미터 : 없음   리턴타입 : String
	// => 현재 시스템 날짜 및 시각을 기준으로 14자리 숫자(문자열 타입) 생성(yyyyMMddHHmmss 형식)
	// => java.time.LocalDateTime 클래스 활용
	public String getTranDTime() {
		// 현재 시스템 날짜 및 시각 정보 가져오기
		LocalDateTime localDateTime = LocalDateTime.now();
		
		// LocalXXX 클래스에 대한 포맷팅(형식 지정) 전용 클래스인 
		// java.time.DateTimeFormatter - ofPattern() 메서드 호출하여
		// 변환할 날짜 및 시각의 포맷 형식 문자열 지정
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		
		// LocalDateTime 객체의 format() 메서드 호출하여 포맷 문자열을 적용하여
		// 리턴되는 날짜 및 시각 정보 문자열을 그대로 리턴
		return localDateTime.format(dateTimeFormatter);
	}
	
}












