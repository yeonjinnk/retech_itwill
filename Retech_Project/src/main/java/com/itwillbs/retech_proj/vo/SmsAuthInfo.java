package com.itwillbs.retech_proj.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class SmsAuthInfo {
	private String phoneNumber;
    private String authCode;
    private String status; // PENDING, VERIFIED, EXPIRED
    private java.sql.Timestamp createdAt;
}
