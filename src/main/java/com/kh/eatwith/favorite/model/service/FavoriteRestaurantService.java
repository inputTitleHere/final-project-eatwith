package com.kh.eatwith.favorite.model.service;

import java.util.Map;

import com.kh.eatwith.favorite.model.dto.FavoriteRestaurant;

public interface FavoriteRestaurantService {

	int checkFav(Map<String, Object> param);

	int cancelFav(Map<String, Object> param);

	int addFav(Map<String, Object> param);

	int checkFavCount(String no);


}
