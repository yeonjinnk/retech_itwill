package com.itwillbs.retech_proj.service;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.handler.SendSmsClient;
import com.itwillbs.retech_proj.mapper.SmsMapper;
import com.itwillbs.retech_proj.vo.SmsAuthInfo;

@Service
public class SmsService {

    @Autowired
    private SmsMapper mapper;

    // 인증 SMS 발송 및 인증 정보 객체 생성
    public SmsAuthInfo sendAuthSMS(String id, String phoneNumber) {
        // 인증 코드 생성
        String authCode = generateAuthCode();
        System.out.println("생성된 인증 코드: " + authCode);

        String content = "리테크의 인증번호는 [" + authCode + "]입니다. 인증번호를 입력해주세요.";

        try {
            // SMS 발송 후 성공 여부 확인
            boolean isSent = SendSmsClient.sendSms(phoneNumber, content);
            System.out.println("SMS 발송 성공 여부: " + isSent);

            // SMS 발송 실패 시 null 반환
            if (!isSent) {
                return null;
            }

            // SmsAuthInfo 객체 생성 및 리턴
            SmsAuthInfo smsAuthInfo = new SmsAuthInfo();
            smsAuthInfo.setPhone_number(phoneNumber);
            smsAuthInfo.setAuth_code(authCode);
            smsAuthInfo.setStatus("PENDING"); // 초기 상태 설정
            return smsAuthInfo;
        } catch (Exception e) {
            System.err.println("SMS 발송 중 오류 발생: " + e.getMessage());
            return null;
        }
    }

    // 문자 인증 정보 등록 요청
    public void registSmsAuthInfo(SmsAuthInfo smsAuthInfo) {
        // 기존 인증 정보 확인
        SmsAuthInfo dbSmsAuthInfo = mapper.selectSmsAuthInfo(smsAuthInfo);
        System.out.println("조회된 인증 정보: " + dbSmsAuthInfo);

        if (dbSmsAuthInfo == null) {
            // 새 인증 정보 등록
            mapper.insertSmsAuthInfo(smsAuthInfo);
        } else {
            // 기존 인증 정보 갱신
            mapper.updateSmsAuthInfo(smsAuthInfo);
        }
    }

    // 문자 인증 정보 조회
    public SmsAuthInfo getSmsAuthInfo(SmsAuthInfo smsAuthInfo) {
        return mapper.selectSmsAuthInfo(smsAuthInfo);
    }

    // 인증 코드 생성
    private String generateAuthCode() {
        Random r = new Random();
        int rNum = r.nextInt(1000000); // 0 ~ 999999 까지의 난수 생성
        return String.format("%06d", rNum); // 6자리로 포맷팅
    }

    // 휴대번호 인증 상태 변경 요청
    public int changePhoneAuth(String id) {
        return mapper.updatePhoneAuth(id);
    }
}
