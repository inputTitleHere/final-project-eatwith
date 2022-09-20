package com.kh.eatwith.favorite.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.favorite.model.dto.FavoriteRestaurant;

public interface FavoriteRestaurantService {

	int checkFav(Map<String, Object> param);

	List<Integer> getUsersByRestaurantNo(String restaurantNo);


}
