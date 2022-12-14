package com.kh.eatwith.foodtype.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.eatwith.foodtype.model.dao.FoodtypeDao;
import com.kh.eatwith.foodtype.model.dto.FoodType;

@Service
public class FoodtypeSerivceImpl implements FoodtypeService {
	@Autowired
	FoodtypeDao foodtypeDao;
	
	@Override
	public List<FoodType> getAllFoodtype() {
		return foodtypeDao.getAllFoodtype();
	}
	
	@Override
	public FoodType findTypeByCode(String code) {
		return foodtypeDao.findTypeByCode(code);
	}
	@Override
	public List<String> getFavedByNo(int no) {
		return foodtypeDao.getFavedByNo(no);
	}
}
