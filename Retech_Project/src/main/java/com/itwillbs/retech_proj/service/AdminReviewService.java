package com.itwillbs.retech_proj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.AdminReviewMapper;
import com.itwillbs.retech_proj.vo.ReviewVO;

@Service
public class AdminReviewService {

	@Autowired
	private AdminReviewMapper mapper;

	public int getReviewListCount(String searchKeyword) {
		return mapper.selectAdminReviewListCount(searchKeyword);
	}

	public List<ReviewVO> getReviewList(int startRow, int listLimit, String searchKeyword) {
		// TODO Auto-generated method stub
		return mapper.selectAdminReview(startRow, listLimit, searchKeyword);
	}

	public int removeReview(int review_idx) {
		// TODO Auto-generated method stub
		return mapper.deleteReview(review_idx);
	}
	

}
