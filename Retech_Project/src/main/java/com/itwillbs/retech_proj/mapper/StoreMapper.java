package com.itwillbs.retech_proj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.StoreVO;

public interface StoreMapper {

	//상품 목록 띄우기
	List<Map<String, Object>> selectProductList(Map<String, String> map);

	Map<String, Object> selectProduct(int store_idx);

	//결제 상품 조회
	Map<String, Object> selectPayProduct(@Param("order_store_item") String order_store_item);

	//선택한 상품 수량 입력
	/*
	int insertPayProduct(@Param("order_store_item")String order_store_item, @Param("order_store_quantity") int order_store_quantity,
			@Param("order_store_pay") int order_store_pay);
	 */
	//상품 정보 조회2
	Map<String, Object> selectStore(int store_idx);

	//상품 결제 정보 저장하기
	int insertStorePay(Map<String, Object> map);

}
