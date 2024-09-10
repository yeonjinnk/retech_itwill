package com.itwillbs.retech_proj.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.retech_proj.service.CsService;
import com.itwillbs.retech_proj.vo.CsVO;
import com.itwillbs.retech_proj.vo.MemberVO;
import com.itwillbs.retech_proj.vo.PageInfo;


@Controller
public class CsController {
	@Autowired
	private CsService service;
	
	private String uploadPath = "/resources/upload"; 
	
	// 1:1 문의 페이지 매핑
	@GetMapping("Cs")
	public String cs(@RequestParam(defaultValue = "1") int pageNum, Model model, MemberVO member, HttpSession session,
			@RequestParam(defaultValue ="") String searchKeyword) {
		// -------------------------------------------------------------------------------------------
		// 페이징 처리
		String id = (String)session.getAttribute("sId");
		
		int listLimit = 5; // 페이지 당 게시물 수
		int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 행 번호
		
		// 검색 기능 추가 (0705)
		int listCount = service.getCsListCount(id); // 총 게시물 개수
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
		System.out.println("csListddddd" + csList);
		model.addAttribute("csList", csList);
		model.addAttribute("pageInfo", pageInfo);
		System.out.println("pageInfo " + pageInfo);
		
		return "cs/cs";
	}
	
	
	// 1:1 문의 등록 매핑
	@GetMapping("CsForm")
	public String csRegistform(HttpSession session, Model model, String cs_member_id) {
//		System.out.println(member_id);
		model.addAttribute("cs_member_id", cs_member_id);
		return "cs/csForm";
	}
	
	// 1:1 문의 작성
	@PostMapping("CsRegistPro")
	public String csRegistPro(CsVO cs,  HttpServletRequest request, HttpSession session, Model model) {
//		board.setBoard_writer_ip(request.getRemoteAddr());
		// ----------------------------------------------------------------------------------
		// [ 파일 업로드 처리 ]
		// 실제 파일 업로드 수행하기 위해 프로젝트 상의 가상의 업로드 경로 생성 필요(upload)
		// => 외부에서 업로드 파일에 접근 가능하도록 resources 디렉토리 내에 생성
		// => 단, 실제 파일이 업로드 되는 위치는 별도의 경로에 생성됨(동일한 이름으로 생성됨)
//		String uploadPath = "/resources/upload"; // 가상의 경로명 저장(이클립스 프로젝트 상의 경로)
		
		// 가상 디렉토리에 대한 서버상의 실제 경로(톰캣이 관리하는 실제 경로) 알아내기
		// => 이클립스 프로젝트 상에서 업로드 폴더 생성 후 실제 업로드 수행 시
		//    이클립스에 연결된 톰캣이 관리하는 폴더 내에 업로드 폴더가 생성되기 때문
		// => request 객체 또는 session 객체의 getServletContext().getRealPath() 메서드 활용
//		String realPath = request.getServletContext().getRealPath(uploadPath); // 가상의 경로 전달
//		System.out.println("실제 업로드 경로(request) : " + realPath);
		// 실제 업로드 경로(request) : D:\Shared\BACKEND\Spring\workspace_spring5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring_MVC_Board\resources\ upload
		String realPath = session.getServletContext().getRealPath(uploadPath); // 가상의 경로 전달
//		System.out.println("실제 업로드 경로(session) : " + realPath);
		// 실제 업로드 경로(session) : D:\Shared\BACKEND\Spring\workspace_spring5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring_MVC_Board\resources\ upload
		// ------------------------------------------------------------------------
		// [ 경로 관리 ]
		// 업로드 파일에 대한 관리의 용이성 증대시키기 위해 서브(하위) 디렉토리 활용하여 분산 관리
		// => 날짜별로 하위 디렉토리를 분류하면 관리 용이
		String subDir = ""; // 하위 디렉토리명을 저장할 변수 선언
		
		// 파일 업로드 시점에 맞는 날짜별 서브디렉토리 생성
		// => java.util.Date 클래스보다 java.time 패키지의 LocalXXX 클래스가 더 효율적
		// 1. 현재 시스템의 날짜 정보를 갖는 객체 생성
		// 1-1) java.util.Date 클래스 활용할 경우
//		Date now = new Date(); // 기본 생성자를 호출하여 시스템의 현재 날짜 및 시각 정보 생성
//		System.out.println(now); // Mon Jul 01 12:09:08 KST 2024
		
		// 1-2) java.time.LocalXXX 클래스 활용
		// => 날짜 정보만 관리할 경우 LocalDate, 시각 정보 LocalTime, 날짜 및 시각 정보 LocalDateTime 클래스 활용
		LocalDate today = LocalDate.now();
//		System.out.println(today); // 2024-07-01
		// ----------------------
		// 2. 날짜 포맷을 디렉토리 형식에 맞게 변경
		// => 단, 윈도우 운영체제 기준으로 디렉토리는 백슬래시(\)로 표기하지만
		//    자바 또는 자바스크립트 문자열로 지정할 때 이스케이프 문자로 취급되므로
		//    슬래시(/) 기호로 경로 구분자 사용(백슬래시 사용 시 후처리 추가하면 가능)
		String datePattern = "yyyy/MM/dd"; // 형식 변경에 사용할 패턴 문자열 지정
		
		// 2-1) Date 타입 객체의 날짜 포맷 변경을 위해 java.text.SimpleDateFormat 클래스 활용
		// SimpleDateFormat 클래스 인스턴스 생성 시 파라미터로 패턴 문자열 전달
//		SimpleDateFormat sdf = new SimpleDateFormat(datePattern);
		// SimpleDateFormat 객체의 format() 메서드 호출하여 파라미터도 전달한 Date 객체 날짜 변환
//		System.out.println(sdf.format(now)); // 변환된 날짜 형식에 맞게 문자열로 리턴(2024/07/01)
		
		// 2-2) LocalDate 타입 객체의 날짜 포맷 변경을 위해 java.time.format.DateTimeFormat 클래스 활용
		// DateTimeFormatter.ofPattern() 메서드를 호출하여 파라미터로 패턴 문자열 전달
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		// LocalDate 객체의 format() 메서드 호출하여 DateTimeFormatter 객체 전달하여 날짜 변환
//		System.out.println(today.format(dtf)); // 변환된 날짜 형식에 맞게 문자열로 리턴(2024/07/01)
		// -----------------
		// 3. 지정한 포맷을 적용하여 날짜 형식 변경 결과 문자열을 경로 변수 subDir 에 저장
//		subDir = sdf.format(now); // Date - SimpleDateFormat
		subDir = today.format(dtf); // LocalDate - DateTimeFormatter
		// -----------------
		// 4. 기존 실제 업로드 경로에 서브 디렉토리(날짜 경로) 결합
		realPath += "/" + subDir;
//		System.out.println("realPath : " + realPath);
		// => realPath : D:\Shared\BACKEND\Spring\workspace_spring5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring_MVC_Board\resources\ upload/2024/07/01
		// -----------------
		try {
			// 5. 해당 디렉토리를 실제 경로에 생성(단, 존재하지 않을 경우에만 자동 생성)
			// 5-1) java.nio.file.Paths 클래스의 get() 메서드 호출하여
			//      실제 업로드 경로를 관리하는 java.nio.file.Path 객체 리턴받기
			Path path = Paths.get(realPath); // 파라미터로 실제 업로드 경로 전달
			
			// 5-2) Files 클래스의 createDirectories() 메서드 호출하여 실제 경로 생성
			//      => 이 때, 경로 상에서 생성되지 않은 모든 디렉토리 생성
			//         만약, 최종 서브디렉토리 1개만 생성 시 createDirectory() 메서드도 사용 가능
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// --------------------------------------------------------------------------------------
		// [ 업로드 되는 실제 파일 처리 ]
		// 실제 파일은 BoardVO 객체의 MultipartFile 타입 객체(멤버변수 fileX)가 관리함
		MultipartFile mFile1 = cs.getFile1();
		MultipartFile mFile2 = cs.getFile2();
		
		// MultipartFile 객체의 getOriginalFile() 메서드 호출 시 업로드 한 원본 파일명 리턴
		// => 주의! 업로드 파일이 존재하지 않으면 파일명에 null 값이 아닌 널스트링값 저장됨
		System.out.println("원본파일명1 : " + mFile1.getOriginalFilename());
		System.out.println("원본파일명2 : " + mFile2.getOriginalFilename());
		// --------------------------------------------------------------------------------------
		// [ 파일명 중복 방지 대책 ]
		// - 파일명 앞에 난수를 결합하여 다른 파일과 중복되지 않도록 구분
		// - 숫자만으로 이루어진 난수보다 문자와 함께 결합된 난수가 더 효율적
		// - 난수 생성 라이브러리(SecureRandom 클래스 등)를 활용하거나
		//   UUID 클래스 활용하여 생성 가능
		//   => UUID : 현재 시스템(서버)에서 랜덤ID 값을 추출하여 제공하는 클래스
		//      (Universally Unique IDentifier : 범용 고유 식별자)
//		String uuid = UUID.randomUUID().toString();
//		System.out.println("uuid : " + uuid); // uuid : ea65ea0a-0e06-407d-9e2d-667f4952de63
		
		// 생성된 UUID 값을 원본 파일명 앞에 결합(UUID 값과 파일명 구분을 위해 구분자 "_" 사용)
		// => 원본 파일명을 추출하기 쉽도록 하기 위함(UUID 에서 사용하는 - 기호 외의 다른 기호 사용)
		// ex) ea65ea0a-0e06-407d-9e2d-667f4952de63_blue.jpg
		// => 단, 파일명 길이 조절을 위해 임의로 UUID 중 앞 8자리 문자열만 추출하여 사용
//		System.out.println("uuid 앞자리 8자리 추출 : " + uuid.substring(0, 8)); // 0 ~ 8-1 번까지 문자열 추출
//		System.out.println("파일명1 : " + uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename());
//		System.out.println("파일명2 : " + uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename());
//		System.out.println("파일명3 : " + uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename());
		
		// 단, 자신의 업로드하는 파일명끼리도 중복을 방지하려면 UUID 를 매번 생성하여 결합
//		System.out.println("파일명1 : " + UUID.randomUUID().toString().substring(0, 8) + "_" + mFile1.getOriginalFilename());
//		System.out.println("파일명2 : " + UUID.randomUUID().toString().substring(0, 8) + "_" + mFile2.getOriginalFilename());
//		System.out.println("파일명3 : " + UUID.randomUUID().toString().substring(0, 8) + "_" + mFile3.getOriginalFilename());
		String fileName1 = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile1.getOriginalFilename();
		String fileName2 = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile2.getOriginalFilename();
		
		// 업로드 할 파일이 존재할 경우(원본 파일명이 널스트링이 아닐 경우)에만 
		// BoardVO 객체에 서브디렉토리명과 함께 파일명 저장
		// => 단, 업로드 파일이 선택되지 않은 파일은 파일명에 null 값이 저장되므로
		//    파일명 저장 전 BoardVO 객체의 파일명에 해당하는 멤버변수값을 널스트링("") 으로 변경
		cs.setCs_file("");
		cs.setCs_file1("");
		cs.setCs_file2("");
		
		if(!mFile1.getOriginalFilename().equals("")) {
			cs.setCs_file1(subDir + "/" + fileName1);
		}
		
		if(!mFile2.getOriginalFilename().equals("")) {
			cs.setCs_file2(subDir + "/" + fileName2);
		}
		
		
//		System.out.println("DB 에 저장될 파일명1 : " + board.getBoard_file1());
//		System.out.println("DB 에 저장될 파일명2 : " + board.getBoard_file2());
//		System.out.println("DB 에 저장될 파일명3 : " + board.getBoard_file3());
		// ===============================================================================
		// BoardService - registBoard() 메서드 호출하여 게시물 등록 작업 요청
		// => 파라미터 : BoardVO 객체   리턴타입 : int(insertCount)
		int insertCount = service.registCs(cs);
		
		// 게시물 등록 작업 요청 결과 판별
		if(insertCount > 0) { // 성공
			try {
				// 업로드 파일들은 MultipartFile 객체에 의해 임시 저장공간에 저장되어 있으며
				// 글쓰기 작업 성공 시 임시 저장공간 -> 실제 디렉토리로 이동 작업 필요
				// => MultipartFile 객체의 transferTo() 메서드 호출하여 실제 위치로 이동 처리
				//    (파라미터 : java.io.File 타입 객체 전달)
				// => 단, 업로드 파일이 선택되지 않은 항목은 이동 대상에서 제외
				if(!mFile1.getOriginalFilename().equals("")) {
					// File 객체 생성 시 생성자에 업로드 경로명과 파일명 전달
					mFile1.transferTo(new File(realPath, fileName1));
				}
				
				if(!mFile2.getOriginalFilename().equals("")) {
					mFile2.transferTo(new File(realPath, fileName2));
				}
				
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 글목록(BoardList) 서블릿 주소 리다이렉트
			return "redirect:/Cs";
		} else { // 실패
			// "글쓰기 실패!" 메세지 출력 및 이전 페이지 돌아가기 처리
			model.addAttribute("msg", "글쓰기 실패!");
			return "result/fail";
		}
	}
	
	// 1:1 문의 상세보기
	@GetMapping("CsContent")
	public String csContent(int cs_idx, Model model) {
		
		CsVO selectedCs = service.getCs(cs_idx);
		
		model.addAttribute("selectedCs", selectedCs);
		
		return "cs/csContent";
	}

}
