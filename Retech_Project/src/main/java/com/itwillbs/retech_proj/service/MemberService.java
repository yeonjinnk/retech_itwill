package com.itwillbs.retech_proj.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.handler.SendSmsClient;
import com.itwillbs.retech_proj.mapper.MemberMapper;
import com.itwillbs.retech_proj.vo.MemberVO;

@Service
public class MemberService {
    @Autowired
    private MemberMapper mapper;

    public int registMember(MemberVO member) {
        return mapper.insertMember(member);
    }

    public MemberVO getMember(MemberVO member) {
        return mapper.selectMember(member);
    }

    public int modifyMember(Map<String, String> map) {
        return mapper.updateMember(map);
    }

    public int withdrawMember(MemberVO member) {
        return mapper.updateWithdrawMember(member);
    }

    // 아이디 찾기
    public MemberVO getMemberSearchId(MemberVO member) {
        return mapper.selectMemberSearchId(member);
    }


    // 아이디값을 활용해서 멤버 넘 구하기
    public int getMember_num(String id) {
        return mapper.selectMember_num(id);
    }

    public List<Map<String, String>> getPaymentInfo(int member_num) {
        return mapper.selectPaymentInfo(member_num);
    }

    // 회원 아이디로 비밀번호 찾기
    public MemberVO isExistId(MemberVO member) {
        return mapper.selectId(member);
    }
    
    // 회원 비밀번호 변경
    public int modifyPasswd(MemberVO member) {
        return mapper.updatePasswd(member);
    }

    // 회원 아이디 전화번호 비교
    public MemberVO isExistPhonenumber(MemberVO member) {
        System.out.println("전화번호 검색 요청 : " + member);
        return mapper.selectTel(member);
    }

    //=====================================================================================
    //회원 아이디 조회(채팅용)
	public String getMemberId(String receiver_id) {
		return mapper.selectMemberId(receiver_id);
	}
	
	public MemberVO getMemberByPhoneAndId(String phoneNumber, String memberId) {
	    // 전화번호와 회원 ID를 기준으로 회원 정보를 조회하는 메서드
	    return mapper.selectByPhoneAndId(phoneNumber, memberId);
	}
	
	// SMS 인증 번호 발송
    public boolean sendVerificationCode(String phoneNumber, String verificationCode) {
        String content = "리테크의 인증번호는 [" + verificationCode + "]입니다. 인증번호를 입력해주세요.";
        return SendSmsClient.sendSms(phoneNumber, content);
    }

    // 인증번호 검증
    public boolean verifyVerificationCode(HttpSession session, String inputCode) {
        String storedCode = (String) session.getAttribute("verificationCode");
        System.out.println("Stored Code: " + storedCode);
        System.out.println("Input Code: " + inputCode);
        return storedCode != null && storedCode.equals(inputCode);
    }

    // 카카오서비스
    public MemberVO getMemberFromEmail(String memberId) {
        return mapper.selectMemberFromEmail(memberId);
    }

	
}
