package com.itwillbs.retech_proj.controller;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.itwillbs.retech_proj.service.ProductService;
import com.itwillbs.retech_proj.vo.ProductVO;
@Controller
public class ProductController {
	@Autowired
	   private ProductService service;
	
	//중고상품목록페이지
	//최신순으로 정렬
	@GetMapping("ProductList")
	public String productList(@RequestParam(defaultValue = "1") int pageNum,
			ProductVO product, Model model, HttpSession session) {
		//공통코드 사용하여 카테고리별로 목록 표시
		
		
		
		
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		//ProductService - getProductList() 호출하여 게시물목록 조회요청
		//파라미터 : (검색타입,검색어), 시작행번호, 목록갯수
		List<ProductVO> productList = service.getProductList(startRow, listLimit);
		
		//페이징처리 위한 계산작업----------------------------------------------------
		//1. ProductService - getProductListCount() 호출하여 전체게시물 수 조회요청
		int listCount = service.getProductListCount();
		//2. 전체페이지 목록 개수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		model.addAttribute("productList",productList);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("listCount", listCount);//전체게시물수
		
		return"product/product_list";
	}
	//판매하기 클릭시 상품 등록 페이지로 이동
	@GetMapping("ProductRegistForm")
	public String productRegistForm(HttpSession session, Model model) {
		//미로그인시 "로그인이 필요합니다." 문구 출력 후 이전 페이지로 돌아감
		//임시로 주석 처리
//		String member_id = (String)session.getAttribute("member_id");
//		System.out.println("member_id : " + member_id);
//		if(member_id == null) {
//			model.addAttribute("msg", "로그인이 필요합니다.");
//			return"result/fail";
//		}
		return"product/product_regist_form";
	}
	//상품 등록 처리
	@ResponseBody
	@PostMapping("ProductRegistPro")
	public String productRegistPro(ProductVO product, HttpSession session, Model model, HttpServletResponse request) {
		//JsonConverter 사용하기 위한 Map생성
		Map<String,String> map = new HashMap<>();
		//기본 리턴값 false
		String rResult = "false";
		//리테크 상품 설명란 줄바꿈 하기
//		product.setPd_content(product.getPd_content().replaceAll("\r\n", "<br>"));
		
		//판매자 아이디 저장
		String member_id = (String)session.getAttribute("sId");
		session.setAttribute("sId", member_id);
		System.out.println("판매자 아이디 : " + member_id);
		//세션에 값들이 잘 넘어오는지 확인
		for (String attrName : Collections.list(session.getAttributeNames())) {
			System.out.println("Session Attribute - Name: " + attrName + ", Value: " + session.getAttribute(attrName));
		}
		// 아이디가 null값일 경우 페이징 처리
		if(member_id == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "result/fail";
		}
		//이미지 파일 업로드 처리
		String uploadDir = "/resources/upload";
		//
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		System.out.println("실제 업로드 경로 : "+ saveDir);
		// 서브디렉토리(날짜 구분)
		String subDir = "";
		try {
			// Mon Jun 19 11:26:52 KST 2023
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		// VO 객체에 전달된 MultipartFile 객체 꺼내기
		MultipartFile pFile1 = product.getFile1();
		MultipartFile pFile2 = product.getFile2();
		MultipartFile pFile3 = product.getFile3();
		MultipartFile pFile4 = product.getFile4();
		MultipartFile pFile5 = product.getFile5();
		
		// 파일명 중복 방지
		// 현재 시스템(서버)에서 랜덤ID 값을 추출하여 파일명 앞에 붙여서
		// "랜덤ID값_파일명.확장자" 형식으로 중복 파일명 처리
		// => 랜덤ID 생성은 java.util.UUID 클래스 활용(UUID = 범용 고유 식별자)
		String uuid = UUID.randomUUID().toString();
		System.out.println("uuid : " + uuid);
		
		// 생성된 UUID 값을 원본 파일명 앞에 결합(파일명과 구분을 위해 _ 기호 추가)
		// => 나중에 사용자 다운로드 시 원본 파일명 표시를 위해 분리할 때 구분자로 사용
		//    (가장 먼저 만나는 _ 기호를 기준으로 문자열 분리하여 처리)
		// => 단, 파일명 길이 조절을 위해 임의로 UUID 중 맨 앞자리 8자리 문자열만 활용
		//System.out.println(uuid.substring(0, 8));
		// 생성된 UUID 값(8자리 추출)과 업로드 파일명을 결합하여 BoardVO 객체에 저장(구분자로 _ 기호 추가)
		// => 단, 파일명이 존재하는 경우에만 파일명 생성(없을 경우를 대비하여 기본 파일명 널스트링으로 처리)
		product.setPd_image1("");
		product.setPd_image2("");
		product.setPd_image3("");
		product.setPd_image4("");
		product.setPd_image5("");
		// 파일명을 저장할 변수 선언
		String fileName1 = null;
		String fileName2 = null;
		String fileName3 = null;
		String fileName4 = null;
		String fileName5 = null;
		// 업로드 된 파일 존재시 fileNameN 변수에
		if(pFile1 != null) {
			fileName1 = uuid.substring(0, 8) + "_" + pFile1.getOriginalFilename();
			product.setPd_image1(subDir + "/" + fileName1);
		}
		if(pFile2 != null) {
			fileName2 = uuid.substring(0, 8) + "_" + pFile2.getOriginalFilename();
			product.setPd_image2(subDir + "/" + fileName2);
		}
		if(pFile3 != null) {
			fileName3 = uuid.substring(0, 8) + "_" + pFile3.getOriginalFilename();
			product.setPd_image3(subDir + "/" + fileName3);
		}
		if(pFile4 != null) {
			fileName4 = uuid.substring(0, 8) + "_" + pFile4.getOriginalFilename();
			product.setPd_image4(subDir + "/" + fileName4);
		}
		if(pFile5 != null) {
			fileName5 = uuid.substring(0, 8) + "_" + pFile5.getOriginalFilename();
			product.setPd_image5(subDir + "/" + fileName5);
		}
		System.out.println("실제 업로드 파일명1 : " + product.getPd_image1());
		System.out.println("실제 업로드 파일명2 : " + product.getPd_image2());
		System.out.println("실제 업로드 파일명3 : " + product.getPd_image3());
		System.out.println("실제 업로드 파일명4 : " + product.getPd_image4());
		System.out.println("실제 업로드 파일명5 : " + product.getPd_image5());
		//------------------------------------------------------------------------------------------
		//판매할 상품 등록 작업
		System.out.println(product);
		int insertCount = service.registBoard(product);
		//등록 결과를 판별
		//성공 : 업로드 파일 - 실제 디렉토리에 이동시킨 후, productList 서블릿 리다이렉트
		//실패 : "글쓰기실패" 출력 후 이전 페이지 돌아가기 처리
		
		if(insertCount > 0) {//성공
			//업로드파일 실제 디렉토리 이동작업
			try {
				if(!pFile1.getOriginalFilename().equals("")) {
					pFile1.transferTo(new File(saveDir, fileName1));
				}
				if(!pFile2.getOriginalFilename().equals("")) {
					pFile2.transferTo(new File(saveDir, fileName2));
				}
				if(!pFile3.getOriginalFilename().equals("")) {
					pFile3.transferTo(new File(saveDir, fileName3));
				}
				if(!pFile4.getOriginalFilename().equals("")) {
					pFile4.transferTo(new File(saveDir, fileName4));
				}
				if(!pFile5.getOriginalFilename().equals("")) {
					pFile5.transferTo(new File(saveDir, fileName5));
				}
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "result/success";
		} else {//실패
			model.addAttribute("msg", "상품 등록 실패!");
			return "result/fail";
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	  
}




