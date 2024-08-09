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

	
}
