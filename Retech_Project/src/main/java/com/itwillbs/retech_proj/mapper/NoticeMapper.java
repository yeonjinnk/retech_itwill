package com.itwillbs.retech_proj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.NoticeVO;

@Mapper
public interface NoticeMapper {

	int selectNoticeListCount(String searchKeyword);

	List<NoticeVO> selectNoticeList(@Param("startRow") int startRow, 
									@Param("listLimit") int listLimit,
									@Param("searchKeyword") String searchKeyword);

	NoticeVO selectNotice(int notice_idx);

}
