package com.itwillbs.retech_proj.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.retech_proj.service.AdminReviewService;
import com.itwillbs.retech_proj.service.AdminStoreService;
import com.itwillbs.retech_proj.vo.PageInfo;
import com.itwillbs.retech_proj.vo.ReviewVO;
import com.itwillbs.retech_proj.vo.TradeVO;

@Controller
public class AdminStoreController {
	
	@Autowired
	private AdminReviewService adminreviewservice;
	
	@Autowired AdminStoreService adminStoreService;
	
	//스토어 상품 관리
	@GetMapping("AdminStore")
	public String adminStore(Model model, @RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue ="") String searchKeyword) {
		
		 // 페이징 처리
	      int listLimit = 5; // 페이지 당 게시물 수
	      int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 행 번호
	      // 검색 기능 추가 (0705)
	      int listCount = adminreviewservice.getReviewListCount(searchKeyword); // 총 게시물 개수
//	      System.out.println(listCount);
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
	         model.addAttribute("targetURL", "AdminStore?pageNum=1");
	         return "result/fail";
	      }
		
		//스토어 목록 들고오기
		List<Map<String, Object>> storeList = adminStoreService.getStore(startRow, listLimit, searchKeyword);
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("storeList", storeList);
		model.addAttribute("pageInfo", pageInfo);
		return "admin/admin_store";
	}
	
	//스토어 구매내역 관리
	@GetMapping("AdminBuyStore")
	public String AdminBuyStore() {
		return "admin/admin_store";
	}
	
	//채팅 신고 관리
	@GetMapping("AdminChatReport")
	public String adminChatReport() {
		return "admin/admin_store";
	}
	
	//채팅 관리
	@GetMapping("AdminChat")
	public String adminChat() {
		return "admin/admin_store";
	}
	
	//리뷰 관리
	@GetMapping("AdminReview")
	public String AdminReview(@RequestParam(defaultValue = "1") int pageNum, Model model,
            @RequestParam(defaultValue ="") String searchKeyword) {
		
	     // 페이징 처리
      int listLimit = 5; // 페이지 당 게시물 수
      int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 행 번호
      // 검색 기능 추가 (0705)
      int listCount = adminreviewservice.getReviewListCount(searchKeyword); // 총 게시물 개수
//      System.out.println(listCount);
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
         model.addAttribute("targetURL", "AdminReview?pageNum=1");
         return "result/fail";
      }
      // -------------------------------------------------------------------------------------------
      // 검색 기능 추가 (0705)
      // 검색어는 기본적으로 "" 널스트링
      // 회원 목록 조회
      List<ReviewVO> reviewList = adminreviewservice.getReviewList(startRow, listLimit, searchKeyword);
//      System.out.println(memberList);
      PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
      // 회원 목록, 페이징 정보 Model 객체에 저장 -> admin_member_list.jsp 로 전달
      model.addAttribute("reviewList", reviewList);
      model.addAttribute("pageInfo", pageInfo);
//      System.out.println(pageInfo);
      // -------------------------------------------------------------------------------------------		
		return "admin/admin_review";
	}
	// 리뷰 삭제
	@GetMapping("AdminReviewDelete")
	public String adminNoticeDelete(@RequestParam(defaultValue = "0") int review_idx, Model model) {
		
		//AdminCsService.java - removeNotice()  ==> delete 구문 사용 예정
		// 파라미터 : review_num   리턴타입 : int
		int deleteCount = adminreviewservice.removeReview(review_idx);
		
		if(deleteCount > 0) {
			model.addAttribute("msg", "성공적으로 처리되었습니다.");
			model.addAttribute("targetURL", "AdminReview?pageNum=1");
			
			return "result/success";
		} else {
			model.addAttribute("msg", "삭제에 실패했습니다.");
			
			return "result/fail";
		}
	}
	// 거래관리
	@GetMapping("AdminTrade")
	public String AdminTrade(@RequestParam(defaultValue = "1") int pageNum, Model model,
            @RequestParam(defaultValue ="") String searchKeyword) {

	     // 페이징 처리
      int listLimit = 5; // 페이지 당 게시물 수
      int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 행 번호
      // 검색 기능 추가 (0705)
      int listCount = adminreviewservice.getTradeListCount(searchKeyword); // 총 게시물 개수
//      System.out.println(listCount);
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
         model.addAttribute("targetURL", "AdminTrade?pageNum=1");
         return "result/fail";
      }
      PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
      // -------------------------------------------------------------------------------------------
      // 검색 기능 추가 (0705)
      // 검색어는 기본적으로 "" 널스트링
      // 회원 목록 조회
      List<TradeVO> TradeList = adminreviewservice.getTradeList(startRow, listLimit, searchKeyword);
      System.out.println("TradeList ddddddddd" +TradeList);
      
      // 회원 목록, 페이징 정보 Model 객체에 저장 -> admin_member_list.jsp 로 전달
      model.addAttribute("TradeList", TradeList);
      model.addAttribute("pageInfo", pageInfo);
//      System.out.println(pageInfo);
      // -------------------------------------------------------------------------------------------		
		return "admin/admin_trade";
	}
	// 리뷰 삭제
		@GetMapping("adminTradeDelete")
		public String adminTradeDelete(@RequestParam(defaultValue = "0") int trade_idx, Model model) {
			
			//AdminCsService.java - removeNotice()  ==> delete 구문 사용 예정
			// 파라미터 : review_num   리턴타입 : int
			int deleteCount = adminreviewservice.removeTrade(trade_idx);
			
			if(deleteCount > 0) {
				model.addAttribute("msg", "성공적으로 처리되었습니다.");
				model.addAttribute("targetURL", "AdminTrade?pageNum=1");
				
				return "result/success";
			} else {
				model.addAttribute("msg", "삭제에 실패했습니다.");
				
				return "result/fail";
			}
		}
	
	
	
}
