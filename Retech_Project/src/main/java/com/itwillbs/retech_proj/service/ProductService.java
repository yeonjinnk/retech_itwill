package com.itwillbs.retech_proj.service;

import java.util.HashMap;
import java.util.List;

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
		int insertcount = mapper.insertProduct(product);
		return insertcount;
	}
	//리테크 상품수정작업
//	public int modifyProduct(ProductVO product) {
//		return mapper.updateProduct(product);
//	}

}
