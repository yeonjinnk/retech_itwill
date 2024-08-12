package com.itwillbs.retech_proj.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.retech_proj.service.MemberService;
import com.itwillbs.retech_proj.vo.MemberVO;


@Controller
public class MemberController {
	@Autowired
	   private MemberService service;

	   // 회원 가입 -------------------------------------------------------------------------------------------
	   @GetMapping("MemberJoin")
	   public String memberJoin() {
		   
	      return "member/member_join";
	   }

	   @PostMapping("MemberJoin")
	   public String memberDupId(MemberVO member, Model model) {
		  MemberVO dbmember = service.getMember(member);
			  
		  System.out.println("찾은 id : " + dbmember);
		  String member_id = member.getMember_id();
		  
		  if(dbmember != null) {
			  model.addAttribute("msg", "중복되는 아이디입니다");
			  
			  return "result/fail";
		  } else {
			  return "redirect:/MemberJoinForm?member_id=" + member_id;
		  }
	   }
	   
	   @GetMapping("MemberJoinForm")
	   public String memberJoinForm(@RequestParam(defaultValue = "") String member_id) {
//		  System.out.println("넘어온 member_id 확인 : " + member_id);
	      return "member/member_join_form";
	   }

	   @PostMapping("MemberJoinForm")
	   public String memberJoinForm(MemberVO member, Model model, BCryptPasswordEncoder passwordEncoder) {
	      System.out.println(member);
	      String securePasswd = passwordEncoder.encode(member.getMember_passwd());
	      member.setMember_passwd(securePasswd);
	      int insertCount = service.registMember(member);
	      if (insertCount > 0) {
	         return "redirect:/MemberJoinSuccess";
	      } else {
	         model.addAttribute("msg", "회원가입에 실패하였습니다. 정보를 확인해주세요.");
	         return "result/fail";
	      }
	   }

	   @GetMapping("MemberJoinSuccess")
	   public String memberJoinSuccess() {
	      return "member/member_join_success";
	   }

	   // 로그인 -------------------------------------------------------------------------------------------
	   @GetMapping("MemberLogin")
	   public String memberLogin() {
	      return "member/member_login_form";
	   }

	   @PostMapping("MemberLogin")
	   public String loginPro(MemberVO member, BCryptPasswordEncoder passwordEncoder, Model model,
			   HttpSession session, HttpServletResponse response, String rememberId) {
	     

		  MemberVO dbMember = service.getMember(member);
	      
	      System.out.println("dbMember : " + dbMember);
	      
	      if(dbMember == null || !passwordEncoder.matches(member.getMember_passwd(), dbMember.getMember_passwd())) {
				model.addAttribute("msg", "로그인 실패!");
				return "result/fail";
			} else if(dbMember.getMember_status().equals("탈퇴")) { // 로그인 성공(이지만 탈퇴 회원인 경우)
				model.addAttribute("msg", "탈퇴한 회원입니다!");
				return "result/fail";
			} else { // 로그인 성공
				// 로그인 성공한 아이디를 세션에 저장
				session.setAttribute("sId", member.getMember_id());
				session.setAttribute("sName", dbMember.getMember_name());
				session.setAttribute("sIsAdmin", dbMember.getMember_isAdmin());
				session.setMaxInactiveInterval(3600);

			
				Cookie cookie = new Cookie("rememberId", member.getMember_id());
				
				// 2. 파라미터로 전달받은 rememberId 변수값 체크
				if(rememberId != null) {
					// 2-1. 아이디 기억하기 체크 시 : 쿠키 유효기간 30일로 설정
					cookie.setMaxAge(60 * 60 * 24 * 30); // 30일(60초 * 60분 * 24시간 * 30일)
				} else { 
					// 2-2. 아이디 기억하기 미체크 시 : 쿠키 삭제 위해 유효기간을 0 으로 설정
					cookie.setMaxAge(0);
				}
				
				response.addCookie(cookie);
				if(session.getAttribute("prevURL") == null) {
					return "redirect:/";
				} else {
					// 요청 서블릿 주소 앞에 "/" 기호가 이미 붙어있으므로 "redirect:" 문자열과 결합
					return "redirect:" + session.getAttribute("prevURL");
				}
				// -----------------------------------------------------------------------------------------
				
			}
			
		}
	   
	   
	   // 로그아웃 -------------------------------------------------------------------------------------------
	   @GetMapping("MemberLogout")
	   public String logout(HttpSession session) {
	      session.invalidate();
	      return "redirect:/";
	   }

	   // 아이디, 비밀번호 찾기 -------------------------------------------------------------------------------
	   // 아이디 찾기
		@GetMapping("MemberSearchId")
		public String searchId() {
			
			return "member/member_search_id";
		}
		
		@PostMapping("SearchIdPro")
		public String searchIdPro(MemberVO member, Model model) {
//			System.out.println(member);
			MemberVO dbMember = service.getMemberSearchId(member); // DB에 저장된 회원정보 가져오기
//		    System.out.println("dbMember : " + dbMember);
			
			if(dbMember == null || dbMember.getMember_status().equals("탈퇴")) { // 회원정보 없을 때 or 탈퇴한 회원일 때
				model.addAttribute("msg", "조회결과가 없습니다.");
				
		        return "result/fail";
			}
			
			if (!member.getMember_name().equals(dbMember.getMember_name()) || 
					!member.getMember_birth().equals(dbMember.getMember_birth()) ||
					!member.getMember_phone().equals(dbMember.getMember_phone())) { // 정보가 하나라도 맞지 않으면 찾을 수 없어야함
				
				model.addAttribute("msg", "회원을 찾을 수 없습니다. 입력하신 정보를 확인해주세요.");
				
		        return "result/fail";
		        
			} else if(member.getMember_name().equals(dbMember.getMember_name()) && 
				member.getMember_birth().equals(dbMember.getMember_birth()) &&
				member.getMember_phone().equals(dbMember.getMember_phone())) { // 회원이 입력한 정보와 DB에 저장된 정보가 같을 때 ! 성공 !
				
				String member_id = dbMember.getMember_id();
				
				return "redirect:/SearchIdSuccess?member_id=" + member_id;
			}
			
			return "";  
		}
		
		@GetMapping("SearchIdSuccess")
		public String searchIdSuccess(String member_id, Model model) {
			System.out.println(member_id);
			
			model.addAttribute("member_id", member_id);
			
			return "member/member_search_id_success";
		}
		
		// 비밀번호 찾기 페이지
				@GetMapping("Passwd_find") 
				public String passwd_find() {
					return "member/member_pw_find";
				}
				
				// 비밀번호 찾기2 페이지
				@PostMapping("PwFindPro")
				public String pw_find_pro(MemberVO member, Model model) {
					
					MemberVO dbMember = service.isExistId(member);
					
					if(dbMember == null) { 
						model.addAttribute("msg", "없는 아이디입니다");
						return "result/fail";

					} else {
//						model.addAttribute("mem_id", mem_id); // model에 아이디값 저장
						model.addAttribute("dbMember", dbMember); // model에 아이디값 저장
						return "member/member_pw_find_pro";
					}
					
				}
			
				// 전화번호로 비밀번호 찾기
				@PostMapping("PwResetPro")
				public String pwResetPro(MemberVO member, Model model) {
					MemberVO dbMember = service.isExistPhonenumber(member);
			
					if(dbMember == null) { // !member.getMem_tel().equals(mem_tel)
						model.addAttribute("msg", "없는 전화번호입니다");
						return "result/fail";
						
					} else {
						model.addAttribute("dbMember", dbMember); // model에 전화번호값 저장
						return "member/member_pw_reset";
					}
					
				}
				// 비밀번호 재설정
				@PostMapping("PwResetFinal")
				public String pwResetFinal(@RequestParam Map<String, String> map, MemberVO member,
				                           BCryptPasswordEncoder passwordEncoder, Model model) {
				    // member 정보가 null이 아닌지 확인하여 NullPointerException 방지  
				    if (member != null) {
				        member = service.getMember(member); // 기존 member 정보 조회
				    } else {
				        model.addAttribute("msg", "회원 정보를 찾을 수 없습니다.");
				        return "result/fail";
				    }

				    // 새 비밀번호 입력 여부를 확인하여 새 비밀번호 입력됐을 경우 암호화 수행 필요
				    String newPasswd = map.get("member_passwd");
				    if (newPasswd != null && !newPasswd.isEmpty()) {
				        map.put("member_passwd", passwordEncoder.encode(newPasswd)); // 새 비밀번호 암호화
				        System.out.println("map : " + map); // passwd 항목 암호화 결과 확인
				    }

				    // 회원 정보 수정
				    int updateCount = service.modifyMember(map);

				    if (updateCount > 0) {
				        model.addAttribute("msg", "패스워드 수정 성공!");
				        model.addAttribute("targetURL", "MemberLogin");
				        return "result/success";
				    } else {
				        model.addAttribute("msg", "패스워드 수정 실패!");
				        return "result/fail";
				    }
				}
		

	   @PostMapping("MyPageMain")
	   public String mypageinfo2(@RequestParam Map<String, String> map, MemberVO member, BCryptPasswordEncoder passwordEncoder, Model model) {
		     
		   return "member/member_mypage";
	   }


	   
	   @GetMapping("MemberInfo")
	   public String memberInfo(MemberVO member, HttpSession session, Model model) {
	      String id = (String)session.getAttribute("sId");
	      if (id == null) {
	         model.addAttribute("msg", "로그인 필수!");
	         model.addAttribute("targetURL", "MemberLogin");
	         return "result/fail";
	      } else {
	         member.setMember_id(id);
	         member = service.getMember(member);
	         model.addAttribute("member", member);
	         return "member/member_info";
	      }
	   }
	   
	   @GetMapping("MemberInfo2")
	   public String memberInfo2(MemberVO member, Model model) {
		   
		   member = service.getMember(member);
		   
		   model.addAttribute("member", member);
		   
		   return "member/member_info";
	   }

	   @PostMapping("MemberModify")
	   public String mypageinfo(@RequestParam Map<String, String> map, MemberVO member, BCryptPasswordEncoder passwordEncoder, Model model) {
		   System.out.println(member);
		   System.out.println(map);
	      member =service.getMember(member);
	      if (!passwordEncoder.matches((CharSequence)map.get("member_oldpw"), member.getMember_passwd())) {
	         model.addAttribute("msg", "수정 권한이 없습니다!");
	         return "result/fail";
	      } else {
	         if (!((String)map.get("member_passwd")).equals("")) {
	            map.put("member_passwd", passwordEncoder.encode((CharSequence)map.get("member_passwd")));
	         }

	         int updateCount = service.modifyMember(map);
	         if (updateCount > 0) {
	            model.addAttribute("msg", "회원정보 수정 성공!");
	            model.addAttribute("targetURL", "MemberInfo");
	            return "result/success";
	         } else {
	            model.addAttribute("msg", "회원정보 수정 실패!");
	            return "result/fail";
	         }
	      }
	   }

	   @GetMapping("MemberWithdraw")
	   public String withdrawForm(HttpSession session, Model model) {
	      String id = (String)session.getAttribute("sId");
	      if (id == null) {
	         model.addAttribute("msg", "로그인 필수!");
	         model.addAttribute("targetURL", "MemberLogin");
	         return "result/fail";
	      } else {
	         return "member/member_withdraw_form";
	      }
	   }

	   @PostMapping("MemberWithdraw")
	   public String withdrawPro(MemberVO member, HttpSession session, Model model, BCryptPasswordEncoder passwordEncoder) {
	      String id = (String)session.getAttribute("sId");
	      if (id == null) {
	         model.addAttribute("msg", "로그인 필수!");
	         model.addAttribute("targetURL", "MemberLogin");
	         return "result/fail";
	      } else {
	         member.setMember_id(id);
	         MemberVO dbMember = service.getMember(member);
	         if (!passwordEncoder.matches(member.getMember_passwd(), dbMember.getMember_passwd())) {
	            model.addAttribute("msg", "수정 권한이 없습니다!");
	            return "result/fail";
	         } else {
	            this.service.withdrawMember(member);
	            session.invalidate();
	            model.addAttribute("msg", "회원 탈퇴 완료!");
	            model.addAttribute("targetURL", "./");
	            return "result/success";
	         }
	      }
	   }
}
