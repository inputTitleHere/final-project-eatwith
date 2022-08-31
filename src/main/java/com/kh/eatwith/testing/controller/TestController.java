package com.kh.eatwith.testing.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.eatwith.testing.model.dto.TestTable;
import com.kh.eatwith.testing.model.service.TestService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/test")
@Slf4j
public class TestController {
	@Autowired
	TestService testService;
	
	@GetMapping("/test.do")
	public ResponseEntity<?> testReturnJson(){
		log.debug("Half a Success");
		Map<String, Object> result = new HashMap<String, Object>();
		TestTable numberResult = testService.getAll();
		log.debug("number = {}",numberResult);
		result.put("number", numberResult);
		return ResponseEntity.ok(result);
		
	}
	
}
