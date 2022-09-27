package com.kh.eatwith.notification.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.notification.model.dto.Notification;

public interface NotificationService {

	int insertNotification(Map<String, Object> toSend);

	List<Notification> getNotificationsByUserNo(int no);

	int updateRead(int no);

	int deleteNotification(int no);

	int getNotificationCount(int no);

}
