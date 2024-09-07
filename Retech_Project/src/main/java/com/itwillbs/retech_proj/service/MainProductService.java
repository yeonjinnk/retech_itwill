package com.itwillbs.retech_proj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.vo.ProductVO;

@Service
public class MainProductService {

    @Autowired
    private MainProductRepository mainProductRepository;

    
    // 최근 업데이트 상품 불러오기
    public List<ProductVO> getRecentProducts() {
        return mainProductRepository.findRecentProducts();
    }

    
    // 인기 상품 불러오기
	public List<ProductVO> getPopularProducts() {
		return mainProductRepository.findPopularProducts();
	}
    
    
	
}
