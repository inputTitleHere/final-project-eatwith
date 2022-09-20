package com.kh.eatwith.foodtype.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.eatwith.foodtype.model.dto.FoodType;

@Mapper
public interface FoodtypeDao {

	@Select("select * from food_type order by code")
	List<FoodType> getAllFoodtype();

	@Select("select * from food_type where code = #{code}")
	FoodType findTypeByCode(String code);

	@Select("select code from favorite_food where no=#{no}")
	List<String> getFavedByNo(int no);

}
