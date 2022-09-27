package com.kh.eatwith.search.model.dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.common.TestMap;

@Mapper
public interface SearchDao {

	List<TestMap> selectGatherSearch(Map<String, Object> param);

	List<TestMap> selectReviewSearch(Map<String, Object> param);
	
	List<TestMap> selectRestaurantSearch(Map<String, Object> param);

	int getTotalGather(Map<String, Object> param);

	int getTotalReview(Map<String, Object> param);

	int getTotalRestaurant(Map<String, Object> param);
	
	int getTotalGatherPersonal(Map<String, Object> param);

	int getTotalReviewPersonal(Map<String, Object> param);

	int getTotalRestaurantPersonal(Map<String, Object> param);
	
	
	@Select("select * from district where code not in (9876543)")
	List<CustomMap> selectDistrictList();

	@Select("select * from food_type where code not in (999)")
	List<CustomMap> selectFoodTypeList();

	List<TestMap> selectReviewPersonal(Map<String, Object> param);

	List<TestMap> selectRestaurantPersonal(Map<String, Object> param);

	List<TestMap> selectGatherPersonal(Map<String, Object> param);
	
}
