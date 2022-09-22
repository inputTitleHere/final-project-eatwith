package com.kh.eatwith.favorite.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.favorite.model.dto.FavoriteRestaurant;

public interface FavoriteRestaurantService {

	int checkFav(Map<String, Object> param);

	List<Integer> getUsersByRestaurantNo(String restaurantNo);
	
	int cancelFav(Map<String, Object> param);

	int addFav(Map<String, Object> param);

	int checkFavCount(String no);

	List<CustomMap> getFavoriteRestaurant(int no);


}
