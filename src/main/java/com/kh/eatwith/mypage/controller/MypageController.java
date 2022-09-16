package com.kh.eatwith.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String mypage() {
		return "mypage/mypage";
	}
	
	
}
