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
	
	@Override
	public int cancelFav(Map<String, Object> param) {
		return favoriteFoodDao.cancelFav(param);
	}
	
	@Override
	public int addFav(Map<String, Object> param) {
		return favoriteFoodDao.addFav(param);
	}
	
	@Override
	public int checkFavCount(String no) {
		return favoriteFoodDao.checkFavCount(no);
	}
}
