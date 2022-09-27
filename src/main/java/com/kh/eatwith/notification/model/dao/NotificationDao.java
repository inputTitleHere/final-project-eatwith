package com.kh.eatwith.notification.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kh.eatwith.notification.model.dto.Notification;

@Mapper
public interface NotificationDao {

	int insertNotification(Map<String, Object> toSend);
	
	@Select("select * from notification where user_no=#{no} and deleted_at is null order by no desc")
	List<Notification> getNotificationsByUserNo(int no);

	@Update("update notification set read_at=sysdate where no=#{no}")
	int updateRead(int no);

	@Delete("update notification set deleted_at=sysdate where no=#{no}")
	int deleteNotification(int no);

	@Select("select count(*) from notification where user_no=#{no} and deleted_at is null and read_at is null")
	int getNotificationCount(int no);
}
