package com.itwillbs.retech_proj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.AdminMapper;
import com.itwillbs.retech_proj.vo.MemberVO;

@Service
public class AdminService {

	@Autowired
	private AdminMapper mapper;
	
	public List<MemberVO> getMemberList() {
		 return mapper.selectGetMember();
	}

}
