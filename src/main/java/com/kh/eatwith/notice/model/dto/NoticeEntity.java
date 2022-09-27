package com.kh.eatwith.notice.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeEntity {

	private int noticeNo;
	private String noticeTitle;
	private String noticeContents;
	private LocalDate noticeDate;
	private LocalDate deletedAt;
	private LocalDate updatedAt;

}
