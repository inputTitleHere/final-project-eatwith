package com.kh.eatwith.mypage.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.member.model.dto.MemberSecurity;
import com.kh.eatwith.mypage.model.service.MypageService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mypage")
@CrossOrigin(origins = "*")
public class MypageController {
	@Autowired
	MypageService mypageService;
	
	@GetMapping()
	public String mypage(HttpServletResponse response) {
		return "mypage/mypage";
	}
	
	@GetMapping("/currentUser")
	public ResponseEntity<?> currentUser(){
		Object MemberObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		log.debug("@@@@@@@ MemberObj :{}",MemberObj);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("no", ((MemberSecurity)MemberObj).getNo());
		return ResponseEntity.ok(result);
	}
	
	
	
}
