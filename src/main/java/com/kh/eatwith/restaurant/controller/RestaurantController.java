package com.kh.eatwith.restaurant.controller;

import java.util.List;

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
		no="3010000-101-2017-00400";
		Restaurant restaurant = restaurantService.selectOneRestaurant(no);
		log.debug("restaurant = {}", restaurant);
		
		List<Review> review = reviewService.selectOneReview(no);
		model.addAttribute("restaurant", restaurant);
		model.addAttribute("review", review);
		return "restaurant/loadInfo";
	}
}
