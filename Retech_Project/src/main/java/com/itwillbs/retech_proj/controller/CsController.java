package com.itwillbs.retech_proj.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.retech_proj.service.CsService;
import com.itwillbs.retech_proj.vo.CsVO;
import com.itwillbs.retech_proj.vo.MemberVO;
import com.itwillbs.retech_proj.vo.PageInfo;


@Controller
public class CsController {
	@Autowired
	private CsService service;
	
	// 1:1 문의 페이지 매핑
	@GetMapping("Cs")
	public String cs(@RequestParam(defaultValue = "1") int pageNum, Model model, MemberVO member, HttpSession session,
			@RequestParam(defaultValue ="") String searchKeyword) {
		// -------------------------------------------------------------------------------------------
		// 페이징 처리
		int listLimit = 5; // 페이지 당 게시물 수
		int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 행 번호
		
		// 검색 기능 추가 (0705)
		int listCount = service.getCsListCount(); // 총 게시물 개수
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
		model.addAttribute("targetURL", "Cs?pageNum=1");
		return "result/fail";
		}
		
		// -------------------------------------------------------------------------------------------
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!");
			model.addAttribute("targetURL", "MemberLogin");
			
			return "result/fail";
		}
		
		Boolean isAdmin ;
		
		if(id.equals("admin@naver.com")) {
			isAdmin = true;
		} else {
			isAdmin = false;
		}
		
		
		
		List<CsVO> csList = service.getCsList(startRow, listLimit, isAdmin, id);
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);

		model.addAttribute("csList", csList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "cs/cs";
	}
	
	
	// 1:1 문의 등록 매핑
	@GetMapping("CsForm")
	public String csRegistform(HttpSession session, Model model, String cs_member_id) {
//		System.out.println(member_id);
		model.addAttribute("cs_member_id", cs_member_id);
		return "cs/CsForm";
	}
	
	// 1:1 문의 작성
	@PostMapping("CsRegistPro")
	public String csRegistPro(CsVO cs, Model model) {
//		System.out.println(cs);
		
		int insertCount = service.registCs(cs);
		
		if(insertCount > 0) {
			model.addAttribute("msg", "성공적으로 처리되었습니다.");
			model.addAttribute("targetURL", "Cs?pageNum=1");
			
			return "result/success";
		} 
		
		return "";
	}
	
	// 1:1 문의 상세보기
	@GetMapping("CsContent")
	public String csContent(int cs_idx, Model model) {
		
		CsVO selectedCs = service.getCs(cs_idx);
		
		model.addAttribute("selectedCs", selectedCs);
		
		return "cs/csContent";
	}

}
