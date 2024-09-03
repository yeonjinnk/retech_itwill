package com.itwillbs.retech_proj.handler;

import org.springframework.stereotype.Component;

@Component
public class TechPayIdxGenerator {
	
	public String generateTechPayIdx(String id, int techpay_type) {
		// techpay_idx를 총 10글자로 생성하는 함수
		// "TP" (techpay의 약자)
		// + "테크페이 타입별 영문 두 글자"
		// + "아이디 첫 두 글자를 영문 대문자로 변환한 두 글자" 
		// + "난수로 생성한 숫자 영어대문자 4자리"
		
		
		String techpay_idx = "TP";
		
		// 테크페이 타입별 영문 두 글자 추가
		String typePrefix = "";
        switch (techpay_type) {
        case 1:
            typePrefix = "CH"; // 충전
            break;
        case 2:
            typePrefix = "RF"; // 환급
            break;
        case 3:
            typePrefix = "US"; // 사용
            break;
        case 4:
            typePrefix = "PR"; // 수익
            break;
        }		
        techpay_idx += typePrefix;
        
        
        // 아이디 첫 두 글자를 영문 대문자로 변환하여 추가
        String idPrefix = "";
        idPrefix = id.substring(0, 2).toUpperCase();
        techpay_idx += idPrefix;      
        
        
		// 난수로 숫자 + 영어대문자 4자리 생성		
		String randomPrefix = "";
		randomPrefix = GenerateRandomCode.getRandomCode(4).toUpperCase();
        techpay_idx += randomPrefix; 		
        
		
		return techpay_idx;
	}

}
