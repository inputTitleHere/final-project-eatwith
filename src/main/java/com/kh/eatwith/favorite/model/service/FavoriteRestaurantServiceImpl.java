package com.kh.eatwith.favorite.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.eatwith.favorite.model.dao.FavoriteRestaurantDao;
import com.kh.eatwith.favorite.model.dto.FavoriteRestaurant;

@Service
public class FavoriteRestaurantServiceImpl implements FavoriteRestaurantService {

	@Autowired
	FavoriteRestaurantDao favoriteRestaurantDao;
	
	@Override
	public int checkFav(Map<String, Object> param) {
		return favoriteRestaurantDao.checkFav(param);
	}
	@Override
	public List<Integer> getUsersByRestaurantNo(String restaurantNo) {
		return favoriteRestaurantDao.getUsersByRestaurantNo(restaurantNo);
	}
}
