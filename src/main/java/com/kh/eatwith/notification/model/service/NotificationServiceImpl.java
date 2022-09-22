package com.kh.eatwith.notification.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.eatwith.notification.model.dao.NotificationDao;
import com.kh.eatwith.notification.model.dto.Notification;

@Service
public class NotificationServiceImpl implements NotificationService {

	@Autowired
	private NotificationDao notificationDao;
	
	@Override
	public int insertNotification(Map<String, Object> toSend) {
		return notificationDao.insertNotification(toSend);
	}
	
	@Override
	public List<Notification> getNotificationsByUserNo(int no) {
		return notificationDao.getNotificationsByUserNo(no);
	}
	@Override
	public int updateRead(int no) {
		return notificationDao.updateRead(no);
	}
	@Override
	public int deleteNotification(int no) {
		return notificationDao.deleteNotification(no);
	}
	
}
