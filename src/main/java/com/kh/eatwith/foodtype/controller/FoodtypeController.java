package com.kh.eatwith.foodtype.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.eatwith.foodtype.model.dto.FoodType;
import com.kh.eatwith.foodtype.model.service.FoodtypeService;

@Controller
@RequestMapping("/foodtype")
public class FoodtypeController {
	
	@Autowired
	FoodtypeService foodtypeService;
	
	@GetMapping("/getAllFoodtype")
	public ResponseEntity<?> getAllFoodtype(){
		
		List<FoodType> resultList = foodtypeService.getAllFoodtype();
		
		return ResponseEntity.ok(resultList);
	}
	
}
