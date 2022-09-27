package com.kh.eatwith.mypage.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.district.model.dto.District;
import com.kh.eatwith.district.model.service.DistrictService;
import com.kh.eatwith.foodtype.model.dto.FoodType;
import com.kh.eatwith.foodtype.model.service.FoodtypeService;
import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.member.model.service.MemberService;
import com.kh.eatwith.mypage.model.service.MypageService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mypage")
public class MypageController {
	@Autowired
	MypageService mypageService;

	
	@Autowired
	MemberService memberService;
	
	@Autowired
	FoodtypeService foodTypeSerivce;
	
	@Autowired
	DistrictService districtService;
	
//	@GetMapping()
//	public String mypage(HttpServletResponse response) {
//		return "mypage/mypage";
//	}
	
	@GetMapping("/currentUser")
	@ResponseBody
	public ResponseEntity<?> currentUser(HttpServletRequest request){
		Cookie[] cookies = request.getCookies();
		int no = 0;
		for(Cookie c : cookies){
			if("no".equals(c.getName())) {
				no = Integer.parseInt(c.getValue());
				log.debug("COOKIE || NO : {}",no);
				break;
			}
		}
		
//		Object MemberObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		log.debug("@@@@@@@ MemberObj :{}",MemberObj);
//		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("no", ((MemberSecurity)MemberObj).getNo());
		
		Member result = memberService.selectOneByNo(no);
		if(result!=null){
			if(result.getFavDistrict()==null) {
				result.setFavDistrict(new String[0]);
			}
			if(result.getFavFoodType()==null) {
				result.setFavFoodType(new String[0]);
			}
			result.setPassword("");
		}else {
			result = new Member();
		}
		log.debug("@@Mypage Currmember : {}",result);			
		
//		response.addHeader("Access-Control-Allow-Origin", "*");
		return ResponseEntity.ok(result);
	}
	
	@GetMapping("/loadInfo")
	@ResponseBody
	public ResponseEntity<?> loadInfo(){
		List<FoodType> foodType = foodTypeSerivce.getAllFoodtype();
		List<District> district = districtService.getAllDistrict();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("foodType", foodType);
		result.put("district", district);
		
		return ResponseEntity.ok(result);
	}
	
	@GetMapping({"","/","/myfavs","/mygather","/enrolledGather","/userinfo","/password","/secede"})
	public String mypage() {
		return "mypage/mypage";
	}
	
	
}
