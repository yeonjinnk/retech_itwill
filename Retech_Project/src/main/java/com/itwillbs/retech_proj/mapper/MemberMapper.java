package com.itwillbs.retech_proj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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

	   int selectMember_num(String id);
	 
	   List<Map<String, String>> selectPaymentInfo(int member_num);

	   //=====================================================================================
	   //회원 아이디 조회(채팅용)
	   String selectMemberId(String receiver_id);

	   MemberVO selectByPhoneAndId(@Param("phoneNumber") String phoneNumber, @Param("memberId") String memberId);

	   // 회원 상세 정보 조회
	   MemberVO selectMemberById(@Param("memberId") String memberId);
	   
	   // 인증 코드 조회 쿼리
	   @Select("SELECT verification_code FROM member_verification WHERE member_id = #{memberId}")
	   String selectVerificationCodeByMemberId(@Param("memberId") String memberId);

}
