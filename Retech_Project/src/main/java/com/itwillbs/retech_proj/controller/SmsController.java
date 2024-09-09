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

    @ResponseBody
    @PostMapping("/SendSms")
    public String sendSms(HttpSession session, @RequestParam String phone_number, @RequestParam String name) {
        Map<String, Object> resultMap = new HashMap<>();

        try {
            String id = (String) session.getAttribute("sId");

            SmsAuthInfo smsAuthInfo = service.sendAuthSMS(id, phone_number);

            if (smsAuthInfo != null) {
                service.registSmsAuthInfo(smsAuthInfo);
                resultMap.put("result", true);
                resultMap.put("redirectUrl", "/member/member_pw_reset"); // 리디렉션 URL
            } else {
                resultMap.put("result", false);
            }
        } catch (Exception e) {
            logger.error("인증번호 전송 중 오류 발생: ", e);
            resultMap.put("result", false);
        }

        return new JSONObject(resultMap).toString();
    }

    @ResponseBody
    @PostMapping("/VerifyCode")
    public String verifyCode(HttpSession session, @RequestParam String phone_number, @RequestParam String auth_code) {
        Map<String, Object> resultMap = new HashMap<>();

        try {
            String id = (String) session.getAttribute("sId");

            SmsAuthInfo smsAuthInfo = new SmsAuthInfo(phone_number, auth_code, null, null);
            SmsAuthInfo storedInfo = service.getSmsAuthInfo(smsAuthInfo);

            if (storedInfo != null && storedInfo.getAuth_code().equals(auth_code)) {
                int updateCount = service.changePhoneAuth(id);
                if (updateCount > 0) {
                    resultMap.put("result", true);
                    resultMap.put("redirectUrl", "/member/member_pw_reset"); // 리디렉션 URL
                } else {
                    logger.error("Phone auth status 업데이트 실패. id: " + id);
                    resultMap.put("result", false);
                }
            } else {
                logger.error("인증 코드가 맞지 않거나 인증 정보가 존재하지 않습니다.");
                resultMap.put("result", false);
            }
        } catch (Exception e) {
            logger.error("인증번호 확인 중 오류 발생: ", e);
            resultMap.put("result", false);
        }

        return new JSONObject(resultMap).toString();
    }
}
