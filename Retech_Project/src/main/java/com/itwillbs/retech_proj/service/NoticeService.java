package com.itwillbs.retech_proj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.retech_proj.mapper.NoticeMapper;
import com.itwillbs.retech_proj.vo.NoticeVO;

@Service
public class NoticeService {
	@Autowired
    private NoticeMapper mapper;

	public int getNoticeListCount(String searchKeyword) {
		return mapper.selectNoticeListCount(searchKeyword);
	}

	public List<NoticeVO> getNoticeList(int startRow, int listLimit, String searchKeyword) {
		return mapper.selectNoticeList(startRow, listLimit, searchKeyword);
	}
	
	public NoticeVO getNotice(int notice_idx) {
		return mapper.selectNotice(notice_idx);
	}



}
