package com.kh.eatwith.gather.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.gather.model.service.GatherService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/gather")
public class GatherController {
	
	@Autowired
	private GatherService gatherService;
	
	@GetMapping("/gatherEnroll")
	public void gatherEnroll() {}
	
	@GetMapping("/gatherList")
	public void gatherList() {}
	
	@PostMapping("/gatherEnroll")
	public String gatherEnroll(Gather gather) {
		
		return "redirect:/";
	}
}
