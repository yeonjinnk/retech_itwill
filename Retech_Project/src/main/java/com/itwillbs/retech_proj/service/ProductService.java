package com.itwillbs.retech_proj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.ProductMapper;
import com.itwillbs.retech_proj.vo.ProductVO;

@Service
public class ProductService {
	
	 @Autowired
	 private ProductMapper mapper;
	 // 상품 목록 페이지
	 public List<ProductVO> getProductList(int startRow, int listLimit) {
		return mapper.selectProductList(startRow, listLimit);
	 }
	// 페이징처리 - 상품 전체 개수 
	public int getProductListCount() {
		return mapper.selectProductListCount();
	}
	//리텍트 상품 등록 처리
	public int registBoard(ProductVO product) {
		return mapper.insertProduct(product);
	}	
	//리테크 상품수정작업
	//	public int modifyProduct(ProductVO product) {
	//		return mapper.updateProduct(product);
	//	}
	
	//선택한 카테고리와 거래상태에 해당하는 상품리스트 가져오기
	public List<ProductVO> getSelectedProductList(String pd_category, String pd_status) {
		// TODO Auto-generated method stub
		return mapper.selectSelectedProductList(pd_category, pd_status);
	}

}
