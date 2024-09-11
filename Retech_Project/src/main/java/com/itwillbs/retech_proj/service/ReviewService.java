package com.itwillbs.retech_proj.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.AdminCsMapper;
import com.itwillbs.retech_proj.mapper.ReviewMapper;
import com.itwillbs.retech_proj.vo.CsVO;
import com.itwillbs.retech_proj.vo.FaqVO;
import com.itwillbs.retech_proj.vo.NoticeVO;



@Service
public class ReviewService {
	@Autowired
	private ReviewMapper mapper;

	//리뷰등록
	public int insertReview(Map<String, String> map) {
		return mapper.insertReview(map);
	}

}
