package com.kh.eatwith.search.controller;

import java.lang.reflect.Array;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.common.TestMap;
import com.kh.eatwith.common.typehandler.EatWithUtils;
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
	
//	@GetMapping("/searchResult")
//	public void searchGather(Model model) {
//		Map<String, Integer> param = new HashMap();
//		
//		List<Gather> resultGather = searchService.selectGatherSearch(param);
//		log.debug("resultGather = {}", resultGather);
//		model.addAttribute("resultGather", resultGather);
//		
//		
//	}
	
//	@GetMapping("/searchResult")
//	public void searchGather() {
//		
//	}


//	@GetMapping("/searchResult")
//	@ResponseBody
//	public ResponseEntity<?> searchResult(@RequestParam("searchWord") String searchWord, @RequestParam("searchWord") String searchType, Model model) {
//		
//		log.debug("searchWord = {}", searchWord);
//		Map<String,Object> param = new HashMap<String,Object>();
//		param.put("searchWord", searchWord);
//		List<CustomMap> resultGather = searchService.selectGatherSearch(param);		
//		List<CustomMap> resultReview = searchService.selectReviewSearch(param);
//		List<TestMap> resultRestaurant = searchService.selectRestaurantSearch(param);
//		
//		model.addAttribute("resultGather", resultGather);
//		model.addAttribute("resultReview", resultReview);
//		model.addAttribute("resultRestaurant", resultRestaurant);
//		log.debug("resultGather = {}", resultGather);
//		log.debug("resultGather = {}", resultReview);
//		log.debug("resultGather = {}", resultRestaurant);
//		
//		return ResponseEntity.ok(model);
//	}

	
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
		
		// 지역,음식타입 버튼 변수 값 받아오기 시작
		List<CustomMap> districtList = searchService.selectDistrictList();
		List<CustomMap> foodTypeList = searchService.selectFoodTypeList();
		
		model.addAttribute("districtList", districtList);
		model.addAttribute("foodTypeList", foodTypeList);
	// 음식 타입 버튼 변수 값 받아오기 끝
	}
	
	
	@GetMapping("/searchDetailReview")
	public void searchDetailReview(@RequestParam HashMap<String,Object> paramMap, Model model, HttpServletRequest request) {
		
	// 공통 선택
		String[] districtCodeList = request.getParameterValues("districtCode");
		String[] foodTypeCodeList = request.getParameterValues("foodTypeCode");

		String districtCode = String.join(",", districtCodeList);
		log.debug("test = {}",districtCode);
		String foodTypeCode = String.join(",", foodTypeCodeList);
		log.debug("test = {}",foodTypeCode);
		
			// 리뷰 선택시
			String overallScore = (String) paramMap.get("overallScore");
			String tasteScore = (String) paramMap.get("tasteScore");
			String priceScore = (String) paramMap.get("priceScore");
			String serviceScore = (String) paramMap.get("serviceScore");

			String keyword = (String) paramMap.get("keyword");

//			int cPage = Integer.parseInt(String.valueOf(paramMap.get("cPage")));

			Map<String,Object> param = new HashMap<String,Object>();
			
//			int limit = 10;
//			param.put("cPage", cPage);
//			param.put("limit", limit);
			
			param.put("overallScore", overallScore);
			param.put("tasteScore", tasteScore);
			param.put("priceScore", priceScore);
			param.put("serviceScore", serviceScore);
	
			param.put("keyword", keyword);
			
//			Map<String, Integer> paramInt = new HashedMap();
//			
//			int limit = 10;
//			paramInt.put("cPage", cPage);
//			paramInt.put("limit", limit);
			
			List<TestMap> resultSearchReview = searchService.selectReviewPersonal(param);
			int totalContent = searchService.getTotalReviewPersonal(param);

			model.addAttribute("resultSearchReview", resultSearchReview);
			model.addAttribute("totalContent", totalContent);
			model.addAttribute("districtCode", districtCode);
			model.addAttribute("foodTypeCode", foodTypeCode);

		// 지역,음식타입 버튼 변수 값 받아오기 시작
			List<CustomMap> districtList = searchService.selectDistrictList();
			List<CustomMap> foodTypeList = searchService.selectFoodTypeList();
			
			model.addAttribute("districtList", districtList);
			model.addAttribute("foodTypeList", foodTypeList);
		// 음식 타입 버튼 변수 값 받아오기 끝

			log.debug("districtCode = {}",districtCode);
			log.debug("foodTypeCode = {}",foodTypeCode);
			
			
			//페이지 바
//			log.debug("totalContent = {}", totalContent);
//			String urlEntity = request.getRequestURI();			
//			String url = urlEntity + "?foodTypeCode=001&foodTypeCode=002&foodTypeCode=003&foodTypeCode=004&foodTypeCode=005"
//					+ "&foodTypeCode=006&foodTypeCode=007&foodTypeCode=008&foodTypeCode=009&foodTypeCode=010&foodTypeCode=011"
//					+ "&districtCode=3220000&districtCode=3240000&districtCode=3080000&districtCode=3150000&districtCode=3200000"
//					+ "&districtCode=3040000&districtCode=3160000&districtCode=3170000&districtCode=3100000&districtCode=3090000"
//					+ "&districtCode=3050000&districtCode=3190000&districtCode=3130000&districtCode=3120000&districtCode=3210000"
//					+ "&districtCode=3030000&districtCode=3070000&districtCode=3230000&districtCode=3140000&districtCode=3180000"
//					+ "&districtCode=3020000&districtCode=3110000&districtCode=3000000&districtCode=3010000&districtCode=3060000"
//					+ "&overallScore=" + overallScore + "&tasteScore=" + tasteScore + "&priceScore=" + priceScore + "&serviceScore="
//					+ serviceScore + "&keyword=" + keyword;
//			log.debug("url = {}", url);
//			String pagebar = EatWithUtils.getPagebarTest(cPage, limit, totalContent, url);
//			model.addAttribute("pagebar", pagebar);	
	}

	
	
	@GetMapping("/searchDetailGather")
	public void searchDetailGather(@RequestParam HashMap<String,Object> paramMap, Model model, HttpServletRequest request) {
		
		// 공통 선택
		String[] districtCodeList = request.getParameterValues("districtCode");
		String[] foodTypeCodeList = request.getParameterValues("foodTypeCode");

		String districtCode = String.join(",", districtCodeList);
		String foodTypeCode = String.join(",", foodTypeCodeList);
		log.debug("districtCode = {}",districtCode);
		log.debug("foodTypeCode = {}",foodTypeCode);
		
		// 모임 선택 시
		String meetDateMin = (String) paramMap.get("meetDateMin");
		String meetDateMax = (String) paramMap.get("meetDateMax");
		String genderRestriction = (String) paramMap.get("genderRestriction");
		String ageRestrictionBottom = (String) paramMap.get("ageRestrictionBottom");
		String ageRestrictionTop = (String) paramMap.get("ageRestrictionTop");
		String count = (String) paramMap.get("count");
		
		// 검색어
		String keyword = (String) paramMap.get("keyword");
		
//		int cPage = Integer.parseInt(String.valueOf(paramMap.get("cPage")));
		
		// 담기
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

		// 지역,음식타입 버튼 변수 값 받아오기 시작
			List<CustomMap> districtList = searchService.selectDistrictList();
			List<CustomMap> foodTypeList = searchService.selectFoodTypeList();
			
			model.addAttribute("districtList", districtList);
			model.addAttribute("foodTypeList", foodTypeList);
		// 음식 타입 버튼 변수 값 받아오기 끝
		
//			Map<String, Integer> paramInt = new HashedMap();
//			
//			int limit = 10;
//			paramInt.put("cPage", cPage);
//			paramInt.put("limit", limit);		
//			
//		log.debug("totalContent = {}", totalContent);
//		String urlEntity = request.getRequestURI();			
//		String url = urlEntity + "?foodTypeCode=001&foodTypeCode=002&foodTypeCode=003&foodTypeCode=004&foodTypeCode=005"
//				+ "&foodTypeCode=006&foodTypeCode=007&foodTypeCode=008&foodTypeCode=009&foodTypeCode=010&foodTypeCode=011"
//				+ "&districtCode=3220000&districtCode=3240000&districtCode=3080000&districtCode=3150000&districtCode=3200000"
//				+ "&districtCode=3040000&districtCode=3160000&districtCode=3170000&districtCode=3100000&districtCode=3090000"
//				+ "&districtCode=3050000&districtCode=3190000&districtCode=3130000&districtCode=3120000&districtCode=3210000"
//				+ "&districtCode=3030000&districtCode=3070000&districtCode=3230000&districtCode=3140000&districtCode=3180000"
//				+ "&districtCode=3020000&districtCode=3110000&districtCode=3000000&districtCode=3010000&districtCode=3060000"
//				+ "&ageRestrictionBottom=" + ageRestrictionBottom + "&ageRestrictionTop=" + ageRestrictionTop + "&count=" + count
//				+ "&meetDateMin=" + meetDateMin + "&meetDateMax=" + meetDateMax + "&genderRestriction=" + genderRestriction 
//				+ "&keyword=" + keyword;
//		log.debug("url = {}", url);
//		String pagebar = EatWithUtils.getPagebarTest(cPage, limit, totalContent, url);
//		model.addAttribute("pagebar", pagebar);	
	}
	
	
	@GetMapping("/searchDetailRestaurant")
	public void searchDetailRestaurant(@RequestParam HashMap<String,Object> paramMap, Model model, HttpServletRequest request) {
		
		// 공통 선택
		String[] districtCodeList = request.getParameterValues("districtCode");
		String[] foodTypeCodeList = request.getParameterValues("foodTypeCode");

		String districtCode = String.join(",", districtCodeList);
		String foodTypeCode = String.join(",", foodTypeCodeList);
		log.debug("districtCode = {}",districtCode);
		log.debug("foodTypeCode = {}",foodTypeCode);

		// 식당 선택
		String overallScore = (String) paramMap.get("overallScore");
		String tasteScore = (String) paramMap.get("tasteScore");
		String priceScore = (String) paramMap.get("priceScore");
		String serviceScore = (String) paramMap.get("serviceScore");
		
		// 검색어
		String keyword = (String) paramMap.get("keyword");
		
//		int cPage = Integer.parseInt(String.valueOf(paramMap.get("cPage")));
		
		// 담기
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

				// 지역,음식타입 버튼 변수 값 받아오기 시작
					List<CustomMap> districtList = searchService.selectDistrictList();
					List<CustomMap> foodTypeList = searchService.selectFoodTypeList();
					
					model.addAttribute("districtList", districtList);
					model.addAttribute("foodTypeList", foodTypeList);
				// 음식 타입 버튼 변수 값 받아오기 끝
				
					
//			Map<String, Integer> paramInt = new HashedMap();
//			
//			int limit = 10;
//			paramInt.put("cPage", cPage);
//			paramInt.put("limit", limit);		
//			
//		log.debug("totalContent = {}", totalContent);
//		String urlEntity = request.getRequestURI();			
//		String url = urlEntity + "?foodTypeCode=001&foodTypeCode=002&foodTypeCode=003&foodTypeCode=004&foodTypeCode=005"
//				+ "&foodTypeCode=006&foodTypeCode=007&foodTypeCode=008&foodTypeCode=009&foodTypeCode=010&foodTypeCode=011"
//				+ "&districtCode=3220000&districtCode=3240000&districtCode=3080000&districtCode=3150000&districtCode=3200000"
//				+ "&districtCode=3040000&districtCode=3160000&districtCode=3170000&districtCode=3100000&districtCode=3090000"
//				+ "&districtCode=3050000&districtCode=3190000&districtCode=3130000&districtCode=3120000&districtCode=3210000"
//				+ "&districtCode=3030000&districtCode=3070000&districtCode=3230000&districtCode=3140000&districtCode=3180000"
//				+ "&districtCode=3020000&districtCode=3110000&districtCode=3000000&districtCode=3010000&districtCode=3060000"
//				+ "&overallScore=" + overallScore + "&tasteScore=" + tasteScore + "&priceScore=" + priceScore + "&serviceScore="
//				+ serviceScore + "&keyword=" + keyword;
//		log.debug("url = {}", url);
//		String pagebar = EatWithUtils.getPagebarTest(cPage, limit, totalContent, url);
//		model.addAttribute("pagebar", pagebar);	
	}
	
	
	
	
//	@GetMapping("/searchDetailReview")
//	public void searchDetailReview(@RequestParam HashMap<String,Object> paramMap, Model model, HttpServletRequest request) {
//		
//	// 공통 선택
//		String[] districtCodeList = request.getParameterValues("districtCode");
//		String[] foodTypeCodeList = request.getParameterValues("foodTypeCode");
//
//		String districtCode = String.join(",", districtCodeList);
//		log.debug("test = {}",districtCode);
//		String foodTypeCode = String.join(",", foodTypeCodeList);
//		log.debug("test = {}",foodTypeCode);
//		
//		String dataType = (String) paramMap.get("dataType");
//		
////		if (dataType.equals("review")) {
////			// 리뷰 선택시
////			String overallScore = (String) paramMap.get("overallScore");
////			String tasteScore = (String) paramMap.get("tasteScore");
////			String priceScore = (String) paramMap.get("priceScore");
////			String serviceScore = (String) paramMap.get("serviceScore");
////
////			Map<String,Object> param = new HashMap<String,Object>();
////			
////			
////			param.put("overallScore", overallScore);
////			param.put("tasteScore", tasteScore);
////			param.put("priceScore", priceScore);
////			param.put("serviceScore", serviceScore);
////			
////			String keyword = (String) paramMap.get("keyword");
////			
////			param.put("keyword", keyword);
////			
////			List<TestMap> resultSearchReview = searchService.selectReviewPersonal(param);
////
////			model.addAttribute("resultSearchReview", resultSearchReview);
////			model.addAttribute("districtCode", districtCode);
////			model.addAttribute("foodTypeCode", foodTypeCode);
////			
////		}else if(dataType.equals("gather")) {
////			// 모임 선택 시
////			String ageRestrictionBottom = (String) paramMap.get("ageRestrictionBottom");
////			String ageRestrictionTop = (String) paramMap.get("ageRestrictionTop");
////			String count = (String) paramMap.get("count");
////			
////			Map<String,Object> param = new HashMap<String,Object>();
////			
////			param.put("ageRestrictionBottom", ageRestrictionBottom);
////			param.put("ageRestrictionTop", ageRestrictionTop);
////			param.put("count", count);
////		
////			String keyword = (String) paramMap.get("keyword");
////			
////			param.put("keyword", keyword);
////			
////			List<TestMap> resultSearchGather = searchService.selectGatherPersonal(param);
////			
////			model.addAttribute("resultSearchGather", resultSearchGather);
////			model.addAttribute("districtCode", districtCode);
////			model.addAttribute("foodTypeCode", foodTypeCode);
////		}else {
////			
////			Map<String,Object> param = new HashMap<String,Object>();
////			
////			String keyword = (String) paramMap.get("keyword");
////			param.put("keyword", keyword);
////			
////			List<TestMap> resultSearchRestaurant = searchService.selectRestaurantPersonal(param);
////			
////			model.addAttribute("resultSearchRestaurant", resultSearchRestaurant);
////			model.addAttribute("districtCode", districtCode);
////			model.addAttribute("foodTypeCode", foodTypeCode);
////		}
////		
////
//////		String meetDateMin = (String) paramMap.get("meetDateMin");
//////		String meetDateMax = (String) paramMap.get("meetDateMax");
//////		String genderRestriction = (String) paramMap.get("genderRestriction");
//////		param.put("meetDateMin", meetDateMin);
//////		param.put("meetDateMax", meetDateMax);
//////		param.put("genderRestriction", genderRestriction);
////
////
//		// 지역,음식타입 버튼 변수 값 받아오기 시작
//			List<CustomMap> districtList = searchService.selectDistrictList();
//			List<CustomMap> foodTypeList = searchService.selectFoodTypeList();
//			
//			model.addAttribute("districtList", districtList);
//			model.addAttribute("foodTypeList", foodTypeList);
//		// 음식 타입 버튼 변수 값 받아오기 끝
//	
//			log.debug("districtCode = {}",districtCode);
//			log.debug("foodTypeCode = {}",foodTypeCode);
//	}

	

//
//

//	
//	
	
}
