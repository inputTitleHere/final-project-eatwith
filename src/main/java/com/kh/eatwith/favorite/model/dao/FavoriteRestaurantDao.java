package com.kh.eatwith.favorite.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.eatwith.favorite.model.dto.FavoriteRestaurant;

@Mapper
public interface FavoriteRestaurantDao {

	@Select("select * from favorite_restaurant where user_no = #{userNo} and restaurant_no = #{restaurantNo}")
	int checkFav(Map<String, Object> param);

	@Select("select user_no from favorite_restaurant where restaurant_no = #{restaurantNo}")
	List<Integer> getUsersByRestaurantNo(String restaurantNo);

	
}
