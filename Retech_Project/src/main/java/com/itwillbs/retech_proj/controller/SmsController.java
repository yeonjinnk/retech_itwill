package com.itwillbs.retech_proj.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.retech_proj.service.SmsService;
import com.itwillbs.retech_proj.vo.SmsAuthInfo;

@Controller
public class SmsController {

    private static final Logger logger = LoggerFactory.getLogger(SmsController.class);

    @Autowired
    private SmsService service;

    // 인증번호 전송
    @ResponseBody
    @PostMapping("SendSms")
    public String sendSms(HttpSession session, @RequestParam String phone_number, @RequestParam String name) {
        Map<String, Object> resultMap = new HashMap<>();

        try {
            // 세션에서 사용자 ID를 가져옴
            String id = (String) session.getAttribute("sId");

            // 문자 인증 발송 요청
            SmsAuthInfo smsAuthInfo = service.sendAuthSMS(id, phone_number);

            if (smsAuthInfo != null) {
                // 문자 인증 정보 등록
                service.registSmsAuthInfo(smsAuthInfo);
                resultMap.put("result", true);
                resultMap.put("redirectUrl", "/member/member_pw_reset"); // 리디렉션 URL 추가
            } else {
                resultMap.put("result", false);
            }
        } catch (Exception e) {
            logger.error("인증번호 전송 중 오류 발생: ", e);
            resultMap.put("result", false);
        }

        // Map 객체를 JSON 객체 형식으로 변환
        JSONObject jo = new JSONObject(resultMap);
        logger.info("응답 JSON 데이터: {}", jo.toString());

        return jo.toString();
    }

    // 인증번호 확인
    @ResponseBody
    @PostMapping("VerifyCode")
    public String verifyCode(HttpSession session, @RequestParam String phone_number, @RequestParam String auth_code) {
        Map<String, Object> resultMap = new HashMap<>();

        try {
            // 세션에서 사용자 ID를 가져옴
            String id = (String) session.getAttribute("sId");

            // SmsAuthInfo 객체 생성 후 인증 정보 조회
            SmsAuthInfo smsAuthInfo = new SmsAuthInfo(phone_number, auth_code, null, null);
            SmsAuthInfo storedInfo = service.getSmsAuthInfo(smsAuthInfo);

            if (storedInfo != null && storedInfo.getAuth_code().equals(auth_code)) {
                // 인증 성공 시 phone_auth_status = 'Y'로 변경
                int updateCount = service.changePhoneAuth(id);
                if (updateCount > 0) { // update 성공
                    resultMap.put("result", true); // 인증 성공
                    resultMap.put("redirectUrl", "/member/member_pw_reset"); // 리디렉션 URL 추가
                } else {
                    resultMap.put("result", false); // 인증 실패
                }
            } else {
                resultMap.put("result", false); // 인증 실패
            }
        } catch (Exception e) {
            logger.error("인증번호 확인 중 오류 발생: ", e);
            resultMap.put("result", false);
        }

        // Map 객체를 JSON 객체 형식으로 변환
        JSONObject jo = new JSONObject(resultMap);
        logger.info("응답 JSON 데이터: {}", jo.toString());

        return jo.toString();
    }
}
