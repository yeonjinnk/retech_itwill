package com.itwillbs.retech_proj.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO {
	private int pd_idx;
	private String us_id;
	private String pd_category;
	private String pd_subject; 
	private String pd_content; 
	private int pd_price; 
	private String pd_status; 
	private Date pd_reg_date; 
	private int pd_readcount; 
	private int town_id; 
	private int product_save;  
	private String pd_image1; 
	private String pd_image2; 
	private String pd_image3; 
	private String pd_image4; 
	private String pd_image5;
	
	// 2) MultipartFile 타입으로 지정할 변수는 업로드되는 실제 파일을 다룰 용도로 사용
	//    => 멤버변수명은 form 태그에서 지정한 파일 업로드 요소의 name 속성과 같게 지정
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile file3;
	private MultipartFile file4;
	private MultipartFile file5;
}
