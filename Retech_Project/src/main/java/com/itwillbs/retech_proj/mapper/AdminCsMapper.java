package com.itwillbs.retech_proj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.CsVO;
import com.itwillbs.retech_proj.vo.FaqVO;
import com.itwillbs.retech_proj.vo.NoticeVO;

@Mapper
public interface AdminCsMapper {

	// 관리자 - 공지사항 리스트 개수
	int selectNoticeListCount(String searchKeyword);
	
	// 관리자 - 공지사항 리스트
	List<NoticeVO> selectNoticeList(@Param("startRow") int startRow, @Param("listLimit") int listLimit,
									@Param("searchKeyword") String searchKeyword);

	// 관리자 - 공지사항 삭제
	int deleteNotice(int notice_idx);

	// 관리자 - 공지사항 등록
	int insertNotice(NoticeVO notice);

	// 관리자 - 공지사항 수정 (상세내용 가져오기)
	NoticeVO selectNotice(int notice_idx);

	// 관리자 - 공지사항 수정 진행
	int updateNotice(@Param("notice_num") int notice_idx, 
					@Param("notice_subject")String notice_subject, 
					@Param("notice_content")String notice_content);

	// ===============================================================================================================
	// 관리자 - faq 개수 세기
	int selectFaqListCount(String searchKeyword);

	// 관리자 - faq 목록 가져오기
	List<FaqVO> selectFaqList(@Param("startRow") int startRow, @Param("listLimit") int listLimit,
							  @Param("searchKeyword") String searchKeyword);

	// 관리자 - faq 등록
	int insertFaq(FaqVO faq);

	// 관리자 - faq 삭제
	int deleteFaq(int fAQ_idx);

	// 관리자 - faq (상세내용 가져오기)
	FaqVO selectFaq(int fAQ_idx);

	int updateFaq(@Param("faq_idx")int faq_idx, 
				  @Param("faq_category")String faq_category, 
				  @Param("faq_subject")String faq_subject, 
				  @Param("faq_content")String faq_content);

	// ===============================================================================================================
	
	// 관리자 - 1:1 문의 개수 세기
	int selectCsCount(String searchKeyword);

	// 관리자 - 1:1 문의 목록 가져오기
	List<CsVO> selectCsList(@Param("startRow") int startRow, @Param("listLimit") int listLimit,
							  @Param("searchKeyword") String searchKeyword);

	
	// 관리자 - 1:1 문의 상세내용 가져오기
	CsVO selectCs(int cs_idx);

	// 관리자 - 1:1 문의 답변 등록
	int registReply(CsVO cs);

}
