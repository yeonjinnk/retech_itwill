package com.itwillbs.retech_proj.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.RetechMapper;

@Service
public class RetechService {
	
	@Autowired
	RetechMapper RetechMapper;
	

	// 연관검색어 조회
	public List<String> getRelationKeyWord(String searchKeyWord) {
		return RetechMapper.selectRelationKeyWord(searchKeyWord);
	}


	// 마이페이지 판매내역 조회
	public String getMemberid(String q) {
		return RetechMapper.selectMemberId(q);
	}


	// 인기검색어 TOP10 조회
	public List<Map<String, String>> getSearchList() {
		return RetechMapper.selectSearchList();
	}


	// 검색내용 디비에 저장
	public int saveKeyword(String searchKeyword) {
	// 검색한 내용의 존재여부 판별
	int search_count = RetechMapper.selectWord(searchKeyword);
	
	if(search_count>0) {
		int updateCount = RetechMapper.updateSearchCount(searchKeyword);
	}else{
		int insertCount = RetechMapper.insertKeyword(searchKeyword);
	}
	
	return 0;
	}

	// 인기검색어 삭제(delete_status 컬럼 1로 변경)
	public int updateKeyword(String content) {
		return RetechMapper.updateContent(content);
	}
	

	
}
