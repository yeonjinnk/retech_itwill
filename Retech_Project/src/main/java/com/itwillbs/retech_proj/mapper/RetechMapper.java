package com.itwillbs.retech_proj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;


public interface RetechMapper {
	// 연관검색어 조회
	List<String> selectRelationKeyWord(String searchKeyword);
	
	// 멤버아이디 조회(닉네임으로)
	String selectMemberId(String q);

	// 인기검색어 TOP10 조회
	List<Map<String, String>> selectSearchList();
	// 검색 내용 디비에 존재유무 조회
	int selectWord(String searchKeyword);
	// 존재한 검색어 조회수 증가
	int updateSearchCount(String searchKeyword);
	// 검색내용 디비 저장
	int insertKeyword(String searchKeyword);
	// 인기검색어 삭제(delete_status 컬럼 1로 변경)
	int updateContent(String searchKeyword);


}
