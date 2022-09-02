package com.kh.eatwith.district.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.district.model.dto.District;
import com.kh.eatwith.district.model.service.DistrictService;

@Controller
@RequestMapping("/district")
public class DistrictController {
	@Autowired
	DistrictService districtService;
	
	@GetMapping("/getAllDistrict")
	@ResponseBody
	public ResponseEntity<?> getAllDistrict(){
		List<District> districts = districtService.getAllDistrict();
		
		return ResponseEntity.ok(districts);
	}
	
}
