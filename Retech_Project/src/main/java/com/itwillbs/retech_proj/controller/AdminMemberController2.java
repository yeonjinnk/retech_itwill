package com.itwillbs.retech_proj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.retech_proj.service.AdminMemberService;
import com.itwillbs.retech_proj.vo.MemberVO;
import com.itwillbs.retech_proj.vo.PageInfo;

@Controller
public class AdminMemberController2 {

   @Autowired
   private AdminMemberService service;

   // 관리자 - 회원관리 - 회원목록
   @GetMapping("AdminMemberList2")
   public String memberList2(
         @RequestParam(defaultValue = "1") int pageNum, 
         Model model,
         @RequestParam(defaultValue = "") String searchKeyword,
         @RequestParam(defaultValue = "5") int listLimit) {

      // 페이지 시작 행 계산
      int startRow = (pageNum - 1) * listLimit;

      // 총 게시물 개수
      int listCount = service.getMemberListCount(searchKeyword);

      // 페이지 계산
      int pageListLimit = 3; // 한 페이지에 표시할 페이지 번호 갯수
      int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
      int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
      int endPage = startPage + pageListLimit - 1;
      if (endPage > maxPage) {
         endPage = maxPage;
      }
      if (maxPage == 0) {
         maxPage = 1;
      }

      // 페이지가 범위를 벗어날 경우
      if (pageNum < 1 || pageNum > maxPage) {
         model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
         model.addAttribute("targetURL", "AdminMemberList2?pageNum=1");
         return "result/fail";
      }

      // 회원 목록 조회
      List<MemberVO> memberList = service.getMemberList(startRow, listLimit, searchKeyword);

      // 페이지 정보 객체 생성 및 Model에 추가
      PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
      model.addAttribute("memberList", memberList);
      model.addAttribute("pageInfo", pageInfo);

      return "admin/admin_member_list2";
   }
   
	   @Autowired
	   private AdminMemberService memberservice;
	   
	   @GetMapping("AdminMemberDetail")
	   public String memberDetail(@RequestParam("memberId") String memberId, Model model) {
	       MemberVO member = memberservice.getMemberById(memberId); // 서비스에서 memberId로 회원 정보 조회
	       model.addAttribute("member", member);
	       return "admin/admin_member_detail"; 
	   }

}
