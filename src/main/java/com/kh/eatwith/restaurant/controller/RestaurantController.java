package com.kh.eatwith.restaurant.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.restaurant.model.dto.Restaurant;
import com.kh.eatwith.restaurant.model.service.RestaurantService;
import com.kh.eatwith.review.model.dto.Review;
import com.kh.eatwith.review.model.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/restaurant")
@Slf4j
public class RestaurantController {
	
	@Autowired
	RestaurantService restaurantService;
	
	@Autowired
	ReviewService reviewService;
	
	@GetMapping("/findRestaurantByName")
	@ResponseBody
	public ResponseEntity<?> findRestaurantByName(@RequestParam String searchString){
		
		List<Restaurant> searchResult=restaurantService.findRestaurantByName(searchString);
		
		return ResponseEntity.ok(searchResult);
	}
	
	/**
	 * GET /restaurant/loadInfo?no=
	 */
	@GetMapping("/loadInfo")
	public String loadInfo(String no ,Model model) {
//		no="3010000-101-2017-00400"; 
//		no="3150000-101-2001-09860"; 빈대떡집 메뉴 5개
		no="3010000-101-2014-00196"; //카페
		Restaurant restaurant = restaurantService.selectOneRestaurant(no);
		StringTokenizer stk1 = new StringTokenizer(restaurant.getWorkHours(), "\n");
		String result1 = "";
		List<String> whlist = new ArrayList<>();
		
		while(stk1.hasMoreTokens()) {
			result1 = stk1.nextToken();
			whlist.add(result1);
		}
		
		StringTokenizer stk2 = new StringTokenizer(restaurant.getMenu(), "\n");
		String result2 = "";
		List<String> menuList = new ArrayList<>();
		
		while(stk2.hasMoreTokens()) {
			result2 = stk2.nextToken();
			menuList.add(result2);
		}
		
		log.debug("restaurant = {}", restaurant);
		
		List<Review> reviews = reviewService.selectOneReview(no);
		log.debug("reviews = {}", reviews);
		for(Review review : reviews) {
			model.addAttribute("review", review);
		}
		
		model.addAttribute("restaurant", restaurant);
		model.addAttribute("reviews", reviews);
		model.addAttribute("whlist", whlist);
		model.addAttribute("menuList", menuList);
		
		return "restaurant/loadInfo";
	}
	
	// html 개행 무시됨 -> 원본 데이터는 개행문자가 포함되어있음(구분됨) -> StringTokenize 구분자 또는 / 처리하면 조금은 간편 <타입이 여러개일 것>
	public String[] formatMenu(String input) {
		String[] arr = input.split("원");
		return arr;
	}
	
}
