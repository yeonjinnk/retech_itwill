package com.itwillbs.retech_proj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.FaqMapper;
import com.itwillbs.retech_proj.vo.FaqVO;



@Service
public class FaqService {
	@Autowired
    private FaqMapper mapper;

	public int getFaqListCount(String searchKeyword) {
		return mapper.selectFaqListCount(searchKeyword);
	}

	public List<FaqVO> getFaqList(int startRow, int listLimit, String searchKeyword) {
		return mapper.selectFaqList(startRow, listLimit, searchKeyword);
	}

	// FAQ 상세보기
	public FaqVO getFaq(int FAQ_idx) {
		return mapper.selectFaq(FAQ_idx);
	}
	



}