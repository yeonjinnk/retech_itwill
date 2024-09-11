package com.itwillbs.retech_proj.handler;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;

public class SendSmsClient {
    private static final String SMS_API_URL = "https://api.coolsms.co.kr";
    private static final String API_KEY = "NCSSPRGJU9JFRMUX"; // 실제 API_KEY로 교체하세요
    private static final String API_SECRET = "K3A3TVLQKB9IOL84AP69AYJIZFLSPSLE"; // 실제 API_SECRET로 교체하세요
    private static final String PHONE_NUM = "01050369800"; // 발신 번호를 실제 번호로 교체하세요

    private static DefaultMessageService messageService;

    // Singleton 패턴을 사용하여 DefaultMessageService 객체를 초기화합니다.
    static {
        messageService = NurigoApp.INSTANCE.initialize(API_KEY, API_SECRET, SMS_API_URL);
    }

    public static boolean sendSms(String phoneNumber, String content) {
    	System.out.println(">>>>>>>>>>>>>>> sendSms");
        Message message = new Message();
        message.setFrom(PHONE_NUM);
        message.setTo(phoneNumber);
        message.setText(content);

        try {
            messageService.send(message);
            return true;
        } catch (NurigoMessageNotReceivedException exception) {
//             발송에 실패한 메시지 목록을 확인할 수 있습니다.
            System.out.println("Failed Messages: " + exception.getFailedMessageList());
            System.out.println("Error Message: " + exception.getMessage());
            return false;
        } catch (Exception exception) {
            System.out.println("Error Message: " + exception.getMessage());
            return false;
        }
    }
}
