package com.kh.eatwith.search.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.common.TestMap;
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.notice.model.dto.Notice;
import com.kh.eatwith.restaurant.model.dto.Restaurant;
import com.kh.eatwith.review.model.dto.Review;

public interface SearchService {

//	List<Gather> selectGatherSearch(Map<String, Integer> param);

	// 일반 검색
		List<TestMap> selectGatherSearch(Map<String, Object> param);
	
		List<TestMap> selectReviewSearch(Map<String, Object> param);
	
		List<TestMap> selectRestaurantSearch(Map<String, Object> param);
	
		int getTotalGather(Map<String, Object> param);
	
		int getTotalReview(Map<String, Object> param);
	
		int getTotalRestaurant(Map<String, Object> param);
	
	

//	List<CustomMap> selectGatherTest(Map<String, Object> param);
//
//	List<CustomMap> selectReviewTest(Map<String, Object> param);
//
//	List<TestMap> selectRestaurantTest(Map<String, Object> param);
//
//		
	// 상세 검색(1) : 필터 데이터
		List<CustomMap> selectDistrictList();
	
		List<CustomMap> selectFoodTypeList();
		
	// 상세 검색(2) : 결과 데이터
		List<TestMap> selectGatherPersonal(Map<String, Object> param);
	
		List<TestMap> selectRestaurantPersonal(Map<String, Object> param);
	
		List<TestMap> selectReviewPersonal(Map<String, Object> param);

		int getTotalReviewPersonal(Map<String, Object> param);

		int getTotalGatherPersonal(Map<String, Object> param);

		int getTotalRestaurantPersonal(Map<String, Object> param);
	
}
