package com.itwillbs.retech_proj.vo;

import com.google.protobuf.Timestamp;

import lombok.Data;
@Data
public class OrderStoreVO {
	private int order_store_idx;
	private int order_store_item;
	private String order_store_member_id;
	private Timestamp order_store_date;
	private int order_store_quantity;
	private int order_store_pay;
}
