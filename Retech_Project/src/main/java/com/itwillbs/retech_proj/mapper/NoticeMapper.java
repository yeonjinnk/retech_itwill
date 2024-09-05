package com.itwillbs.retech_proj.mapper;

import java.util.List;
import java.util.Map;

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

	int insertTinyReplyNotice(Map<String, String> map);

	void updateTinyReplyNoticeReSeq(Map<String, String> map);

	int insertTinyReReplyNotice(Map<String, String> map);

	String selectTinyReplyWriter(Map<String, String> map);

	int deleteTinyReplyNotice(Map<String, String> map);


	int insertReplyNotice(NoticeVO notice);

	void updateReadcount(NoticeVO notice);

	void updateNoticeReSeq(NoticeVO notice);

	List<Map<String, String>> selectTinyReplyNoticeLIst(int notice_idx);

}
