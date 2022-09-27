package com.kh.eatwith.search.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.common.TestMap;
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.restaurant.model.dto.Restaurant;
import com.kh.eatwith.review.model.dto.Review;

@Mapper
public interface SearchDao {

//	@Select("select * from gather order by no asc fetch first 3 rows only")
//	List<Gather> selectGatherSearch(Map<String, Integer> param);

	List<TestMap> selectGatherSearch(Map<String, Object> param);

	List<TestMap> selectReviewSearch(Map<String, Object> param);
	
	List<TestMap> selectRestaurantSearch(Map<String, Object> param);

	int getTotalGather(Map<String, Object> param);

	int getTotalReview(Map<String, Object> param);

	int getTotalRestaurant(Map<String, Object> param);

//	@Select("select * from gather")
//	List<CustomMap> selectGatherTest(Map<String, Object> param);
//	
//	@Select("select * from review")
//	List<CustomMap> selectReviewTest(Map<String, Object> param);
//	
//	@Select("select * from Restaurant")
//	List<TestMap> selectRestaurantTest(Map<String, Object> param);
	
	
	
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
