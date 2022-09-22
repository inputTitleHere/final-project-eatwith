package com.kh.eatwith.restaurant.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Stack;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
import com.kh.eatwith.member.model.service.MemberService;
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
	
	@Autowired
	MemberService memberService;
	
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
	public String loadInfo(@RequestParam String no, Model model) {
//		no="3010000-101-2017-00400"; // 리뷰 많은 쌀국수집
//		no="3150000-101-2001-09860"; //빈대떡집 메뉴 5개
//		no="3010000-101-2014-00196"; //카페
//		no="3010000-101-2017-00021"; // 복국 멤버 모집 확인용
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

		double totalAvg;
		double totalTasteAvg;
		double totalPriceAvg;
		double totalServiceAvg;
		double sum = 0;
		double sumTaste = 0;
		double sumPrice = 0;
		double sumService = 0;
		for(Review review : reviews) {
			sum += (double)review.getOverallScore();
			sumTaste += (double) review.getTasteScore();
			sumPrice += (double) review.getPriceScore();
			sumService += (double) review.getServiceScore();
			
		}

		if(reviews.size() != 0) {
			totalAvg = (double) sum / reviews.size();
			totalTasteAvg = (double) sumTaste / reviews.size();
			totalPriceAvg = (double) sumPrice / reviews.size();
			totalServiceAvg = (double) sumService / reviews.size();
		} else {
			totalAvg = 0.0;
			totalTasteAvg = 0.0;
			totalPriceAvg = 0.0;
			totalServiceAvg = 0.0;
		}
		
		District district = districtService.findNameByCode(restaurant.getDistrictCode());
		FoodType foodType = foodtypeService.findTypeByCode(restaurant.getFoodCode());
		
		List<Gather> gathers = gatherService.selectReviewByRestaurantNo(restaurant.getNo());
		for(Gather gather : gathers) {
			int memGather = gatherService.countGatherMem(gather.getNo()); // 리뷰 작성자 수
			model.addAttribute("gather", gather);
			model.addAttribute("memGather", memGather);
		}
		log.debug("gathers = {}", gathers);
		
		int favCount = favoriteRestaurantService.checkFavCount(restaurant.getNo());
		log.debug("favCount = {}", favCount);
		
		model.addAttribute("favCount", favCount);
		model.addAttribute("gathers", gathers);
		model.addAttribute("district", district);
		model.addAttribute("foodType", foodType);
		model.addAttribute("restaurant", restaurant);
		model.addAttribute("reviews", reviews);
		model.addAttribute("totalAvg", totalAvg);
		model.addAttribute("totalTasteAvg", totalTasteAvg);
		model.addAttribute("totalPriceAvg", totalPriceAvg);
		model.addAttribute("totalServiceAvg", totalServiceAvg);
		model.addAttribute("whlist", whlist);
		model.addAttribute("menuList", menuList);
		
		return "restaurant/loadInfo";
	}
	
	@GetMapping("/checkFaved")
	@ResponseBody
	public ResponseEntity<?> checkFaved(int userNo, String restaurantNo){
		Map<String, Object> param = new HashMap<>();
		param.put("userNo", userNo);
		param.put("restaurantNo", restaurantNo);
		
		int result = favoriteRestaurantService.checkFav(param);
		log.debug("result = {}", result);

		return ResponseEntity.ok(result >= 1 ? true : false);
	}
	
	@GetMapping("/toggleFav")
	@ResponseBody
	public ResponseEntity<?> toggleFav(int userNo, String restaurantNo, boolean fav){
		Map<String, Object> param = new HashMap<>();
		param.put("userNo", userNo);
		param.put("restaurantNo", restaurantNo);
		
		int result;
		if(fav) {
			result = favoriteRestaurantService.cancelFav(param);
		} else {
			result = favoriteRestaurantService.addFav(param);
		}
		
		log.debug("cancelResult = {}", result);
		
		return ResponseEntity.ok(result);
	}
	
	private boolean isAuthenticated() {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication == null || AnonymousAuthenticationToken.class.
	      isAssignableFrom(authentication.getClass())) {
	        return false;
	    }
	    return authentication.isAuthenticated();
	}
	
}
