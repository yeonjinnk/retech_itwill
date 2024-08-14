package com.itwillbs.retech_proj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.StoreVO;

public interface StoreMapper {

	List<Map<String, Object>> selectProductList();

	Map<String, Object> selectProduct(StoreVO store);

	//결제 상품 조회
	Map<String, Object> selectPayProduct(@Param("order_store_item") String order_store_item);

	//선택한 상품 수량 입력
	/*
	int insertPayProduct(@Param("order_store_item")String order_store_item, @Param("order_store_quantity") int order_store_quantity,
			@Param("order_store_pay") int order_store_pay);
	 */
}
