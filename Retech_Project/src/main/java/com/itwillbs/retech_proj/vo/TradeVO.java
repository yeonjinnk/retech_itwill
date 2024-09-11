package com.itwillbs.retech_proj.vo;


import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor

public class TradeVO {
	private int trade_idx;
	private String trade_buyer_id;
	private String trade_seller_id;
	private int trade_pd_idx;
	private String trade_type;
	private Date trade_date;
	private int trade_status;
	private int trade_amt; // 잠시
}
