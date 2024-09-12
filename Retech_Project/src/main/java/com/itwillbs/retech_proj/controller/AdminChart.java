package com.itwillbs.retech_proj.controller;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.itwillbs.retech_proj.service.AdminMemberService;
import com.itwillbs.retech_proj.vo.MemberVO;
import com.itwillbs.retech_proj.vo.ProductVO;

@Controller
public class AdminChart {

    @Autowired
    private AdminMemberService service;
    
    

    // 관리자 홈
    @GetMapping("AdminChart")
    public String memberJoin(HttpSession session, Model model) {
        System.out.println("!!!!!!!!!!!!!!! adminchart 호출됨!!!!!!");
        System.out.println("session.getAttribute(\"sIsAdmin\") : " + session.getAttribute("sIsAdmin"));
        if (session.getAttribute("sIsAdmin") == null) {
            model.addAttribute("msg", "관리자만 접속 가능한 페이지입니다.");
            model.addAttribute("targetURL", "./");
            return "result/fail";
        } else {
            List<MemberVO> member = service.getMemberList2();
            
            for(MemberVO m : member) {
            	m.setMember_passwd("");
            }
            System.out.println("리스트로 가져온 member " + member);
            model.addAttribute("member", member);
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
            model.addAttribute("memberData", gson.toJson(member));
            System.out.println("new Gson().toJson(member): " + gson.toJson(member)); // 확인용
            
            List<ProductVO> productList = service.getProductList();
            
            for(ProductVO p : productList) {
            	p.setPd_image1("");
            	p.setPd_image2("");
            	p.setPd_image3("");
            	p.setPd_image4("");
            	p.setPd_image5("");
            	p.setPd_subject("");
            	p.setPd_content("");
            }
            System.out.println("productList 잘오는지" + productList);
            
            model.addAttribute("productData", gson.toJson(productList));
            System.out.println("new Gson().toJson(productList): " + gson.toJson(productList)); // 확인용
            
            
            
            
        }
        return "admin/admin_chart";
    }
    
    @GetMapping("AdminChartTest")
    public String memberJoin22(HttpSession session, Model model) {
            
            List<MemberVO> member = service.getMemberList2();
            model.addAttribute("member", member);
            
        return "success";
    }

	
    
    
   
}
