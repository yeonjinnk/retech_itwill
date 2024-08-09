package com.itwillbs.retech_proj.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.MemberMapper;
import com.itwillbs.retech_proj.mapper.StoreMapper;
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
   public List<Map<String, String>> getorderticket2(int member_num) {
	   return mapper.selectOrderticket2(member_num);
   }
   // 아이디값을 활용해서 멤버 넘 구하기
   public int getMember_num(String id) {
	   // TODO Auto-generated method stub
	   return mapper.selectMember_num(id);
   }

   public List<Map<String, String>> getPaymentInfo(int member_num) {
	   // TODO Auto-generated method stub
	   return mapper.selectPaymentInfo(member_num);
   }

   public StoreVO getItem(StoreVO store) {
	   // TODO Auto-generated method stub
	   return mapper.selectItem2(store);
   }
// 회원 아이디로 비밀번호 찾기
	public MemberVO isExistId(MemberVO member) {
		return mapper.selectId(member);
	}
	
	//회원 비밀번호 변경
	public int modifyPasswd(Map<String, String> map) {
		return mapper.updatePasswd(map);
	}

	// 회원 아이디 전화번호 비교
		public MemberVO isExistPhonenumber(MemberVO member) {
			System.out.println("전화번호 검색 요청 : " + member);
			return mapper.selectTel(member);
		}

	
}
