package com.itwillbs.retech_proj.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class NoticeVO {
	private int notice_idx;
	private String notice_subject;
	private String notice_content;
	private Date notice_date;
	private int notice_reply_re_ref;
	private int notice_reply_re_lev;
	private int notice_reply_re_seq;
	private String notice_writer_ip;
	private int notice_readcount;
}
