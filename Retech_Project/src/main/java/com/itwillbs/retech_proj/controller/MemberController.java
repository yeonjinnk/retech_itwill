package com.itwillbs.retech_proj.controller;

import java.io.File;
import java.io.IOException;
import java.security.PrivateKey;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.retech_proj.handler.RsaKeyGenerator;
import com.itwillbs.retech_proj.service.CsService;
import com.itwillbs.retech_proj.service.KakaoService;
import com.itwillbs.retech_proj.service.MemberService;
import com.itwillbs.retech_proj.service.ProductService;
import com.itwillbs.retech_proj.vo.CsVO;
import com.itwillbs.retech_proj.vo.KakaoToken;
import com.itwillbs.retech_proj.vo.MemberVO;
import com.itwillbs.retech_proj.vo.ProductVO;


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
	   public String memberDupId(MemberVO member, Model model, String rememberId, BCryptPasswordEncoder passwordEncoder) {
		
//		   String securePasswd = passwordEncoder.encode(member.getMember_passwd());
//		  System.out.println("평문 : " + member.getMember_passwd()); // admin123
//		  System.out.println("암호문 : " + securePasswd); // $2a$10$hw02bLaTVPfeCbZ3vdXU0uWDZu52Ov1rof5pZCFkngtuA5Ld9BSxq
//		  // => 단, 매번 생성되는 암호문은 솔트(Salt)값에 의해 항상 달라진다!
//			
//		  // 3. 암호화 된 패스워드를 다시 MemberVO 객체의 passwd 값에 저장(덮어쓰기)
//		  member.setMember_passwd(securePasswd);
			
			
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
	   public String memberJoinForm(MemberVO member, Model model, BCryptPasswordEncoder passwordEncoder,
	           @RequestParam(value = "profile", required = false) MultipartFile file) {

	       // 전화번호 중복 체크
	       if (service.isExistPhonenumber(member) != null) {
	           model.addAttribute("msg", "이미 등록된 전화번호입니다.");
	           return "result/fail"; // 실패 페이지로 이동
	       }

	       // 파일 처리
	       if (file != null && !file.isEmpty()) {
	           try {
	               // 파일 저장 경로 설정
	               String fileName = file.getOriginalFilename();
	               String uploadDir = "resources/images";  // 저장할 디렉토리 경로
	               File uploadDirFile = new File(uploadDir);
	               if (!uploadDirFile.exists()) {
	                   uploadDirFile.mkdirs();  // 경로가 없으면 디렉토리 생성
	               }

	               String filePath = uploadDir + "/" + fileName;  // 전체 경로 설정
	               File destinationFile = new File(filePath);
	               file.transferTo(destinationFile);  // 파일 저장

	               // MemberVO에 파일 경로 저장
	               member.setMember_profile(fileName);

	           } catch (IOException e) {
	               model.addAttribute("msg", "파일 업로드 실패!");
	               return "result/fail";
	           }
	       } else {
	           // 파일이 없을 경우 기본값 설정
	           member.setMember_profile(member.getMember_profile());
	       }

	       // 비밀번호 암호화 처리
	       String securePasswd = passwordEncoder.encode(member.getMember_passwd());
	       member.setMember_passwd(securePasswd);

	       // 회원 정보 등록
	       int insertCount = service.registMember(member);
	       if (insertCount > 0) {
	           return "redirect:/MemberJoinSuccess";
	       } else {
	           model.addAttribute("msg", "회원가입에 실패하였습니다. 정보를 확인해주세요.");
	           return "result/fail";
	       }
	   }


	   @PostMapping("/SendAuthCode")
	   @ResponseBody
	   public Map<String, String> sendAuthCode(@RequestParam("member_phone") String phone, HttpSession session) {
		   System.out.println("sendAuthCode 진입함@!!!!!!!!!!!!!!!!!!!!");
		   System.out.println("member_phone : " + phone);
	       Map<String, String> response = new HashMap<>();
	       
	       // 인증번호 생성 및 세션 저장
	       String verificationCode = generateVerificationCode();
	       System.out.println();
	       session.setAttribute("verificationCode", verificationCode);
	       session.setAttribute("phoneNumber", phone);

	       // 인증번호 발송
	       boolean isSent = service.sendVerificationCode(phone, verificationCode);

	       if (isSent) {
	           response.put("message", "인증번호가 발송되었습니다.");
	       } else {
	           response.put("message", "인증번호 발송에 실패했습니다.");
	       }
	       
	       return response;
	   }

//	   private String generateVerificationCode() {
//	       return String.valueOf((int) (Math.random() * 900000) + 100000);
//	   }

	   
	   @GetMapping("MemberJoinSuccess")
	   public String memberJoinSuccess() {
	      return "member/member_join_success";
	   }

	   // 로그인 -------------------------------------------------------------------------------------------
	   @GetMapping("MemberLogin")
	   public String memberLogin(HttpSession session, Model model) {
//		   아이디와 패스워드 암호화 과정에서 사용할 공개키/개인키 생성
		   Map<String, Object> rsaKey = RsaKeyGenerator.generateKey();
		   session.setAttribute("RSAPrivateKey", rsaKey.get("RSAPrivateKey"));
		   model.addAttribute("RSAModulus", rsaKey.get("RSAModulus"));
		   model.addAttribute("RSAExponent", rsaKey.get("RSAExponent"));
		   
		   return "member/member_login_form";
	   }

	   @PostMapping("MemberLogin")
	   public String loginPro(MemberVO member, BCryptPasswordEncoder passwordEncoder, Model model,
		        HttpSession session, HttpServletResponse response, String rememberId) throws Exception {
		   	
		   	System.out.println(member);
			System.out.println("아이디 기억 : " + rememberId); // 체크 : "on" , 미체크 : null
//			 =============================== 아이디/패스워드 복호화 ===============================
			System.out.println("암호화 된 아이디 : " + member.getMember_id());
			System.out.println("암호화 된 패스워드 : " + member.getMember_passwd());
			
			// 세션에서 개인키 가져오기
			PrivateKey privateKey = (PrivateKey)session.getAttribute("RSAPrivateKey");
			
			// RsaKeyGenerator 클래스의 decrypt() 메서드 호출하여 전달받은 암호문 복호화
			// => 파라미터 : 세션에 저장된 개인키, 암호문   리턴타입 : String
			String id = RsaKeyGenerator.decrypt(privateKey, member.getMember_id());
			String passwd = RsaKeyGenerator.decrypt(privateKey, member.getMember_passwd());
			System.out.println("복호화 된 아이디 : " + id);
			System.out.println("복호화 된 패스워드 : " + passwd);
			
			// MemberVO 객체에 복호화 된 아이디, 패스워드 저장
			member.setMember_id(id);
			member.setMember_passwd(passwd);	   
		   
		    MemberVO dbMember = service.getMember(member);
		    
		    if (dbMember == null || !passwordEncoder.matches(member.getMember_passwd(), dbMember.getMember_passwd())) {
		        model.addAttribute("msg", "로그인 실패!");
		        return "result/fail";
		    } else if (dbMember.getMember_status().equals("탈퇴")) {
		        model.addAttribute("msg", "탈퇴한 회원입니다!");
		        return "result/fail";
		    } else {
		        // 로그인 성공 시, 세션에 상점명과 관련된 정보 저장
		        session.setAttribute("sId", member.getMember_id());
		        session.setAttribute("sName", dbMember.getMember_name()); // 세션에 회원 이름 저장
		        session.setAttribute("sNickName", dbMember.getMember_nickname()); // 세션에 상점명 저장
		        session.setAttribute("sIsAdmin", dbMember.getMember_isAdmin());
		        session.setMaxInactiveInterval(3600);

		        Cookie cookie = new Cookie("rememberId", member.getMember_id());
		        if (rememberId != null) {
		            cookie.setMaxAge(60 * 60 * 24 * 30); // 30일
		        } else {
		            cookie.setMaxAge(0);
		        }
		        response.addCookie(cookie);

		        if (session.getAttribute("prevURL") == null) {
		            return "redirect:/";
		        } else {
		            return "redirect:" + session.getAttribute("prevURL");
		        }
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
				model.addAttribute("dbMember", dbMember);
				return "member/member_pw_find_pro";
			}
					
		}
				
		// 비밀번호 재설정 요청
		@PostMapping("PwResetPro")
		public String pwResetPro(MemberVO member, Model model, HttpSession session) {
			   System.out.println("비밀번호 재설정 요청");

			// 입력된 전화번호로 DB에서 회원 정보를 조회
			   MemberVO dbMember = service.isExistPhonenumber(member);
			   if (dbMember == null) { // 전화번호가 DB에 존재하지 않음
				   model.addAttribute("msg", "없는 전화번호입니다.");
			 } else {
				 // 전화번호가 존재하면 인증번호 생성 및 발송
				 String phone_number = dbMember.getMember_phone(); // DB에서 가져온 전화번호
//
//				        // 인증번호 생성
//				        String verificationCode = generateVerificationCode();
//				        session.setAttribute("verificationCode", verificationCode);
				        session.setAttribute("phoneNumber", phone_number);
				        session.setAttribute("memberId", dbMember.getMember_id()); // 세션에 memberId 저장
//
//				        // 인증번호 발송
//				        boolean isSent = service.sendVerificationCode(phone_number, verificationCode);
//
//				        // 인증번호 발송 성공/실패 여부와 관계없이 페이지 이동
//				        model.addAttribute("msg", isSent ? "인증번호가 성공적으로 발송되었습니다." : "인증번호 발송에 실패했습니다. 다시 시도해 주세요.");
				    }
//				    
				    // 비밀번호 재설정 페이지로 이동
			 return "member/member_pw_reset";
			}


			private String generateVerificationCode() {
				return String.valueOf((int) (Math.random() * 900000) + 100000);
			}

			    
			    //검증관련
			@PostMapping("/validateAuthCode")
			@ResponseBody
			public Map<String, Boolean> validateAuthCode(@RequestParam("auth_code") String authCode, HttpSession session) {
				String sessionCode = (String) session.getAttribute("verificationCode");
				boolean isValid = authCode.equals(sessionCode);

				Map<String, Boolean> response = new HashMap<>();
				response.put("valid", isValid);
				return response;
			}


			// 비밀번호 재설정
			@PostMapping("PwResetFinal")
			public String pwResetFinal(@RequestParam("member_passwd") String newPasswd, MemberVO member,
			                           HttpSession session, Model model, BCryptPasswordEncoder passwordEncoder) {
			    // 세션에서 전화번호와 회원 ID 가져오기
			    String phoneNumber = (String) session.getAttribute("phoneNumber");
			    String memberId = (String) session.getAttribute("memberId");

			    if (phoneNumber == null || memberId == null) {
			        model.addAttribute("msg", "세션이 만료되었습니다. 비밀번호 재설정을 다시 시도해 주세요.");
			        return "result/fail";
			    }

			    // 전화번호와 회원 ID를 기준으로 회원 정보 조회
			    MemberVO dbMember = service.getMemberByPhoneAndId(phoneNumber, memberId);
			    if (dbMember == null) {
			        model.addAttribute("msg", "회원 정보를 찾을 수 없습니다.");
			        return "result/fail";
			    }

			    // 새 비밀번호 입력 여부를 확인하여 새 비밀번호 입력됐을 경우 암호화 수행
			    if (newPasswd != null && !newPasswd.isEmpty()) {
			        String encodedPasswd = passwordEncoder.encode(newPasswd);
			        dbMember.setMember_passwd(encodedPasswd); // 새 비밀번호 암호화
			    } else {
			        model.addAttribute("msg", "새 비밀번호를 입력해 주세요.");
			        return "result/fail";
			    }

			    // 회원 정보 수정
			    int updateCount = service.modifyPasswd(dbMember);
			    if (updateCount > 0) {
			        model.addAttribute("msg", "패스워드 수정 성공!");
			        model.addAttribute("targetURL", "MemberLogin");
			        session.removeAttribute("verificationCode"); // 인증번호 세션 제거
			        session.removeAttribute("phoneNumber"); // 전화번호 세션 제거
			        session.removeAttribute("memberId"); // 회원 ID 세션 제거
			        return "result/success";
			    } else {
			        model.addAttribute("msg", "패스워드 수정 실패!");
			        return "result/fail";
			    }
			}



				
	   @GetMapping("MyPageMain")
	   public String mypageinfo2(@RequestParam Map<String, String> map, HttpSession session, MemberVO member, BCryptPasswordEncoder passwordEncoder, Model model) {
		   String id = (String) session.getAttribute("sId");
		   // 세션에 사용자 ID가 존재하는 경우
		   if (id != null) {
			   member.setMember_id(id);
			   // 해당 ID의 회원 정보를 조회
			   member = service.getMember(member);
			   model.addAttribute("member", member);
		   }
		   return "mypage/member_mypage";
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
	   public String mypageinfo(
	       @RequestParam Map<String, String> map,
	       @RequestParam(value = "profile", required = false) MultipartFile file, // 파일 파라미터 수정
	       MemberVO member,
	       BCryptPasswordEncoder passwordEncoder,
	       Model model
	   ) {
	       if (member == null || member.getMember_id() == null) {
	           model.addAttribute("msg", "회원 정보를 찾을 수 없습니다.");
	           return "result/fail";
	       }

	       member = service.getMember(member);
	       if (member == null) {
	           model.addAttribute("msg", "회원 정보 조회 실패!");
	           return "result/fail";
	       }

	       String oldPassword = map.get("member_oldpw");
	       if (oldPassword == null || !passwordEncoder.matches(oldPassword, member.getMember_passwd())) {
	           model.addAttribute("msg", "수정 권한이 없습니다!");
	           return "result/fail";
	       }

	       String newPassword = map.get("member_passwd");
	       if (newPassword != null && !newPassword.isEmpty()) {
	           map.put("member_passwd", passwordEncoder.encode(newPassword));
	       } else {
	           map.remove("member_passwd");
	       }

	       
//	        파일 처리
	       if (file != null && !file.isEmpty()) {
	           try {
	               // 파일 저장 경로 설정
	               String fileName = file.getOriginalFilename();
	               String uploadDir = "resources/images";  // 경로 수정
	               File uploadDirFile = new File(uploadDir);
	               if (!uploadDirFile.exists()) {
	                   uploadDirFile.mkdirs();
	               }

	               String filePath = fileName; // 경로 수정
	               File destinationFile = new File(filePath);
	               file.transferTo(destinationFile);

	               // 파일 이름만을 map에 추가
	               map.put("member_profile", fileName);

	           } catch (IOException e) {
	               model.addAttribute("msg", "파일 업로드 실패!");
	               return "result/fail";
	           }
	       } else {
	           // 파일이 없을 경우 기본값 설정
	           map.put("member_profile", member.getMember_profile());
	       }

	       int updateCount = service.modifyMember(map);
	       if (updateCount > 0) {
	           model.addAttribute("msg", "회원정보 수정 성공!");
	           model.addAttribute("targetURL", "SaleHistory"); // 이전 페이지 URL 설정
	           return "result/success";
	       } else {
	           model.addAttribute("msg", "회원정보 수정 실패!");
	           return "result/fail";
	       }
	   }
	   
	   @GetMapping("MemberWithdraw")
	   public String withdrawForm(HttpSession session, Model model) {
	      String id = (String) session.getAttribute("sId");
	      return "member/member_withdraw_form"; 
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
	   
	   @Autowired
	   private ProductService productService;
	   //판매내역
	   @GetMapping("SaleHistory")
	   public String SaleHistory(@RequestParam(value = "startRow", defaultValue = "0") int startRow,
	           @RequestParam(value = "listLimit", defaultValue = "10") int listLimit, 
	           @RequestParam(value = "searchKeyword", defaultValue = "") String searchKeyword,
	           Model model, HttpSession session) {

	       String loggedInUserId = (String) session.getAttribute("sId");
	       
	       if(loggedInUserId == null) { //로그인x
				model.addAttribute("msg", "로그인 필수!"); //alert창
				model.addAttribute("targetURL", "MemberLogin"); //로그인창으로 돌아감
			return "result/fail";
			}
	       
	       
           // 아이디에 해당하는 판매내역 리스트 조회(trade 있을 때)
    	   List<Map<String, String>> saleList = productService.getSaleList(loggedInUserId);
    	   
    	   System.out.println("=====================saleList : " + saleList);
    	   
    	   model.addAttribute("saleList", saleList);
	       
	       // 회원 정보 조회 (필요한 경우)
	       MemberVO member = new MemberVO();
	       member.setMember_id(loggedInUserId);
	       member = service.getMember(member);
	       
	       //-------------리뷰 불러오기----------------------------
	       Float myStarRate = service.getStarRate(loggedInUserId);
	       if(myStarRate != null) {
	    	   member.setMember_starRate(myStarRate);
	       }
	       //---------------------------------------------------
	       model.addAttribute("member", member);
	       model.addAttribute("pageName", "SaleHistory");
	       
	       return "mypage/salehistory";
	   }

	   
	   
	   
	   // 구매내역
	   @GetMapping("PurchaseHistory")
	   public String Purchasehistory(@RequestParam(value = "startRow", defaultValue = "0") int startRow,
	                                  @RequestParam(value = "listLimit", defaultValue = "10") int listLimit,
	                                  @RequestParam(value = "searchKeyword", defaultValue = "") String searchKeyword,
	                                  Model model, HttpSession session) {

	       String id = (String) session.getAttribute("sId");
	       // 세션에 사용자 ID가 존재하는 경우
	       if (id != null) {
	           
	           // 아이디에 해당하는 구매내역 리스트 조회
	    	   List<Map<String, String>> buyList = productService.getBuyList(id);
	    	   
	    	   System.out.println("=====================buyList : " + buyList);
	    	   
	    	   model.addAttribute("buyList", buyList);

	           // 회원 정보 조회 (필요한 경우)
	           MemberVO member = new MemberVO();
	           member.setMember_id(id);
	           member = service.getMember(member);
	           
	         //-------------리뷰 불러오기----------------------------
		       Float myStarRate = service.getStarRate(id);
		       if(myStarRate != null) {
		    	   member.setMember_starRate(myStarRate);
		       }
		       //---------------------------------------------------
	           
	           model.addAttribute("member", member);
	           
	       }

	       return "mypage/purchasehistory";
	   }

	 
	   // 찜목록
	   @GetMapping("Wishlist")
	   public String Wishlist(@RequestParam(value = "startRow", defaultValue = "0") int startRow,
	                          @RequestParam(value = "listLimit", defaultValue = "10") int listLimit,
	                          Model model, HttpSession session, MemberVO member) {
		   System.out.println("WishList 겟메핑 시작!");
	       String id = (String) session.getAttribute("sId");
	       System.out.println("세션아이디로 받은 id : " + id);

	       if (id != null) {
	           member.setMember_id(id);
	           member = service.getMember(member);
	           
	           //-------------리뷰 불러오기----------------------------
		       Float myStarRate = service.getStarRate(id);
		       if(myStarRate != null) {
		    	   member.setMember_starRate(myStarRate);
		       }
		       //---------------------------------------------------
		       
		       
	           
	           
	           model.addAttribute("member", member);
	           System.out.println("모델에 담은 member : " + member);

	           // 찜한 상품 목록 조회
	           List<HashMap<String, String>> likeList = productService.getLikeProduct(id);

	           System.out.println("찜한 상품 목록 조회한 거 잘 나오나 : " + likeList);
	           System.out.println("========================================================");
	           // 찜한 상품 목록을 productLike로 모델에 추가
	           model.addAttribute("productLike", likeList);
	           System.out.println("찜한 상품 뷰페이지로 전달할 모델에 담은 것 : " + likeList);
	           
//	           List<ProductVO> productList = productService.getProductList(startRow, listLimit);
//		       int totalProductCount = productService.getProductListCount();

//		       model.addAttribute("productList", productList);
	       }

	       return "mypage/wishlist";
	   }

	   // 상품 상세정보
	   @GetMapping("/productDetail")
	    public String productDetail(@RequestParam("pd_idx") int pd_Idx, Model model) {
	        // 상품 세부정보를 조회
	        ProductVO product = productService.getProductById(pd_Idx);

	        // 상품 정보가 있는 경우 모델에 추가
	        if (product != null) {
	            model.addAttribute("product", product);
	        } else {
	            model.addAttribute("errorMessage", "상품 정보를 찾을 수 없습니다.");
	        }

	        // 상품 상세 페이지로 이동
	        return "product/product_detail";
	    }
	   
	   // 문의 내역 조회 
	   @Autowired
	   private CsService csService;
	   @GetMapping("CsHistory")
	    public String csHistory(Model model, HttpSession session, MemberVO member) {
	          
		   String id = (String) session.getAttribute("sId");
		   // 세션에 사용자 ID가 존재하는 경우
		   if (id != null) {
			   member.setMember_id(id);
			   // 해당 ID의 회원 정보를 조회
			   member = service.getMember(member);
			   model.addAttribute("member", member);    
	            
			   
			   //-------------리뷰 불러오기----------------------------
		       Float myStarRate = service.getStarRate(id);
		       if(myStarRate != null) {
		    	   member.setMember_starRate(myStarRate);
		       }
		       //---------------------------------------------------
		       
		       
			   
			   
	            // 페이징을 고려한 변수 설정 (예: 현재 페이지, 페이지당 항목 수)
	            int startRow = 0; // 시작 행 (페이지 계산에 따라 동적으로 설정 필요)
	            int listLimit = 10; // 한 페이지에 보여줄 항목 수

	            // 총 문의 수를 가져옴
	            int totalCsCount = csService.getCsListCount(id);
	            model.addAttribute("totalCsCount", totalCsCount);

	            // 문의 리스트 가져오기
	            List<CsVO> csList = csService.getCsList(startRow, listLimit, false, id);
	            model.addAttribute("csList", csList);
	        }
	        return "mypage/mycs";
	    }
	   
	   @GetMapping("/cs/csContent")
	   public String csContent(@RequestParam("cs_idx") int cs_idx, Model model) {
	       CsVO selectedCs = csService.getCs(cs_idx);
	       model.addAttribute("selectedCs", selectedCs);
	       return "cs/csContent"; // cs 폴더 내의 csContent.jsp로 이동
	   }	
	   
	   
	   // 거래상태 업데이트
	   @PostMapping("/updateTradeStatusAjax")
	   @ResponseBody
	   public Map<String, Object> updateTransactionStatus2(@RequestParam("trade_pd_idx") int trade_pd_idx,
	                                                       @RequestParam("trade_status") int trade_status) {
		   System.out.println("업뎃ㅌ으랜잭션 파라미터 넘어오는지 " + trade_pd_idx + ", " + trade_status);
		   
		   Map<String, Object> response = new HashMap<>();
	       int success = productService.updateProductStatus2(trade_pd_idx, trade_status);
	       System.out.println("===================success : " + success);
	       response.put("success", success);
//	       response.put("status", trade_status);
	       return response;
	    }
	   
	   // 상품상태 업데이트
	   @PostMapping("/updateTradeStatusAjax2")
	   @ResponseBody
	   public Map<String, Object> updateTransactionStatus3(@RequestParam("id") int id,
			   @RequestParam("status") String status) {
		   System.out.println("업뎃ㅌ으랜잭션222222 파라미터 넘어오는지 " + id + ", " + status);
		   
		   Map<String, Object> response = new HashMap<>();
		   int success = productService.updateProductStatus3(id, status);
		   System.out.println("===================success : " + success);
		   response.put("success", success);
//	       response.put("status", trade_status);
		   return response;
	   }	   
	   
	   @Autowired
	   private KakaoService kakaoService;
	   // 카카오 서비스
	   @GetMapping("KakaoLoginCallback")
	   public String kakaoLogin(String code, HttpSession session, Model model) {
		   System.out.println(code);
			
//		   Map<String, String> token = kakaoService.requestKakaoAccessToken(code);
		   KakaoToken token = kakaoService.requestKakaoAccessToken(code);
			
		   Map<String, Object> userInfo = kakaoService.requestKakaoUserInfo(token);
			
		   // 아이디(이메일)에 저장된 kakaoAccount 객체 꺼내기
		   Map<String, Object> kakaoAccount = (Map<String, Object>) userInfo.get("kakao_account");

		   MemberVO member = service.getMemberFromEmail((String)kakaoAccount.get("email"));
		   System.out.println(member);
			
			
		   if(member == null) {
			   model.addAttribute("msg", "가입되지 않은 회원입니다!\\n회원가입 페이지로 이동합니다.");
			   model.addAttribute("targetURL", "MemberJoinForm?member_id=" + kakaoAccount.get("email"));
			   return "result/success";
		   } else {
			   // 가입된 회원은 즉시 로그인 처리
			   
			   session.setAttribute("sId", member.getMember_id());
			   session.setMaxInactiveInterval(60 * 60); // 60초 * 60분
			   return "redirect:/";
		   }
			
		   
	}
	   
	   
}
