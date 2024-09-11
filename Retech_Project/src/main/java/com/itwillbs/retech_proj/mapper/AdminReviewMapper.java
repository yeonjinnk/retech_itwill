package com.itwillbs.retech_proj.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.ReviewVO;
import com.itwillbs.retech_proj.vo.TradeVO;



@Mapper
public interface AdminReviewMapper {

	int selectAdminReviewListCount(String searchKeyword);

	List<ReviewVO> selectAdminReview(@Param("startRow") int startRow, @Param("listLimit") int listLimit,
			@Param("searchKeyword") String searchKeyword);

	int deleteReview(int review_idx);

	int selectAdminTradeListCount(String searchKeyword);

	List<TradeVO> selectAdminTrade(@Param("startRow") int startRow, @Param("listLimit") int listLimit,
			@Param("searchKeyword") String searchKeyword);

	int deleteTrade(int trade_idx);




}
