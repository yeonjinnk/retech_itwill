package com.itwillbs.retech_proj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.CsVO;
import com.itwillbs.retech_proj.vo.FaqVO;
import com.itwillbs.retech_proj.vo.NoticeVO;

@Mapper
public interface ReviewMapper {

	//리뷰 등록
	int insertReview(Map<String, Object> map);
	
	//리뷰등록시 거래상태 6으로 변경
	int updateStatus(Map<String, Object> map);

	//구매자가 쓴 리뷰 조회
	List<Map<String, String>> selectMyReview(String id);

	//판매자가 받은 리뷰 조회
	List<Map<String, String>> selectSellerReview(String id);

}
