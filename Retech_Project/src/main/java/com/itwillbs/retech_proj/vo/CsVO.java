package com.itwillbs.retech_proj.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class CsVO {

	private int cs_idx;
	private int cs_product;
	private String cs_member_id;
	private String cs_category;
	private String cs_subject;
	private String cs_content;
	private Date cs_date;
	private String cs_check;
	private String cs_answer;
}
