package com.itwillbs.retech_proj.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.retech_proj.service.AdminCsService;
import com.itwillbs.retech_proj.vo.CsVO;
import com.itwillbs.retech_proj.vo.FaqVO;
import com.itwillbs.retech_proj.vo.NoticeVO;
import com.itwillbs.retech_proj.vo.PageInfo;


@Controller
public class AdminCsController {
	@Autowired
	private AdminCsService service;
	
	// 관리자 - 공지사항 맵핑
	@GetMapping("AdminNotice")
	public String adminNotice(@RequestParam(defaultValue = "1") int pageNum, Model model, 
			@RequestParam(defaultValue ="") String searchKeyword) {
		// -------------------------------------------------------------------------------------------
		// 페이징 처리
		int listLimit = 5; // 페이지 당 게시물 수
		int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 행 번호
	
		int listCount = service.getNoticeListCount(searchKeyword); // 총 게시물 개수
//				System.out.println(listCount);
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
			model.addAttribute("targetURL", "AdminNotice?pageNum=1");
			return "result/fail";
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		// 관리자 - 공지사항 리스트
		List<NoticeVO> noticeList = service.getNoticeList(startRow, listLimit, searchKeyword);

//		System.out.println(noticeList);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_notice";
	}
	
	// 공지사항 삭제
	@GetMapping("AdminNoticeDelete")
	public String adminNoticeDelete(@RequestParam(defaultValue = "0") int notice_idx, Model model) {
		
		//AdminCsService.java - removeNotice()  ==> delete 구문 사용 예정
		// 파라미터 : review_num   리턴타입 : int
		int deleteCount = service.removeNotice(notice_idx);
		
		if(deleteCount > 0) {
			model.addAttribute("msg", "성공적으로 처리되었습니다.");
			model.addAttribute("targetURL", "AdminNotice?pageNum=1");
			
			return "result/success";
		} else {
			model.addAttribute("msg", "삭제에 실패했습니다.");
			
			return "result/fail";
		}
	}
	
	// 공지사항 등록
	@PostMapping("AdminNoticeRegist")
	public String adminNoticeRegist(NoticeVO notice, Model model, HttpServletRequest request) {
//		System.out.println(notice);
		
		notice.setNotice_writer_ip(request.getRemoteAddr());
		
		int insertCount = service.registNotice(notice);
		
		if(insertCount > 0 ) {
			model.addAttribute("msg", "성공적으로 처리되었습니다.");
			model.addAttribute("targetURL", "AdminNotice?pageNum=1");
			
			return "result/success";
		} else {
			model.addAttribute("msg", "등록에 실패했습니다.");
			
			return "result/fail";
		}
		
	}
	
	// 공지사항 수정
	@GetMapping("AdminNoticeModify")
	public String adminNoticeModify(@RequestParam(defaultValue = "0") int notice_idx, Model model) {
//		System.out.println(notice_num);
		NoticeVO selectedNotice = service.getNotice(notice_idx);
		
//		System.out.println("가져온 notice : " + selectedNotice);
		
		model.addAttribute("selectedNotice", selectedNotice);
		
		return "admin/admin_notice_modify_popup";
	}
	
	// 공지사항 수정 - post
	@PostMapping("AdminNoticeModify")
	public String AdminNoticeModifyPro (Model model, @RequestParam(defaultValue = "0") int notice_idx, 
										@RequestParam(defaultValue = "") String notice_subject, 
										@RequestParam(defaultValue = "") String notice_content) {
		// 공지사항 수정 (update)
		int updateCount = service.adminNoticeModify(notice_idx,notice_subject,notice_content);
		
		if(updateCount > 0) {
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("targetURL", "AdminNotice?pageNum=1");
			
			return "result/success";
		} else {
			model.addAttribute("msg", "수정에 실패했습니다.");
			
			return "result/fail";
		}
	}
	
	// ====================================================================================
	// 자주 묻는 질문 (FAQ)
	@GetMapping("AdminFAQ") // 자주 묻는 질문 - 화면 맵핑
	public String adminFaq(@RequestParam(defaultValue = "1") int pageNum, Model model, 
			@RequestParam(defaultValue ="") String searchKeyword) {
		// -------------------------------------------------------------------------------------------
		// 페이징 처리
		int listLimit = 5; // 페이지 당 게시물 수
		int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 행 번호
	
		int listCount = service.getFaqCount(searchKeyword); // 총 게시물 개수
//				System.out.println(listCount);
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
			model.addAttribute("targetURL", "AdminFAQ?pageNum=1");
			return "result/fail";
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		// 관리자 - 공지사항 리스트
		List<FaqVO> faqList = service.getFaqList(startRow, listLimit, searchKeyword);

		model.addAttribute("faqList", faqList);
		model.addAttribute("pageInfo", pageInfo);
		
		
		return "admin/admin_faq";
	}
	
	//자주 묻는 질문 등록	
	@PostMapping("AdminFaqRegist")
	public String adminFaqRegist(FaqVO faq, Model model) {
		int insertCount = service.registFaq(faq);
		
		if(insertCount > 0 ) {
			model.addAttribute("msg", "성공적으로 처리되었습니다.");
			model.addAttribute("targetURL", "AdminFAQ?pageNum=1");
			
			return "result/success";
		} else {
			model.addAttribute("msg", "등록에 실패했습니다.");
			
			return "result/fail";
		}
		
	}
	
	//자주 묻는 질문 삭제
	@GetMapping("AdminFaqDelete")
	public String adminFaqDelete(@RequestParam(defaultValue = "0") int faq_idx, Model model) {
		
		int deleteCount = service.removeFaq(faq_idx);
		
		if(deleteCount > 0) {
			model.addAttribute("msg", "성공적으로 처리되었습니다.");
			model.addAttribute("targetURL", "AdminFAQ?pageNum=1");
			
			return "result/success";
		} else {
			model.addAttribute("msg", "삭제에 실패했습니다.");
			
			return "result/fail";
		}
	}
	
	// 자주 묻는 질문 수정 - 상세내용 가져오기
	@GetMapping("AdminFaqModify")
	public String adminFaqModify(@RequestParam(defaultValue = "0") int faq_idx, Model model) {
		FaqVO selectedFaq = service.getFaq(faq_idx);
		
		model.addAttribute("selectedFaq", selectedFaq);
		
		return "admin/admin_faq_modify_popup";
	}
	
	// 자주 묻는 질문 수정 - post
	@PostMapping("AdminFaqModify")
	public String adminFaqModifyPro (Model model, @RequestParam(defaultValue = "0") int faq_idx, 
										@RequestParam(defaultValue = "") String faq_category, 
										@RequestParam(defaultValue = "") String faq_subject, 
										@RequestParam(defaultValue = "") String faq_content) {
		// 수정 (update)
		int updateCount = service.adminFaqModify(faq_idx,faq_category,faq_subject,faq_content);
		
		if(updateCount > 0) {
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("targetURL", "AdminFAQ?pageNum=1");
			
			return "result/success";
		} else {
			model.addAttribute("msg", "수정에 실패했습니다.");
			
			return "result/fail";
		}
	}
	
	// ====================================================================================
	
	// 1:1 문의
	@GetMapping("AdminCs")
	public String adminCs(@RequestParam(defaultValue = "1") int pageNum, Model model, 
			@RequestParam(defaultValue ="") String searchKeyword) {
		// -------------------------------------------------------------------------------------------
		// 페이징 처리
		int listLimit = 5; // 페이지 당 게시물 수
		int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 행 번호
	
		int listCount = service.getCsCount(searchKeyword); // 총 게시물 개수
//				System.out.println(listCount);
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
			model.addAttribute("targetURL", "AdminCs?pageNum=1");
			return "result/fail";
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		// 관리자 - 공지사항 리스트
		List<CsVO> CsList = service.getCsList(startRow, listLimit, searchKeyword);

		model.addAttribute("CsList", CsList);
		model.addAttribute("pageInfo", pageInfo);
		
		
		return "admin/admin_Cs";
	}
	
	// 1:1 문의 답변 등록 - 상세내용 가져오기
	@GetMapping("CsReplyRegist")
	public String adminCsRegist(@RequestParam(defaultValue = "0") int cs_idx, Model model) {
		CsVO selectedCs = service.getCs(cs_idx);
		
		model.addAttribute("selectedCs", selectedCs);
		
		return "admin/admin_Cs_write_reply_popup";
	}
	
	@PostMapping("CsReplyRegist")
	public String adminCsReply(CsVO cs, Model model) {
		// 답변 등록인데 update 임
		
		int updateCount = service.registReply(cs);
		
		if(updateCount > 0) {
			model.addAttribute("msg", "등록되었습니다.");
			model.addAttribute("targetURL", "AdminCs?pageNum=1");
			
			return "result/success";
		} else {
			model.addAttribute("msg", "수정에 실패했습니다.");
			
			return "result/fail";
		}
	}
	
	@GetMapping("CsReplyView")
	public String adminCsView(@RequestParam(defaultValue = "0") int cs_idx, Model model) {
		System.out.println(cs_idx);
		CsVO selectedCs = service.getCs(cs_idx);
		
		System.out.println(selectedCs);
		
		model.addAttribute("selectedCs", selectedCs);
		
		return "admin/admin_Cs_view_reply_popup";
	}
}









