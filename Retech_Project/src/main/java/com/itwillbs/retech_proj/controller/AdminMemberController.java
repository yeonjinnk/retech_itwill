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
public class AdminMemberController {
   @Autowired
   private AdminMemberService service;
   // 관리자 - 회원관리 - 회원목록
   @GetMapping("AdminMemberList")
   public String memberList(@RequestParam(defaultValue = "1") int pageNum, Model model,
                  @RequestParam(defaultValue ="") String searchKeyword,
                  @RequestParam(defaultValue = "5") int listLimit) {
      // -------------------------------------------------------------------------------------------
      // 페이징 처리
//      int listLimit = 5; // 페이지 당 게시물 수
      int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 행 번호
      // 검색 기능 추가 (0705)
      int listCount = service.getMemberListCount(searchKeyword); // 총 게시물 개수
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
         model.addAttribute("targetURL", "AdminMemberList?pageNum=1");
         return "result/fail";
      }
      // -------------------------------------------------------------------------------------------
      // 검색 기능 추가 (0705)
      // 검색어는 기본적으로 "" 널스트링
      // 회원 목록 조회
      List<MemberVO> memberList = service.getMemberList(startRow, listLimit, searchKeyword);
//      System.out.println(memberList);
      PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
      // 회원 목록, 페이징 정보 Model 객체에 저장 -> admin_member_list.jsp 로 전달
      model.addAttribute("memberList", memberList);
      model.addAttribute("pageInfo", pageInfo);
//      System.out.println(pageInfo);
      // -------------------------------------------------------------------------------------------
      return "admin/admin_member_list";
   }
   // =================================================================================================
   // 관리자 권한 부여 여부
//   @GetMapping("ChangeAdminAuthorize")
//   public String changeAuthorize(@RequestParam(defaultValue = "N") String member_isAdmin, String member_id, String isAuthorize, Model model) {
//      // -------------------------------------------------------------------------------------------
//      // 관리자 권한 해제 (파라미터로 member_isAdmin, member_id 받은 상황 !)
//      // 관리자 권한 부여면 member_isAdmin : Y
//      // 관리자 권한 해제면 member_isAdmin : N
//      int adminRegCount = service.changeAdminAuth(member_isAdmin, member_id);
//      if(adminRegCount > 0) {
//         model.addAttribute("msg", "성공적으로 처리되었습니다.");
//         model.addAttribute("targetURL", "AdminMemberList");
//         return "result/success";
//      }  else {
//         model.addAttribute("msg", "권한 변경에 실패했습니다.");
////         model.addAttribute("targetURL", "AdminMemberList?pageNum=1");
//         return "result/fail";
//      }
//   }
//   
   // 관리자 권한 부여
   @GetMapping("ChangeAdminAuthorize")
   public String changeAuthorize(@RequestParam String member_isAdmin, @RequestParam String member_id, Model model) {
       // member_isAdmin 값이 'Y' 또는 'N'인지 확인
       if (!member_isAdmin.equals("Y") && !member_isAdmin.equals("N")) {
           model.addAttribute("msg", "잘못된 요청입니다.");
           model.addAttribute("targetURL", "AdminMemberList?pageNum=1");
           return "result/fail";
       }
       
       int adminRegCount = service.changeAdminAuth(member_isAdmin, member_id);

       if (adminRegCount > 0) {
           model.addAttribute("msg", "성공적으로 처리되었습니다.");
           model.addAttribute("targetURL", "AdminMemberList");
           return "result/success";
       } else {
           model.addAttribute("msg", "권한 변경에 실패했습니다.");
           model.addAttribute("targetURL", "AdminMemberList?pageNum=1");
           return "result/fail";
       }
   }



   
}