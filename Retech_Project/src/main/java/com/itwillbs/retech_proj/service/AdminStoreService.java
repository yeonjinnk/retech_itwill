package com.itwillbs.retech_proj.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.AdminStoreMapper;

@Service
public class AdminStoreService {

	@Autowired AdminStoreMapper mapper;
	//스토어 목록 들고오기
	public List<Map<String, Object>> getStore(int startRow, int listLimit, String searchKeyword) {
		return mapper.selectStore(startRow, listLimit, searchKeyword);
	}

}
