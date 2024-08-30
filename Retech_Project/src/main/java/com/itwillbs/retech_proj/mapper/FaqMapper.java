package com.itwillbs.retech_proj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.FaqVO;


@Mapper
public interface FaqMapper {

	// FAQ 게시물 개수
	int selectFaqListCount(String searchKeyword);

	// FAQ 게시물 목록
	List<FaqVO> selectFaqList(@Param("startRow") int startRow, 
							  @Param("listLimit") int listLimit,
							  @Param("searchKeyword") String searchKeyword);

	FaqVO selectFaq(int faq_idx);


	
	

}
