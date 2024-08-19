package com.itwillbs.retech_proj.mapper;

import java.util.List;
import java.util.Map;

import com.itwillbs.retech_proj.vo.StoreVO;

public interface StoreMapper {

	List<Map<String, Object>> selectProductList();

	Map<String, Object> selectProduct(StoreVO store);

	//상품 정보 조회2
	Map<String, Object> selectStore(int store_idx);

}
