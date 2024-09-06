package com.itwillbs.retech_proj.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

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
	private String cs_file;
	private String cs_file1;
	private String cs_file2;
	private MultipartFile[] file; // multiple 속성을 통한 다중 파일 업로드 시 배열로 지정
	private MultipartFile file1;
	private MultipartFile file2;
}
