package com.itwillbs.retech_proj.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.retech_proj.mapper.NoticeMapper;
import com.itwillbs.retech_proj.vo.NoticeVO;

@Service
public class NoticeService {
	@Autowired
    private NoticeMapper mapper;

	public int getNoticeListCount(String searchKeyword) {
		return mapper.selectNoticeListCount(searchKeyword);
	}

	public List<NoticeVO> getNoticeList(int startRow, int listLimit, String searchKeyword) {
		return mapper.selectNoticeList(startRow, listLimit, searchKeyword);
	}
	
	public NoticeVO getNotice(int notice_idx) {
		return mapper.selectNotice(notice_idx);
	}

	public NoticeVO getNotice(int notice_idx, boolean isIncreaseReadcount) {
		// 게시물 상세정보 조회를 위해 BoardMapper - selectBoard() 메서드 호출
		// => 결과값을 BoardVO 타입 변수에 저장
		NoticeVO notice = mapper.selectNotice(notice_idx);
		
		// 조회 성공 & 조회수 증가를 수행해야할 경우 
		// BoardMapper - updateReadcount() 메서드 호출하여 해당 게시물의 조회수 증가
		if(notice != null && isIncreaseReadcount) {
//					mapper.updateReadcount(board_num); // 조회수 증가할 게시물의 번호 전달
			
			// 단, 조회수 증가된 게시물 번호를 전달받기 위해 글번호가 저장된 BoardVO 객체 전달
			mapper.updateReadcount(notice);
			// => Mapper 에서 조회수 증가 작업 후 BoardVO 객체에 증가된 조회수 값 저장했을 경우
			//    별도의 리턴 과정이 없어도 동일한 주소값을 갖는 BoardVO 객체를 공유하므로
			//    변경된 조회수 값의 영향을 동일하게 받는다!
			// => 즉, 동일한 객체를 공유하기 때문에 사용하는 값도 동일함(= 변경된 값도 동일)
		}
		
		// 조회 결과 리턴
		return notice;
	}
	@Transactional
	public int registReplyNotice(NoticeVO notice) {
		// 기존 답글들의 순서번호 조정을 위해 updateBoardReSeq() 메서드 호출
				// => 파라미터 : BoardVO 객체   리턴타입 : void
				mapper.updateNoticeReSeq(notice);
				
				// 답글 등록 작업 위해 insertReplyBoard() 메서드 호출
				// => 파라미터 : BoardVO 객체   리턴타입 : int
				return mapper.insertReplyNotice(notice);
	}


	public int registTinyReplyNotice(Map<String, String> map) {
		return mapper.insertTinyReplyNotice(map);
	}


	public int registTinyReReplyNotice(Map<String, String> map) {
		// 기존 댓글들의 순서번호 조정을 위해 updateTinyReplyBoardReSeq() 메서드 호출
				// => 파라미터 : Map 객체   리턴타입 : void
				mapper.updateTinyReplyNoticeReSeq(map);
				// => 댓글 순서가 등록된 순서 오름차순이므로 최신 댓글이 아래쪽으로 위치함
					//    따라서, 기본적으로는 순서 조정이 불필요하지만
				//    대댓글에 대한 또 다시 댓글(n차 댓글) 작성 시 항상 맨 마지막에 위치하는 문제때문에
				//    결국 순서번호 조정이 필요함
				
				// 대댓글 등록 작업 위해 insertTinyReReplyBoard() 메서드 호출
				// => 파라미터 : Map 객체   리턴타입 : int
				return mapper.insertTinyReReplyNotice(map);
			}

	public String getTinyReplyWriter(Map<String, String> map) {
		return mapper.selectTinyReplyWriter(map);
	}

	public int removeTinyReplyNotice(Map<String, String> map) {
		return mapper.deleteTinyReplyNotice(map);
	}

	public List<Map<String, String>> getTinyReplyNoticeList(int notice_idx) {
		return mapper.selectTinyReplyNoticeLIst(notice_idx);
	}

	




}
