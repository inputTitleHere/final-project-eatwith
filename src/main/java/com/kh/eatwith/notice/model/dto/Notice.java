package com.kh.eatwith.notice.model.dto;

import java.time.LocalDate;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
 @ToString(callSuper = true)
public class Notice extends NoticeEntity{

	private String pre;
	private String next;
	
	public Notice(int noticeNo,String noticeTitle,String noticeContents,
					LocalDate noticeDate,LocalDate deletedAt,LocalDate updatedAt,String pre, String next) {
		super(noticeNo,noticeTitle,noticeContents,noticeDate,deletedAt,updatedAt);
		this.pre = pre;
		this.next = next;
	}

}
