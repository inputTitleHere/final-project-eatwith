package com.kh.eatwith.notification.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.eatwith.notification.model.dto.Notification;

@Mapper
public interface NotificationDao {

	int insertNotification(Map<String, Object> toSend);
	
	@Select("select * from notification where user_no=#{no}")
	List<Notification> getNotificationsByUserNo(int no);

}
