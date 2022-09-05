package com.kh.eatwith.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class FaviconController {
	
	@GetMapping("/favicon.ico")
	public String favicon() {
		log.debug("favicon Load 시도 ");
		return "forward:/resources/images/favicon.ico";
	}
	
}
