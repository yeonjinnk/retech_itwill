package com.itwillbs.retech_proj.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.StoreMapper;
import com.itwillbs.retech_proj.vo.StoreVO;

@Service
public class StoreService {
	
	@Autowired
	StoreMapper mapper;
	//상품 목록 조회
	public List<Map<String, Object>> selectProductList() {
		// TODO Auto-generated method stub
		return mapper.selectProductList();
	}
	
	//상품 정보 조회
	public Map<String, Object> selectProduct(StoreVO store) {
		return mapper.selectProduct(store);
	}

	//결제 상품 조회
	public Map<String, Object> selectPayProduct(String order_store_item) {
		return mapper.selectPayProduct(order_store_item);
	}

	//선택한 상품 수량 입력
	/*
	public int insertPayProduct(String order_store_item, int order_store_quantity, int order_store_pay) {
		return mapper.insertPayProduct(order_store_item, order_store_quantity, order_store_pay);
	}*/

	
}
