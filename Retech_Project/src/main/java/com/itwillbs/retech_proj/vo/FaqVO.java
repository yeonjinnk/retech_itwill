package com.itwillbs.retech_proj.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class FaqVO {

	private int faq_idx;
	private String faq_category;
	private String faq_subject;
	private String faq_content;
	private Date faq_date;

}
