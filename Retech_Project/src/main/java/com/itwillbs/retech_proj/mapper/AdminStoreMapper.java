package com.itwillbs.retech_proj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminStoreMapper {

	//스토어 상품 가져오기
	List<Map<String, Object>> selectStore(@Param("startRow") int startRow, @Param("listLimit") int listLimit, @Param("searchKeyword") String searchKeyword);

}
