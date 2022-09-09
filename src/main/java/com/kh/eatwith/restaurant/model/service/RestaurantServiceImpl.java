package com.kh.eatwith.restaurant.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.eatwith.restaurant.model.dao.RestaurantDao;
import com.kh.eatwith.restaurant.model.dto.Restaurant;

@Service
@Transactional(rollbackFor=Exception.class)
public class RestaurantServiceImpl implements RestaurantService {
	@Autowired
	RestaurantDao restaurantDao;
	
	@Override
	public List<Restaurant> findRestaurantByName(String searchString) {
		return restaurantDao.findRestaurantByName(searchString);
	}
	
//	@Override
//	public List<Restaurant> selectOneRestaurant(String no) {
//		return restaurantDao.selectOneRestaurant(no);
//	}
	
	@Override
	public Restaurant selectOneRestaurant(String no) {
		return restaurantDao.selectOneRestaurant(no);
	}
}
