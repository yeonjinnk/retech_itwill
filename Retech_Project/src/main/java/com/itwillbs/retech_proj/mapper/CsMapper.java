package com.itwillbs.retech_proj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.retech_proj.vo.CsVO;


@Mapper
public interface CsMapper {

	int selectCsListCount(String id);

	List<CsVO> selectCsList(@Param("startRow") int startRow, 
							@Param("listLimit") int listLimit, 
							@Param("isAdmin") Boolean isAdmin,
							@Param("id") String id);
	
	int insertCs(CsVO cs);

	// cs 문의 상세보기
	CsVO selectCs(int cs_idx);


}
