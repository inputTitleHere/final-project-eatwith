package com.kh.eatwith.favorite.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.eatwith.favorite.model.dao.FavoriteRestaurantDao;
import com.kh.eatwith.favorite.model.dto.FavoriteRestaurant;

@Service
public class FavoriteRestaurantServiceImpl implements FavoriteRestaurantService {

	@Autowired
	FavoriteRestaurantDao favoriteFoodDao;
	
	@Override
	public int checkFav(Map<String, Object> param) {
		return favoriteFoodDao.checkFav(param);
	}
}
