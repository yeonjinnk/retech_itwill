package com.itwillbs.retech_proj.mapper;

import com.itwillbs.retech_proj.vo.SmsAuthInfo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SmsMapper {

    void insertSmsAuthInfo(SmsAuthInfo smsAuthInfo);

    void updateSmsAuthInfo(SmsAuthInfo smsAuthInfo);

    SmsAuthInfo selectSmsAuthInfo(SmsAuthInfo smsAuthInfo);

    int updatePhoneAuth(String userId);
}
