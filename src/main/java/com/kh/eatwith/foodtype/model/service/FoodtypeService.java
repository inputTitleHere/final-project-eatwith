package com.kh.eatwith.foodtype.model.service;

import java.util.List;

import com.kh.eatwith.foodtype.model.dto.FoodType;

public interface FoodtypeService {

	List<FoodType> getAllFoodtype();

	FoodType findTypeByCode(String code);

}
