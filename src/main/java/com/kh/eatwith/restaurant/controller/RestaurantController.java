package com.kh.eatwith.restaurant.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.restaurant.model.dto.Restaurant;
import com.kh.eatwith.restaurant.model.service.RestaurantService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/restaurant")
@Slf4j
public class RestaurantController {
	@Autowired
	RestaurantService restaurantService;
	
	@GetMapping("/findRestaurantByName")
	@ResponseBody
	public ResponseEntity<?> findRestaurantByName(@RequestParam String searchString){
		
		List<Restaurant> searchResult=restaurantService.findRestaurantByName(searchString);
		
		return ResponseEntity.ok(searchResult);
	}
	
}
