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
	int insertReview(Map<String, String> map);

}
