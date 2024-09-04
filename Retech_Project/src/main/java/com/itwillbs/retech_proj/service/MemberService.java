package com.itwillbs.retech_proj.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.MemberMapper;
import com.itwillbs.retech_proj.vo.MemberVO;
import com.itwillbs.retech_proj.vo.StoreVO;

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
    public int modifyPasswd(Map<String, String> map) {
        return mapper.updatePasswd(map);
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
	

}    
    // SMS 인증
//    public void certifiedPhoneNumber(String phoneNumber, String numStr) {
//        String api_key = "NCSZKCG2GR2BZDI7"; // 여기에 실제 발급받은 API 키를 입력하세요
//        String api_secret = "V3VJ27QUITAHGQS1HVWP97PIEFRG81JM"; // 여기에 실제 발급받은 API Secret을 입력하세요
//
//        // Coolsms 객체 생성
//        Coolsms coolsms = new Coolsms(api_key, api_secret);
//
//        // SMS 발송 파라미터 설정
//        HashMap<String, String> params = new HashMap<>();
//        params.put("to", phoneNumber);    
//        params.put("from", "본인의 휴대폰번호");   
//        params.put("type", "SMS");
//        params.put("text", "작성할내용 [" + numStr + "] 내용");
//        params.put("app_version", "test app 1.2"); // application name and version
//
//        try {
//            // SMS 발송 요청
//            JSONObject obj = (JSONObject) coolsms.send(params);
//            System.out.println(obj.toString());
//        } catch (CoolsmsException e) {
//            System.out.println(e.getMessage());
//            System.out.println(e.getCode());
//        }
//    }
    

