package com.kh.eatwith.notice.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Transactional;

import com.kh.eatwith.notice.model.dao.NoticeDao;
import com.kh.eatwith.notice.model.dto.Notice;

import lombok.extern.slf4j.Slf4j;
import oracle.security.o3logon.a;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDao noticeDao;
	
	@Override
	public List<Notice> selectNoticeList(Map<String, Integer> param){
		
		//페이징 처리
		int limit = param.get("limit");
		int offset = (param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return noticeDao.selectNoticeList(rowBounds);
	}
	
	@Override
	public int getTotalContent() {
		return noticeDao.getTotalContent();
	}

	@Override
	public int insertNotice(Notice notice) {
		// insert board
		int result = noticeDao.insertNotice(notice);
		log.debug("notice#noticeNO = {}", notice.getNoticeNo());
		
		return result;
	}

	
	
	@Override
	public Notice selectOneNotice(int noticeNo) {
		return noticeDao.selectOneNotice(noticeNo);
	}

	@Override
	public List<Notice> selectNoticeDetail(Map<String, Integer> param){
		return noticeDao.selectNoticeDetail(param);
	}
	
	@Override
	public int deleteNotice(int noticeNo) {
		return noticeDao.deleteNotice(noticeNo);
	}

	@Override
	public int updateNotice(Notice notice) {
		int result = noticeDao.updateNotice(notice);
		log.debug("notice#noticeNo = {}", notice.getNoticeNo());
		log.debug("notice#noticeTitle = {}", notice.getNoticeTitle());
		log.debug("notice#Contents = {}", notice.getNoticeContents());
		
		return result;	}
	
	
}
