package com.itwillbs.retech_proj.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class NoticeVO {
	private int notice_idx;
	private String notice_sell;
	private String notice_subject;
	private String notice_content;
	private Date notice_date;
	private int notice_reply_num;
	private String notice_reply_name;
	private String notice_reply_content;
	private int notice_reply_re_ref;
	private int notice_reply_re_lev;
	private int notice_reply_re_seq;
	
}
