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
		// TODO Auto-generated method stub
		return mapper.selectProductList(startRow, listLimit);
	}
	// 페이징처리 - 상품 전체 개수 
	public int getProductListCount() {
		// TODO Auto-generated method stub
		return mapper.selectProductListCount();
	}

}
