package com.itwillbs.retech_proj.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.retech_proj.service.NoticeService;
import com.itwillbs.retech_proj.vo.NoticeVO;
import com.itwillbs.retech_proj.vo.PageInfo;

@Controller
public class NoticeController {
	@Autowired
	private NoticeService service;
	
	private String uploadPath = "/resources/upload";
	
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
				return "notice/notice";
	}
	
	// 공지사항 상세보기
		@GetMapping("NoticeDetail") 
		public String noticeDetail(@RequestParam(defaultValue = "0") int notice_idx, Model model) {
//			System.out.println(notice_num);
			NoticeVO notice = service.getNotice(notice_idx, true);
			
			
			if(notice == null) {
				model.addAttribute("msg", "존재하지 않는 게시물입니다");
				return "result/fail";
			}
//			System.out.println(selectedNotice);
			
			model.addAttribute("notice", notice);
			
			List<Map<String, String>> tinyReplyNoticeList = service.getTinyReplyNoticeList(notice_idx);
			System.out.println("tinyReplyNoticeList : " + tinyReplyNoticeList);
			
			// Model 객체에 댓글 목록 저장
			model.addAttribute("tinyReplyBoardList", tinyReplyNoticeList);
			
			return "notice/noticeContent";
		}
		
		// [ 답글 작성 폼 ]
		// => 글 수정 폼과 동일하게 기존 게시물 정보 조회하여 뷰페이지로 전달
		// => BoardReply 서블릿 주소 매핑
		@GetMapping("NoticeReply")
		public String boardReplyForm(
				NoticeVO notice, @RequestParam(defaultValue = "1") String pageNum, 
				HttpSession session, Model model) {
			if(session.getAttribute("sId") == null) {
				model.addAttribute("msg", "로그인 필수!");
				model.addAttribute("targetURL", "MemberLogin");
				// 로그인 후 현재 작업으로 돌아오기 위해 세션에 prevURL 속성값 저장
				session.setAttribute("prevURL", "NoticeReply?notice_idx=" + notice.getNotice_idx() + "&pageNum=" + pageNum);
				return "result/fail";
			}
			
			// BoardService - getBoard() 메서드 재사용하여 게시물 1개 정보 조회
			// => 조회수 증가되지 않도록 두번째 파라미터 false 값 전달
			notice = service.getNotice(notice.getNotice_idx(), false);
			
			// 조회 결과 저장 후 notice/notice_reply_form.jsp 페이지 포워딩
			model.addAttribute("notice", notice);
			
			return "notice/notice_reply_form";
		}
		
		// [ 답글 작성 비즈니스 로직 ]
		@PostMapping("NoticeReply")
		public String noticeReplyPro(
				NoticeVO notice, @RequestParam(defaultValue = "1") String pageNum, 
				HttpSession session, Model model, HttpServletRequest request) {
			// 미로그인 처리
			if(session.getAttribute("sId") == null) {
				model.addAttribute("msg", "로그인 필수!");
				model.addAttribute("targetURL", "MemberLogin");
				// 로그인 후 현재 작업으로 돌아오기 위해 세션에 prevURL 속성값 저장
				session.setAttribute("prevURL", "NoticeReply?notice_idx=" + notice.getNotice_idx() + "&pageNum=" + pageNum);
				return "result/fail";
			}
			// ==================================================================================
			// 작성자 IP 주소 가져와서 BoardVO 객체에 저장
			notice.setNotice_writer_ip(request.getRemoteAddr());
			// ----------------------------------------------------------------------------------
			// [ 답글 등록 과정에서 파일 업로드 처리 ]
			String realPath = session.getServletContext().getRealPath(uploadPath); // 가상의 경로 전달
			String subDir = ""; // 하위 디렉토리명을 저장할 변수 선언
			LocalDate today = LocalDate.now();
			// 형식 변경에 사용할 패턴 문자열 지정
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
			subDir = today.format(dtf); // LocalDate - DateTimeFormatter
			realPath += "/" + subDir;
			try {
				Path path = Paths.get(realPath); // 파라미터로 실제 업로드 경로 전달
				Files.createDirectories(path);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// --------------------------------------------------------------------------------------
			
			// ===============================================================================
			// BoardService - registReplyBoard() 메서드 호출하여 게시물 등록 작업 요청
			// => 파라미터 : BoardVO 객체   리턴타입 : int(insertCount)
			int insertCount = service.registReplyNotice(notice);
			
			// 게시물 등록 작업 요청 결과 판별
			if(insertCount > 0) { // 성공
				
				// 글목록(BoardList) 서블릿 주소 리다이렉트
				return "redirect:/NoticeList?pageNum=" + pageNum;
			} else { // 실패
				// "글쓰기 실패!" 메세지 출력 및 이전 페이지 돌아가기 처리
				model.addAttribute("msg", "답글 등록 실패!");
				return "result/fail";
			}
		}
		
		
		// [ 댓글 작성 비즈니스 로직 ]
		@PostMapping("NoticeTinyReplyWrite")
		public String writeTinyReply(@RequestParam Map<String, String> map, HttpSession session, Model model) {
			System.out.println(map);
			
			String sId = (String)session.getAttribute("sId");
			
			// 미로그인 처리
			if(sId == null) {
				model.addAttribute("msg", "로그인 필수!");
				model.addAttribute("targetURL", "MemberLogin");
				// 로그인 후 현재 작업으로 돌아오기 위해 세션에 prevURL 속성값 저장
				session.setAttribute("prevURL", "NoticeDetail?notice_idx=" + map.get("notice_idx") + "&pageNum=" + map.get("pageNum"));
				return "result/fail";
			}
			
			// Map 객체의 reply_name 키에 세션 아이디 저장
			map.put("reply_name", sId);
			// BoardService - registTinyReplyBoard() 메서드 호출하여 댓글 등록 작업 요청
			// => 파라미터 : Map 객체   리턴타입 : int(insertCount)
			int insertCount = service.registTinyReplyNotice(map);
			System.out.println("입력 됐나요 : " + insertCount);
			// 댓글 등록 요청 처리 결과 판별
			// => 성공 시 글 상세정보 조회 페이지로 리다이렉트(파라미터 : 글번호, 페이지번호)
			// => 실패 시 "댓글 작성 실패!" 메세지 처리 위해 fail.jsp 페이지 포워딩
			if(insertCount > 0) {
				System.out.println("댓글 등록 성공!");
				return "redirect:/NoticeDetail?notice_idx=" + map.get("notice_idx") + "&pageNum=" + map.get("pageNum");
			} else {
				System.out.println("댓글 등록 실패");
				model.addAttribute("msg", "댓글 작성 실패!");
				return "result/fail";
			}
			
		}
		
		// -------------------------------------------------
		// [ 대댓글 등록 비즈니스 로직 ]
		// 응답 데이터를 직접 생성하여 응답할 수 있도록 @ResponseBody 어노테이션 지정
		// => JSON 형식 등의 문자열 데이터를 직접 응답 데이터로 전송하기 위함
		// => 미 지정 시 return 문 뒤에 기술하는 내용은 포워딩 대상으로 간주되어 DispatcherServlet 객체가 처리함
		@ResponseBody
		@PostMapping("NoticeTinyReReplyWrite")
		public String writeTinyReReply(@RequestParam Map<String, String> map, HttpSession session) {
			System.out.println(map);
			
			// JSON 타입으로 리턴 데이터를 생성을 편리하게 수행하기 위해 Map<String, Object> 객체 생성
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			String sId = (String)session.getAttribute("sId");
			if(sId == null) {
				// 리턴데이터를 저장할 Map 객체의 "isInvalidSession" 속성값을 true 로 저장
				resultMap.put("isInvalidSession", true);
			} else {
				// 요청 데이터가 저장된 Map 객체에 세션 아이디 저장
				map.put("reply_name", sId);
				
				// BoardService - registTinyReReplyBoard() 메서드 호출하여 대댓글 등록 요청
				// => 파라미터 : Map 객체   리턴타입 : int(insertCount)
				int insertCount = service.registTinyReReplyNotice(map);
				
				// 등록 요청 처리 결과 판별
				// => 성공 시 resultMap 객체의 "result" 속성값을 true, 실패 시 false 로 저장
				if(insertCount > 0) {
					resultMap.put("result", true);
				} else {
					resultMap.put("result", false);
				}
			}
			
			// 리턴 데이터가 저장된 Map 객체를 JSON 객체 형식으로 변환
			// => org.json.JSONObject 클래스 활용
			JSONObject jo = new JSONObject(resultMap);
			System.out.println("응답 JSON 데이터 " + jo.toString());
			
			// JSON 객체를 문자열로 변환하여 리턴(@ResponseBody 어노테이션 필수!)
			return jo.toString();
		}
		
		
		// [ 대댓글 삭제 비즈니스 로직 ]
		// 응답 데이터를 직접 생성하여 응답할 수 있도록 @ResponseBody 어노테이션 지정
		@ResponseBody
		@PostMapping("NoticeTinyReplyDelete")
		public String deleteTinyReply(@RequestParam Map<String, String> map, HttpSession session) {
			System.out.println(map);
			
			// JSON 타입으로 리턴 데이터를 생성을 편리하게 수행하기 위해 Map<String, Object> 객체 생성
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			String sId = (String)session.getAttribute("sId");
			if(sId == null) {
				// 리턴데이터를 저장할 Map 객체의 "isInvalidSession" 속성값을 true 로 저장
				resultMap.put("isInvalidSession", true);
			} else {
				// BoardService - getTinyReplyWriter() 메서드 호출하여 댓글 작성자 조회
				// => 파라미터 : Map 객체(reply_num 필요)   리턴타입 : String(reply_name)
				String reply_name = service.getTinyReplyWriter(map);
				
				// 댓글 작성자 판별(삭제 권한 판별)
				// => 세션 아이디가 관리자(admin) 이거나
				//    조회된 아이디가 세션 아이디와 동일할 경우에만 댓글 삭제 요청
				if(sId.equals("admin") || reply_name.equals(sId)) {
					// BoardService - removeTinyReplyBoard() 메서드 호출하여 댓글 삭제 요청
					// => 파라미터 : Map 객체   리턴타입 : int(deleteCount)
					int deleteCount = service.removeTinyReplyNotice(map);
					
					// 등록 요청 처리 결과 판별
					// => 성공 시 resultMap 객체의 "result" 속성값을 true, 실패 시 false 로 저장
					if(deleteCount > 0) {
						resultMap.put("result", true);
					} else {
						resultMap.put("result", false);
					}
				}
				
			}
			
			// 리턴 데이터가 저장된 Map 객체를 JSON 객체 형식으로 변환
			// => org.json.JSONObject 클래스 활용
			JSONObject jo = new JSONObject(resultMap);
			System.out.println("응답 JSON 데이터 " + jo.toString());
			
			// JSON 객체를 문자열로 변환하여 리턴(@ResponseBody 어노테이션 필수!)
			return jo.toString();
		}		
}
