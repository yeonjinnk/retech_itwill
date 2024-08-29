package com.itwillbs.retech_proj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.retech_proj.service.NoticeService;
import com.itwillbs.retech_proj.vo.NoticeVO;
import com.itwillbs.retech_proj.vo.PageInfo;

@Controller
public class NoticeController {
	@Autowired
	private NoticeService service;
	
	@GetMapping("Notice")
	public String notice(@RequestParam(defaultValue = "1") int pageNum, Model model, 
			@RequestParam(defaultValue ="") String searchKeyword) {
		
		// -------------------------------------------------------------------------------------------
				// 페이징 처리
				int listLimit = 5; // 페이지 당 게시물 수
				int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 행 번호
				
				// 검색 기능 추가 (0705)
				int listCount = service.getNoticeListCount(searchKeyword); // 총 게시물 개수
				//System.out.println(listCount);
				int pageListLimit = 3; // 임시) 페이지 당 페이지 번호 갯수를 3개로 지정(1 2 3 or 4 5 6)
				int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
				int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
				int endPage = startPage + pageListLimit - 1;
				if(endPage > maxPage) {
				endPage = maxPage;
				}
				
				// 최대 페이지번호(maxPage) 값의 기본값을 1로 설정하기 위해 계산 결과가 0 이면 1 로 변경
				if(maxPage == 0) {
				maxPage = 1;
				}
				
				if(endPage > maxPage) {
				endPage = maxPage;
				}
				
				// -------------------------------------------------------------------------------------------
				// 페이지 번호가 1보다 작거나 최대 페이지 번호보다 클 경우
				if(pageNum < 1 || pageNum > maxPage) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "Notice?pageNum=1");
				return "result/fail";
				}
				
				// -------------------------------------------------------------------------------------------
				List<NoticeVO> noticeList = service.getNoticeList(startRow, listLimit, searchKeyword);
				PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);

				model.addAttribute("noticeList", noticeList);
				model.addAttribute("pageInfo", pageInfo);
				return "cs/notice";
	}
}
