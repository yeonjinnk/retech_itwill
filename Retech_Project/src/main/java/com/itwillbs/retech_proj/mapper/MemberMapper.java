package com.itwillbs.retech_proj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.retech_proj.vo.MemberVO;
import com.itwillbs.retech_proj.vo.StoreVO;
@Mapper
public interface MemberMapper {

	   int insertMember(MemberVO member);

	   MemberVO selectMember(MemberVO member);

	   int updateMember(Map<String, String> map);

	   int updateWithdrawMember(MemberVO member);

	   MemberVO selectMemberSearchId(MemberVO member);

	   MemberVO selectId(MemberVO member);

	   int updatePasswd(Map<String, String> map);

	   MemberVO selectTel(MemberVO member);

	   int selectListCount(String searchKeyword);

	   List<MemberVO> selectMemberList(int startRow, int listLimit, String searchKeyword);

	   List<Map<String, String>> selectOrderticket2(int member_num);

	   int selectMember_num(String id);
	 
	   List<Map<String, String>> selectPaymentInfo(int member_num);

	   StoreVO selectItem2(StoreVO store);
	   
	   //회원 아이디 조회(채팅용)
	   String selectMemberId(String receiver_id);	

}
