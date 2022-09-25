package com.kh.eatwith.notification.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.member.model.dto.MemberSecurity;
import com.kh.eatwith.notification.model.dto.Notification;
import com.kh.eatwith.notification.model.service.NotificationService;

import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@Slf4j
@RequestMapping("/notification")
@ResponseBody
public class NotificationController {

	@Autowired
	NotificationService notificationService;
	
	// class에 response body 붙임
	@GetMapping("/getNotifications")
	public ResponseEntity<?> getNotifications(){
		// 세션을 사용한다. 
		Object MemberObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int no = ((MemberSecurity)MemberObj).getNo();
		log.debug("MemberNo :{}",no);
		
		List<Notification> notifications = notificationService.getNotificationsByUserNo(no);
		log.debug("notifications = {}",notifications);
		return ResponseEntity.ok(notifications);
	}
	
	@PostMapping("/readNotification")
	public ResponseEntity<?> readNotification(@RequestParam int no){
//		시간 안써도 되네. sysdate 사용하자.
//		@RequestBody @DateTimeFormat(pattern="yyyy-MM-dd") LocalDate currentDate
//		log.debug("currentDate = {}",currentDate);
		log.debug("gather no = {}",no);
		int result = notificationService.updateRead(no);
		return ResponseEntity.ok(null);
	}
	
	@PostMapping("/deleteNotification")
	public ResponseEntity<?> deleteNotification(@RequestParam int no){
		log.debug("Deleting notification = {} ",no);
		int result = notificationService.deleteNotification(no);
		
		return ResponseEntity.ok(null);
	}
	
	
}
