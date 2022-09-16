package com.kh.eatwith.restaurant.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.district.model.dto.District;
import com.kh.eatwith.district.model.service.DistrictService;
import com.kh.eatwith.favorite.model.service.FavoriteRestaurantService;
import com.kh.eatwith.foodtype.model.dto.FoodType;
import com.kh.eatwith.foodtype.model.service.FoodtypeService;
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.gather.model.service.GatherService;
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
	
	@Autowired
	DistrictService districtService;
	
	@Autowired
	FoodtypeService foodtypeService;
	
	@Autowired
	FavoriteRestaurantService favoriteRestaurantService; 
	
	@Autowired
	GatherService gatherService;
	
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
//		no="3010000-101-2017-00400"; // 리뷰 많은 쌀국수집
		no="3150000-101-2001-09860"; //빈대떡집 메뉴 5개
//		no="3010000-101-2014-00196"; //카페
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
		double avg;
		double sum = 0;
		for(Review review : reviews) {
			sum += (double)review.getOverallScore();
		}
		if(reviews.size() != 0) {
			avg = (double) sum / reviews.size();
		} else {
			avg = 0.0;
		}
		
		District district = districtService.findNameByCode(restaurant.getDistrictCode());
		FoodType foodType = foodtypeService.findTypeByCode(restaurant.getFoodCode());
		
		List<Gather> gathers = gatherService.selectReviewByRestaurantNo(restaurant.getNo());
		for(Gather gather : gathers) {
			model.addAttribute("gather", gather);
		}
		log.debug("gathers = {}", gathers);
		// 찜 확인용 데이터 가져오기
		//int result = favoriteRestaurantService.getRestaurantLikeVal(no);
		
		model.addAttribute("gathers", gathers);
		model.addAttribute("district", district);
		model.addAttribute("foodType", foodType);
		model.addAttribute("restaurant", restaurant);
		model.addAttribute("reviews", reviews);
		model.addAttribute("avg", avg);
		model.addAttribute("whlist", whlist);
		model.addAttribute("menuList", menuList);
		
		return "restaurant/loadInfo";
	}
	
//	@PostMapping("/loadInfo")
//	@ResponseBody
//	public ResponseEntity<?> restaurantLike(FavoriteRestaurant favoriteRestaurant){
//		try {
//			int result = favoriteRestaurantService.setRestaurantLike(favoriteRestaurant);
//			return ResponseEntity.ok(result);
//		} catch (Exception e) {
//			e.printStackTrace();
//			return (ResponseEntity<?>) ResponseEntity.status(HttpStatus.BAD_REQUEST);
//		}
//	}
//	
//	@DeleteMapping("/loadInfo")
//	@ResponseBody
//	public ResponseEntity<?> restaurantLikeCancel(FavoriteRestaurant favoriteRestaurant){
//		try {
//			int result = favoriteRestaurantService.restaurantLikeCancel(favoriteRestaurant);
//			return ResponseEntity.ok(result);
//		} catch (Exception e) {
//			e.printStackTrace();
//			return (ResponseEntity<?>) ResponseEntity.status(HttpStatus.BAD_REQUEST);
//		}
//	}
	
	@GetMapping("/checkFaved")
	@ResponseBody
	public ResponseEntity<?> checkFaved(@RequestParam int userNo, String restaurantNo){
		
		Map<String, Object> param = new HashMap<>();
		param.put("userNo", userNo);
		param.put("restaurantNo", restaurantNo);
		
		int result = favoriteRestaurantService.checkFav(param);
		
		if(result == 0) {
			return ResponseEntity.ok(false);
		} else {
			return ResponseEntity.ok(result);
		}
	}
	
}
