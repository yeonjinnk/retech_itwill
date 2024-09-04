package com.itwillbs.retech_proj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.AdminCsMapper;
import com.itwillbs.retech_proj.vo.CsVO;
import com.itwillbs.retech_proj.vo.FaqVO;
import com.itwillbs.retech_proj.vo.NoticeVO;



@Service
public class AdminCsService {
	@Autowired
	private AdminCsMapper mapper;

	// 관리자 - 공지사항 리스트 개수
	public int getNoticeListCount(String searchKeyword) {
		return mapper.selectNoticeListCount(searchKeyword);
	}
	
	// 관리자 - 공지사항 리스트
	public List<NoticeVO> getNoticeList(int startRow, int listLimit, String searchKeyword) {
		return mapper.selectNoticeList(startRow, listLimit, searchKeyword);
	}

	// 관리자 - 공지사항 삭제
	public int removeNotice(int notice_idx) {
		return mapper.deleteNotice(notice_idx);
	}

	// 관리자 - 공지사항 등록
	public int registNotice(NoticeVO notice) {
		return mapper.insertNotice(notice);
	}

	// 관리자 - 공지사항 수정 (상세내용 가져오기)
	public NoticeVO getNotice(int notice_idx) {
		return mapper.selectNotice(notice_idx);
	}

	// 관리자 - 공지사항 수정 진행
	public int adminNoticeModify(int notice_idx, String notice_subject,
			String notice_content) {
		return mapper.updateNotice(notice_idx, notice_subject,notice_content);
	}
	
	// ===================================================================================================

	// 관리자 - faq 개수 세기
	public int getFaqCount(String searchKeyword) {
		return mapper.selectFaqListCount(searchKeyword);
	}

	// 관리자 - faq 목록 가져오기
	public List<FaqVO> getFaqList(int startRow, int listLimit, String searchKeyword) {
		return mapper.selectFaqList(startRow, listLimit, searchKeyword);
	}

	// 관리자 - faq 등록
	public int registFaq(FaqVO faq) {
		return mapper.insertFaq(faq);
	}

	// 관리자 - faq 삭제
	public int removeFaq(int faq_idx) {
		return mapper.deleteFaq(faq_idx);
	}
	
	// 관리자 - faq (상세내용 가져오기)
	public FaqVO getFaq(int faq_idx) {
		return mapper.selectFaq(faq_idx);
	}

	// 관리자 - faq 수정
	public int adminFaqModify(int faq_idx, String faq_category, String faq_subject, String faq_content) {
		return mapper.updateFaq(faq_idx,faq_category,faq_subject,faq_content);
	}
	
	// ===================================================================================================

	// 관리자 - 1:1 문의 개수 세기
	public int getCsCount(String searchKeyword) {
		return mapper.selectCsCount(searchKeyword);
	}

	// 관리자 - 1:1 문의 목록 가져오기
	public List<CsVO> getCsList(int startRow, int listLimit, String searchKeyword) {
		return mapper.selectCsList(startRow, listLimit, searchKeyword);
	}

	// 관리자 - 1:1 문의 상세내용 가져오기
	public CsVO getCs(int cs_idx) {
		return mapper.selectCs(cs_idx);
	}

	// 관리자 - 1:1 문의 답변 등록
	public int registReply(CsVO cs) {
		return mapper.registReply(cs);
	}

}
