package com.kh.eatwith.restaurant.model.service;

import java.util.List;

import com.kh.eatwith.restaurant.model.dto.Restaurant;

public interface RestaurantService {

	List<Restaurant> findRestaurantByName(String searchString);

	Restaurant selectOneRestaurant(String no);

}
