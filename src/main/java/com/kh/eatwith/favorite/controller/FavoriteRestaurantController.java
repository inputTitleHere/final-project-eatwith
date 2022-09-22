package com.kh.eatwith.favorite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.favorite.model.dto.FavoriteRestaurant;
import com.kh.eatwith.favorite.model.service.FavoriteRestaurantService;
import com.kh.eatwith.member.model.dto.MemberSecurity;

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
	
	@GetMapping("/getFavoriteRestaurant")
	public ResponseEntity<?> getFavoriteRestaurant(@CookieValue(value = "no")Cookie userNo){
//		Object MemberObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		int no = ((MemberSecurity)MemberObj).getNo();
		int no = Integer.parseInt(userNo.getValue());
		log.debug("FavRest : no = {}",no);
		List<CustomMap> result = favoriteRestaurantService.getFavoriteRestaurant(no);
		 
		log.debug("FavRest : result = {}",result);
		
		return ResponseEntity.ok(result);
	}
	
	
	
	
	
}
