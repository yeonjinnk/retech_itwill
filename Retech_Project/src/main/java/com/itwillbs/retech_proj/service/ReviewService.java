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
	public int insertReview(Map<String, Object> map) {
		return mapper.insertReview(map);
	}

	//리뷰등록시 거래상태 6으로 변경
	public int updateStatus6(Map<String, Object> map) {
		return mapper.updateStatus(map);
	}

	//구매자가 쓴 리뷰 조회
	public List<Map<String, String>> getMyReview(String id) {
		return mapper.selectMyReview(id);
	}

	//판매자가 받은 리뷰 조회
	public List<Map<String, String>> getSellerReview(String id) {
		return mapper.selectSellerReview(id);
	}

}
