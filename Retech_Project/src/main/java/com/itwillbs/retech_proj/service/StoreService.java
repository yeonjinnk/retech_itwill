package com.itwillbs.retech_proj.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.StoreMapper;
import com.itwillbs.retech_proj.vo.OrderStoreVO;
import com.itwillbs.retech_proj.vo.StoreVO;

@Service
public class StoreService {
	
	@Autowired
	StoreMapper mapper;
	//상품 목록 조회
	public List<Map<String, Object>> selectProductList(Map<String, String> map) {
		return mapper.selectProductList(map);
	}
	
	//상품 정보 조회
	public Map<String, Object> selectProduct(int store_idx) {
		return mapper.selectProduct(store_idx);
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
	//상품 정보 조회2
	public Map<String, Object> selectStore(int store_idx) {
		return mapper.selectStore(store_idx);
	}

	// 상품 결제 정보 저장하기
	public int insertStorePay(Map<String, Object> map) {
		return mapper.insertStorePay(map);
	}

	//주문한 스토어 내역 조회하기
	public List<Map<String, Object>> getStoreHistory(String id) {
		return mapper.selectStoreHistory(id);
	}
	

	
}
