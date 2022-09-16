package com.kh.eatwith.restaurant.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.eatwith.restaurant.model.dto.Restaurant;

@Mapper
public interface RestaurantDao {

	//@Select("select * from restaurant where name like '%'||#{searchString}||'%'")
	List<Restaurant> findRestaurantByName(String searchString);

	//@Select("select * from restaurant where no = #{no}")
	Restaurant selectOneRestaurant(String no);

	
	
	
}
