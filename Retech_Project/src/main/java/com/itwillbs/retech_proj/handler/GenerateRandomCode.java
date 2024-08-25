package com.itwillbs.retech_proj.handler;

import java.security.SecureRandom;
import java.util.Random;

import org.apache.commons.lang3.RandomStringUtils;

// 특정 길이의 난수 생성에 사용할 GenerateRandomCode 클래스 정의
public class GenerateRandomCode {
	// 난수 생성하여 문자열로 리턴할 getRandomCode() 메서드 정의
	// => 인스턴스 생성 없이 즉시 호출 가능하도록 static 메서드 정의
	public static String getRandomCode(int length) {

		return RandomStringUtils.randomAlphanumeric(length); // 원하는 자릿수의 알파벳&정수 조합을 문자열로 생성
	}
}









