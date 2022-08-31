package com.kh.eatwith.home.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.eatwith.home.model.service.HomeService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/")
public class HomeRestController {

	@Autowired
	HomeService homeSerivce;
	
	
}
