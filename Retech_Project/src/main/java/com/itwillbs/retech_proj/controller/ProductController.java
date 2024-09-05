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

	// 리테크상품목록페이지
	// 최신순(날짜순)으로 기본적으로 정렬됨
	@GetMapping("ProductList")
	public String productList(@RequestParam(defaultValue = "1") int pageNum, ProductVO product, Model model, HttpSession session) {
		System.out.println("pageNum ========================" + pageNum);
		int listLimit = 12; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		System.out.println("startRow ============================= : " + startRow);
		// ProductService - getProductList() 호출하여 게시물 목록 조회 요청
		List<ProductVO> productList = service.getProductList(startRow, listLimit);

		// 페이징 처리를 위한 계산작업
		int listCount = service.getProductListCount(); // 전체 게시물 수 조회
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);

		model.addAttribute("productList", productList);
		model.addAttribute("maxPage", maxPage);
		System.out.println("maxPage ============================= : " + maxPage);
		model.addAttribute("listCount", listCount); // 전체 게시물 수

		return "product/product_list";
	}

	// 목록 메서드
	@ResponseBody
	@GetMapping("productListJson")
	public String changedProductList(@RequestParam String pd_category, ProductVO product, @RequestParam String pd_selectedManufacturer,
			@RequestParam String pd_selectedPdStatus, @RequestParam(defaultValue = "0") int pageNum,
			@RequestParam(defaultValue = "최신순") String sort) {
//				System.out.println("pageNum : " + pageNum);
//				System.out.println("sort :  솔트솔트솔트솔트 으아아     :  " + sort);
//				System.out.println("pd_selectedPdStatus : " + pd_selectedPdStatus);
		int listLimit = 12; // 한 페이지에서 표시할 목록 갯수 지정
		int endRow = pageNum * listLimit; // 조회 시작 행(레코드 번호)
		int startRow = (pageNum - 1) * listLimit;
		// 전달할 목록 값 받아오기 (거래중일 경우)
		String type = "거래중";
		System.out.println("pageNum :                 " + pageNum);
		List<HashMap<String, String>> changedProductList = service.getChangedProductList(pageNum, pd_category, pd_selectedManufacturer,
				pd_selectedPdStatus, sort, endRow, startRow, listLimit);
		// 전체 게시물 갯수 계산
		int listCount = service.getChangedProductListCount(pageNum, pd_category, pd_selectedManufacturer, pd_selectedPdStatus, sort, type);

		// 전체페이지 목록 개수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		// => 이것도 리턴값으로 들고가고 싶다 => 객체로 넣기(boardList = XX, maxPage = xx) => JSONObject

		// 최대 페이지번호(maxPage) 값도 JSON 데이터로 함께 넘기기
		JSONObject jsonObject = new JSONObject();

		jsonObject.put("changedProductList", changedProductList);
		jsonObject.put("maxPage", maxPage);
		jsonObject.put("listCount", listCount);
//				System.out.println(jsonObject);

		// 선택한 카테고리와 거래상태에 해당하는 상품리스트 가져오기
//				List<ProductVO> selectedProductList = service.getSelectedProductList(pd_category, pd_status);
//				System.out.println("selectedProductList : " + selectedProductList);

//				jsonObject.put("selectedProductList", selectedProductList);

		return jsonObject.toString();
	}

	// 판매하기 클릭시 상품 등록 페이지로 이동
	@GetMapping("ProductRegistForm")
	public String productRegistForm(HttpSession session, Model model) {
		// 미로그인시 "로그인이 필요합니다." 문구 출력 후 이전 페이지로 돌아감
		// 임시로 주석 처리
		String member_id = (String) session.getAttribute("sId");
		System.out.println("member_id : " + member_id);
		if (member_id == null) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "result/fail";
		}
		// 중고 카테고리 값 전달
		List<HashMap<String, String>> categorylist = service.getCategorylist();
		model.addAttribute("categorylist", categorylist);
		System.out.println("카테고리 리스트!!!!!!!!!!!!!!!!! : " + categorylist);

		return "product/product_regist_form";
	}

	// 상품 등록 처리
	@ResponseBody
	@PostMapping("ProductRegistPro")
	public String ProductRegistPro(ProductVO product, HttpSession session, Model model, HttpServletResponse request) {
		System.out.println("넘어온 product : " + product);

		// JsonConverter 사용하기 위한 Map생성
		Map<String, String> map = new HashMap<>();
		// 기본 리턴값 false
		String rResult = "false";
		// 리테크 상품 설명란 줄바꿈 하기
//			product.setPd_content(product.getPd_content().replaceAll("\r\n", "<br>"));

		// 판매자 아이디 저장
		String member_id = (String) session.getAttribute("sId");
		// 세션에 값들이 잘 넘어오는지 확인
		for (String attrName : Collections.list(session.getAttributeNames())) {
			System.out.println("Session Attribute - Name: " + attrName + ", Value: " + session.getAttribute(attrName));
		}
		// 아이디가 null값일 경우 페이징 처리
		if (member_id == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "result/fail";
		}
		session.setAttribute("sId", member_id);
		System.out.println("판매자 아이디 : " + member_id);
		// 이미지 파일 업로드 처리
		String uploadDir = "/resources/upload";
		//
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		System.out.println("실제 업로드 경로 : " + saveDir);
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
		// (가장 먼저 만나는 _ 기호를 기준으로 문자열 분리하여 처리)
		// => 단, 파일명 길이 조절을 위해 임의로 UUID 중 맨 앞자리 8자리 문자열만 활용
		// System.out.println(uuid.substring(0, 8));
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
		if (pFile1 != null) {
			fileName1 = uuid.substring(0, 8) + "_" + pFile1.getOriginalFilename();
			product.setPd_image1(subDir + "/" + fileName1);
		}
		if (pFile2 != null) {
			fileName2 = uuid.substring(0, 8) + "_" + pFile2.getOriginalFilename();
			product.setPd_image2(subDir + "/" + fileName2);
		}
		if (pFile3 != null) {
			fileName3 = uuid.substring(0, 8) + "_" + pFile3.getOriginalFilename();
			product.setPd_image3(subDir + "/" + fileName3);
		}
		if (pFile4 != null) {
			fileName4 = uuid.substring(0, 8) + "_" + pFile4.getOriginalFilename();
			product.setPd_image4(subDir + "/" + fileName4);
		}
		if (pFile5 != null) {
			fileName5 = uuid.substring(0, 8) + "_" + pFile5.getOriginalFilename();
			product.setPd_image5(subDir + "/" + fileName5);
		}
		System.out.println("실제 업로드 파일명1 : " + product.getPd_image1());
		System.out.println("실제 업로드 파일명2 : " + product.getPd_image2());
		System.out.println("실제 업로드 파일명3 : " + product.getPd_image3());
		System.out.println("실제 업로드 파일명4 : " + product.getPd_image4());
		System.out.println("실제 업로드 파일명5 : " + product.getPd_image5());
		// ------------------------------------------------------------------------------------------
		// 판매할 상품 등록 작업
		System.out.println(product);
		System.out.println("pd_price : " + product.getPd_price());

		int insertCount = service.registBoard(product);
		// 등록 결과를 판별
		// 성공 : 업로드 파일 - 실제 디렉토리에 이동시킨 후, productList 서블릿 리다이렉트
		// 실패 : "글쓰기실패" 출력 후 이전 페이지 돌아가기 처리

		if (insertCount > 0) {// 성공
			// 업로드파일 실제 디렉토리 이동작업
			try {
				if (!pFile1.getOriginalFilename().equals("")) {
					pFile1.transferTo(new File(saveDir, fileName1));
				}
				if (!pFile2.getOriginalFilename().equals("")) {
					pFile2.transferTo(new File(saveDir, fileName2));
				}
				if (!pFile3.getOriginalFilename().equals("")) {
					pFile3.transferTo(new File(saveDir, fileName3));
				}
				if (!pFile4.getOriginalFilename().equals("")) {
					pFile4.transferTo(new File(saveDir, fileName4));
				}
				if (!pFile5.getOriginalFilename().equals("")) {
					pFile5.transferTo(new File(saveDir, fileName5));
				}
				rResult = "true";
				model.addAttribute("res", rResult);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return rResult;
		} else {// 실패
			model.addAttribute("msg", "상품 등록 실패!");
			return "result/fail";
		}

	}
	//중고 상세정보페이지
	//조회성공시 조회수 증가
	@GetMapping("product_detail")
	public String product_detail(@RequestParam int pd_idx,
								@RequestParam String member_id,
								Model model, 
								HttpSession session) {
		//파라미터로 전달받은 상품번호 및 판매자 아이디 확인
		System.out.println(" 상품번호오오오오오오 : " + pd_idx);
		System.out.println(" 판매자아이디이이이이이이 : " + member_id);
	
		//상품번호에 해당하는 상품의 정보조회작업
		ProductVO product = service.getProduct(pd_idx);
		//조회결과 저장
		model.addAttribute("product", product);
		

		//상세페이지의 판매자정보조회 
		//- 파라미터로 전달받은 pd_idx의 member_id와 동일한 member정보 얻어옴
		//  멤버테이블 필요정보 : member_profile, member_nickname, member_address1, member_address_2
		//- 리턴타입 : ,파라미터:상품번호, 멤버아이디
		
		//주의!!!!!-> 파라미터 두개이상일경우 매퍼-(@Param)어노테이션필요!

		
		HashMap<String,String> sellerInfo = service.getSellerInfo(pd_idx, member_id);
		System.out.println("&&&&&&&&&&&&&&&& 판매자정보 : " + sellerInfo);
		model.addAttribute("seller",sellerInfo);
		
		//판매자의 판매상품 개수 조회
		int sellerProduct = service.getSellerProductCount(member_id);
		System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&"+ sellerProduct);
		model.addAttribute("sellerProduct", sellerProduct);
		
		//판매자의 판매목록조회
		List<HashMap<String, String>> sellerProductList = service.getSellerProductList(member_id);
		model.addAttribute("sellerProductList",sellerProductList);
		System.out.println("내가 바로 판매자이다아아아아아!!!!!! : " + sellerProductList);
		
		return"product/product_detail";
	}
	
	
	
	
	
	

}
