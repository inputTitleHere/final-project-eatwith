package com.kh.eatwith.notice.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.notice.model.dto.Notice;

public interface NoticeService {

	List<Notice> selectNoticeList(Map<String, Integer> param);

	List<Notice> selectNoticeDetail(Map<String, Integer> param);

	int getTotalContent();
	
	int insertNotice(Notice notice);
	
	Notice selectOneNotice(int noticeNo);

	int deleteNotice(int noticeNo);

	int updateNotice(Notice notice);
	
}
