package com.itwillbs.retech_proj.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.retech_proj.service.ChatService;
import com.itwillbs.retech_proj.service.MemberService;
import com.itwillbs.retech_proj.service.ProductService;
import com.itwillbs.retech_proj.service.ReviewService;
import com.itwillbs.retech_proj.vo.MemberVO;
import com.itwillbs.retech_proj.vo.ReportChatVO;
import com.itwillbs.retech_proj.vo.TradeVO;

@Controller
public class ReviewController {
	@Autowired ReviewService service;
	@Autowired
	   MemberService memberService;

	//리뷰등록
	@ResponseBody
	@GetMapping("RegistReview")
	public int registReview(@RequestParam Map<String, Object> map) {
		System.out.println("!!!!!!!!리뷰 등록 위해 넘어온 파라미터!!!! : " + map);
		//리뷰등록
		int isInsert = service.insertReview(map);
		//리뷰등록 성공 시, trade 테이블에 해당하는 상품번호의 trade_status 6(리뷰완료)로 변경해야 함..!
		if(isInsert > 0) {
			int isUpdate = service.updateStatus6(map);
			System.out.println("리뷰 남겼으니까 거래상태도 6번으로 바꿈!!!!");
		} else {
			System.out.println("리뷰등록 실패!!! 근데 이게 실행될랑가..");
		}
		return isInsert;
	}
	
	   // 구매내역 - 리뷰
	   //내가 쓴 리뷰 조회
	   @GetMapping("BuyerReview")
	   public String buyerReview(@RequestParam(value = "startRow", defaultValue = "0") int startRow,
	                                  @RequestParam(value = "listLimit", defaultValue = "10") int listLimit,
	                                  @RequestParam(value = "searchKeyword", defaultValue = "") String searchKeyword,
	                                  Model model, HttpSession session) {

	       String id = (String) session.getAttribute("sId");
	       // 세션에 사용자 ID가 존재하는 경우
	       if (id != null) {
	           
	    	   //내가 쓴 리뷰 조회
	    	   List<Map<String, String>> myReview = service.getMyReview(id);
	    	   System.out.println("!!!!!!구매자가 쓴 리뷰 목록입니다요 : " + myReview);
	    	   
	    	   
	    	   model.addAttribute("myReview", myReview);
	           // 회원 정보 조회 (필요한 경우)
	           MemberVO member = new MemberVO();
	           member.setMember_id(id);
	           member = memberService.getMember(member);
	           
	           
	         //-------------리뷰 불러오기----------------------------
		       Float myStarRate = memberService.getStarRate(id);
		       System.out.println("불러온 리뷰 별점 myStarRate : " + myStarRate);
		       if(myStarRate != null) {
		    	   System.out.println("리뷰를 불러옵니다!!!");
		    	   member.setMember_starRate(myStarRate);
		       }
		       //---------------------------------------------------
	           
	           model.addAttribute("member", member);
	       }
	       return "mypage/purchasehistory_review";
	   }

	
	   
	   // 판매내역 - 리뷰
	   //판매자가 받은 리뷰 조회
	   @GetMapping("SellerReview")
	   public String sellerReview(@RequestParam(value = "startRow", defaultValue = "0") int startRow,
			   @RequestParam(value = "listLimit", defaultValue = "10") int listLimit,
			   @RequestParam(value = "searchKeyword", defaultValue = "") String searchKeyword,
			   Model model, HttpSession session) {
		   
		   String id = (String) session.getAttribute("sId");
		   // 세션에 사용자 ID가 존재하는 경우
		   if (id != null) {
			   
			   //내가 쓴 리뷰 조회
			   List<Map<String, String>> sellerReview = service.getSellerReview(id);
			   System.out.println("!!!!!!판매자가 받은 리뷰 목록입니다요 : " + sellerReview);
			   
			   model.addAttribute("sellerReview", sellerReview);
			   // 회원 정보 조회 (필요한 경우)
			   MemberVO member = new MemberVO();
			   member.setMember_id(id);
			   member = memberService.getMember(member);
			   
		       //-------------리뷰 불러오기----------------------------
			     Float myStarRate = memberService.getStarRate(id);
			     System.out.println("불러온 리뷰 별점 myStarRate : " + myStarRate);
			     if(myStarRate != null) {
			      System.out.println("리뷰를 불러옵니다!!!");
			      member.setMember_starRate(myStarRate);
			      }
			     //---------------------------------------------------
			   model.addAttribute("member", member);
		   }
		   return "mypage/salehistory_review";
	   }
	   
	   
	
	
}
