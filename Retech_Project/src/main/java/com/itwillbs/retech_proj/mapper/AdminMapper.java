package com.itwillbs.retech_proj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.retech_proj.vo.MemberVO;


@Mapper
public interface AdminMapper {

	List<MemberVO> selectGetMember();



}
