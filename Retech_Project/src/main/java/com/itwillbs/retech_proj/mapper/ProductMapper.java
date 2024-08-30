package com.itwillbs.retech_proj.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.ProductVO;


@Mapper
public interface ProductMapper {
	
	//상품 등록 처리
	int insertProduct(ProductVO product);
	//상품 목록 조회 요청
	List<ProductVO> selectProductList(int startRow, int listLimit);
	//상품 목록 개수조회 요청(페이징처리)
	int selectProductListCount();
	
	//선택한 카테고리와 거래상태에 해당하는 상품리스트 가져오기
	List<ProductVO> selectSelectedProductList(@Param("pd_category") String pd_category, @Param("pd_status") String pd_status);

//	//리테크 상품 수정
//	int updateProduct(ProductVO product);


}
