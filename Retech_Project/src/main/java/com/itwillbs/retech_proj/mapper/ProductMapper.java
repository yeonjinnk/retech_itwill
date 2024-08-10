package com.itwillbs.retech_proj.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.retech_proj.vo.ProductVO;


@Mapper
public interface ProductMapper {
	

	//상품 목록 조회 요청
	List<ProductVO> selectProductList(int startRow, int listLimit);
	// 상품 목록 개수조회 요청(페이징처리)
	int selectProductListCount();


}
