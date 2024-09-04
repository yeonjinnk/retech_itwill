package com.itwillbs.retech_proj.vo;

import java.sql.Time;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReportChatVO {
	private int report_chat_idx;
	private String report_chat_reporter_id;
	private String report_chat_reportee_id;
	private int report_chat_chatroom_idx;
	private Time report_chat_datetime;
	private int report_chat_status;
	private int report_chat_reason;
	private String report_chat_content;
	private String report_chat_img1;
	private String report_chat_img2;
}
