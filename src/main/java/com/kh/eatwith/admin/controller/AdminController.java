package com.kh.eatwith.admin.controller;

import java.security.Principal;
import java.sql.Array;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.eatwith.admin.model.service.AdminService;
import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.common.TestMap;
import com.kh.eatwith.common.typehandler.EatWithUtils;
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.member.model.service.MemberService;
import com.kh.eatwith.notice.controller.NoticeController;
import com.kh.eatwith.notice.model.dto.Notice;
import com.kh.eatwith.notice.model.service.NoticeService;
import com.kh.eatwith.restaurant.model.dto.Restaurant;
import com.kh.eatwith.restaurant.model.service.RestaurantService;
import com.kh.eatwith.review.model.dto.Review;
import com.kh.eatwith.review.model.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	ServletContext application;
	
	@Autowired
	ResourceLoader resourceLoader;

	@Autowired
	private AdminService adminService;
	
	
	@GetMapping("/adminPage")
	public void adminPage(Model model) {
		List<TestMap> restaurant = adminService.selectRestaurant();
		List<TestMap> gather = adminService.selectGather();
		List<TestMap> member = adminService.selectMember();
		
		model.addAttribute("restaurant",restaurant);
		model.addAttribute("gather",gather);
		model.addAttribute("member",member);
		
		log.debug("restaurant = {}", restaurant);
		log.debug("gather = {}", gather);
		log.debug("member = {}", member);
		
		
		int lastGather = adminService.selectGatherYes();
		int todayGather = adminService.selectGatherTo();
		int nowGather = adminService.selectGatherNow();
		
		model.addAttribute("lastGather",lastGather);
		model.addAttribute("todayGather",todayGather);
		model.addAttribute("nowGather",nowGather);
		
		List<TestMap> gatherRatio = adminService.selectGatherRatio();
		model.addAttribute("gatherRatio",gatherRatio);
	}
	
//	@GetMapping("/checkFood")
//	@ResponseBody
//	public ResponseEntity<?> checkFood(@RequestParam("checkFood") int checkFood,Model model){
//		
//		log.debug("checkFood={}",checkFood);
//		List<Gather> resultF=gatherService.checkFood(checkFood);
//		log.debug("resultFood={}",resultF);
//		return ResponseEntity.ok(resultF);
//	}
	
	
}
