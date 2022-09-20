package com.kh.eatwith.notification.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.member.model.dto.MemberSecurity;
import com.kh.eatwith.notification.model.dto.Notification;
import com.kh.eatwith.notification.model.service.NotificationService;

import lombok.extern.slf4j.Slf4j;

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
		
		return ResponseEntity.ok(notifications);
	}
	
	
}
