package com.itwillbs.retech_proj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.MemberVO;



@Mapper
public interface AdminMemberMapper {

	// 관리자 - 회원 목록 개수 세기 (검색 기능 추가)
	int selectMemberListCount(String searchKeyword);
	
	// 관리자 - 회원 목록 가져오기 (검색 기능 추가)
	List<MemberVO> selectMemberList(@Param("startRow") int startRow, @Param("listLimit") int listLimit,
									@Param("searchKeyword") String searchKeyword);
	
	// 관리자 권한 부여
	int updateAdminAuth(@Param("member_isAdmin") int member_isAdmin, @Param("member_id") String member_id);


	
}
