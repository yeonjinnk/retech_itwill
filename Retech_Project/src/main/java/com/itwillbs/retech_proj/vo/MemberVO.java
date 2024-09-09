package com.itwillbs.retech_proj.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {
    private String member_id;
    private String member_nickname;
    private String member_passwd;
    private String member_name; 
    private Date member_birth; 
    private String member_phone; 
    private String member_status; 
    private String member_mail_auth; 
    private String member_postcode; 
    private String member_address1; 
    private String member_address2;  
    private String member_profile; // 파일 경로를 저장하는 필드
    private int member_isAdmin;
    private Date member_subscription;  
    private MultipartFile profile; // 업로드된 파일을 저장하는 필드
}
