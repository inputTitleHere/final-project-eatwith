package com.kh.eatwith.home.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.eatwith.home.model.service.HomeService;

import lombok.extern.slf4j.Slf4j;

/**
 * 이 컨트롤러는 REST API가 아닌 일반 JSP와의 상호작용을 위한 클래스 입니다.
 * 주로 페이지 이동과 관련된 처리를 합니다. 
 * REST API는 HomeRestContrller에서 관리합니다. 
 *
 */
@Controller
@Slf4j
@RequestMapping("/")
//@CrossOrigin("*")
public class HomeController {

	@Autowired
	HomeService homeSerivce;
	
	@GetMapping("/")
	public void index() {
		// 바로 index.jsp으로 날린다. 
	}
	
	
	
	
}
