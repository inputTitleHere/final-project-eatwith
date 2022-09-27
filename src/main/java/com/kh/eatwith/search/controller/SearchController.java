package com.kh.eatwith.search.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.common.TestMap;
import com.kh.eatwith.search.model.service.SearchService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/search")
public class SearchController {
	
	@Autowired
	ServletContext application;
	
	@Autowired
	ResourceLoader resourceLoader;

	@Autowired
	private SearchService searchService;

	
	@GetMapping("/searchResult")
	public void searchResult(@RequestParam HashMap<String,String> paramMap, Model model) {
		
		String searchWord = paramMap.get("searchWord");
		String searchType = paramMap.get("searchType");
		log.debug("searchWord = {}", searchWord);
		log.debug("searchType = {}", searchType);
		
		int typeCheck;
		
		if (searchType.equals("recent")) {
			typeCheck = 1;
		}
		else {
			typeCheck = 2;
		}
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("searchWord", searchWord);
		param.put("typeCheck", typeCheck);
		List<TestMap> resultGather = searchService.selectGatherSearch(param);		
		List<TestMap> resultReview = searchService.selectReviewSearch(param);
		List<TestMap> resultRestaurant = searchService.selectRestaurantSearch(param);
		
		int totalGather = searchService.getTotalGather(param);
		int totalReview = searchService.getTotalReview(param);
		int totalRestaurant = searchService.getTotalRestaurant(param);
		
		model.addAttribute("resultGather", resultGather);
		model.addAttribute("resultReview", resultReview);
		model.addAttribute("resultRestaurant", resultRestaurant);

		model.addAttribute("totalGather", totalGather);
		model.addAttribute("totalReview", totalReview);
		model.addAttribute("totalRestaurant", totalRestaurant);		
		
		log.debug("resultGather = {}", resultGather);
		log.debug("resultReview = {}", resultReview);
		log.debug("resultRestaurant = {}", resultRestaurant);
		
		List<CustomMap> districtList = searchService.selectDistrictList();
		List<CustomMap> foodTypeList = searchService.selectFoodTypeList();
		
		model.addAttribute("districtList", districtList);
		model.addAttribute("foodTypeList", foodTypeList);
	}
	
	
	@GetMapping("/searchDetailReview")
	public void searchDetailReview(@RequestParam HashMap<String,Object> paramMap, Model model, HttpServletRequest request) {
		
		String[] districtCodeList = request.getParameterValues("districtCode");
		String[] foodTypeCodeList = request.getParameterValues("foodTypeCode");

		String districtCode = String.join(",", districtCodeList);
		log.debug("test = {}",districtCode);
		String foodTypeCode = String.join(",", foodTypeCodeList);
		log.debug("test = {}",foodTypeCode);
		
			String overallScore = (String) paramMap.get("overallScore");
			String tasteScore = (String) paramMap.get("tasteScore");
			String priceScore = (String) paramMap.get("priceScore");
			String serviceScore = (String) paramMap.get("serviceScore");

			String keyword = (String) paramMap.get("keyword");


			Map<String,Object> param = new HashMap<String,Object>();
		
			
			param.put("overallScore", overallScore);
			param.put("tasteScore", tasteScore);
			param.put("priceScore", priceScore);
			param.put("serviceScore", serviceScore);
	
			param.put("keyword", keyword);
			
			List<TestMap> resultSearchReview = searchService.selectReviewPersonal(param);
			int totalContent = searchService.getTotalReviewPersonal(param);

			model.addAttribute("resultSearchReview", resultSearchReview);
			model.addAttribute("totalContent", totalContent);
			model.addAttribute("districtCode", districtCode);
			model.addAttribute("foodTypeCode", foodTypeCode);

			List<CustomMap> districtList = searchService.selectDistrictList();
			List<CustomMap> foodTypeList = searchService.selectFoodTypeList();
			
			model.addAttribute("districtList", districtList);
			model.addAttribute("foodTypeList", foodTypeList);

			log.debug("districtCode = {}",districtCode);
			log.debug("foodTypeCode = {}",foodTypeCode);
			
	}

	
	
	@GetMapping("/searchDetailGather")
	public void searchDetailGather(@RequestParam HashMap<String,Object> paramMap, Model model, HttpServletRequest request) {
		
		String[] districtCodeList = request.getParameterValues("districtCode");
		String[] foodTypeCodeList = request.getParameterValues("foodTypeCode");

		String districtCode = String.join(",", districtCodeList);
		String foodTypeCode = String.join(",", foodTypeCodeList);
		log.debug("districtCode = {}",districtCode);
		log.debug("foodTypeCode = {}",foodTypeCode);
		
		String meetDateMin = (String) paramMap.get("meetDateMin");
		String meetDateMax = (String) paramMap.get("meetDateMax");
		String genderRestriction = (String) paramMap.get("genderRestriction");
		String ageRestrictionBottom = (String) paramMap.get("ageRestrictionBottom");
		String ageRestrictionTop = (String) paramMap.get("ageRestrictionTop");
		String count = (String) paramMap.get("count");
		
		String keyword = (String) paramMap.get("keyword");
				
		Map<String,Object> param = new HashMap<String,Object>();

		param.put("meetDateMin", meetDateMin);
		param.put("meetDateMax", meetDateMax);
		param.put("genderRestriction", genderRestriction);
		param.put("ageRestrictionBottom", ageRestrictionBottom);
		param.put("ageRestrictionTop", ageRestrictionTop);
		param.put("count", count);

		param.put("keyword", keyword);
		
		List<TestMap> resultSearchGather = searchService.selectGatherPersonal(param);
		int totalContent = searchService.getTotalGatherPersonal(param);
		
		model.addAttribute("resultSearchGather", resultSearchGather);
		model.addAttribute("totalContent", totalContent);
		log.debug("resultSearchGather = {}",resultSearchGather);
		
		model.addAttribute("districtCode", districtCode);
		model.addAttribute("foodTypeCode", foodTypeCode);

			List<CustomMap> districtList = searchService.selectDistrictList();
			List<CustomMap> foodTypeList = searchService.selectFoodTypeList();
			
			model.addAttribute("districtList", districtList);
			model.addAttribute("foodTypeList", foodTypeList);
	}
	
	
	@GetMapping("/searchDetailRestaurant")
	public void searchDetailRestaurant(@RequestParam HashMap<String,Object> paramMap, Model model, HttpServletRequest request) {
		
		String[] districtCodeList = request.getParameterValues("districtCode");
		String[] foodTypeCodeList = request.getParameterValues("foodTypeCode");

		String districtCode = String.join(",", districtCodeList);
		String foodTypeCode = String.join(",", foodTypeCodeList);
		log.debug("districtCode = {}",districtCode);
		log.debug("foodTypeCode = {}",foodTypeCode);

		String overallScore = (String) paramMap.get("overallScore");
		String tasteScore = (String) paramMap.get("tasteScore");
		String priceScore = (String) paramMap.get("priceScore");
		String serviceScore = (String) paramMap.get("serviceScore");
		
		String keyword = (String) paramMap.get("keyword");
		
		Map<String,Object> param = new HashMap<String,Object>();
		
		param.put("overallScore", overallScore);
		param.put("tasteScore", tasteScore);
		param.put("priceScore", priceScore);
		param.put("serviceScore", serviceScore);
		param.put("keyword", keyword);
				

		List<TestMap> resultSearchRestaurant = searchService.selectRestaurantPersonal(param);
		int totalContent = searchService.getTotalRestaurantPersonal(param);
		model.addAttribute("resultSearchRestaurant", resultSearchRestaurant);
		model.addAttribute("totalContent", totalContent);
		
		model.addAttribute("districtCode", districtCode);
		model.addAttribute("foodTypeCode", foodTypeCode);
		log.debug("resultSearchRestaurant = {}",resultSearchRestaurant);
	
		List<CustomMap> districtList = searchService.selectDistrictList();
		List<CustomMap> foodTypeList = searchService.selectFoodTypeList();
		
		model.addAttribute("districtList", districtList);
		model.addAttribute("foodTypeList", foodTypeList);
	}
	
	
}
