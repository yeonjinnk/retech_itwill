package com.itwillbs.retech_proj.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class ReviewVO {

	private int review_idx;
	private String review_writer;
	private int review_pd_idx;
	private int review_star_rating;
	private String review_content;
}
