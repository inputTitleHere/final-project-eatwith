package com.kh.eatwith.favorite.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.favorite.model.dto.FavoriteRestaurant;
import com.kh.eatwith.favorite.model.service.FavoriteRestaurantService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/favoriteRestaurant")
@Slf4j
public class FavoriteRestaurantController {

	@Autowired
	FavoriteRestaurantService favoriteRestaurantService;
	
//	@GetMapping("/{restaurantNo}")
//	@ResponseBody
//	public ResponseEntity<?> like(@RequestParam int userNo, @RequestParam String restaurantNo){
//		Map<String, Object> param = new HashMap<>();
//		param.put("userNo", userNo);
//		param.put("restaurantNo", restaurantNo);
//		
//		int result = favoriteRestaurantService.like(param);
//		return ResponseEntity.ok(result);
//	}
}
