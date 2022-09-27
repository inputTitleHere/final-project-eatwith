package com.kh.eatwith.search.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.eatwith.search.model.dao.SearchDao;
import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.common.TestMap;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class SearchServiceImpl implements SearchService {

	@Autowired
	SearchDao searchDao;

	@Override
	public List<TestMap> selectGatherSearch(Map<String, Object> param) {
		return searchDao.selectGatherSearch(param);
	}

	@Override
	public List<TestMap> selectReviewSearch(Map<String, Object> param) {
		return searchDao.selectReviewSearch(param);
	}

	@Override
	public List<TestMap> selectRestaurantSearch(Map<String, Object> param) {
		return searchDao.selectRestaurantSearch(param);
	}

	@Override
	public int getTotalGather(Map<String, Object> param) {
		return searchDao.getTotalGather(param);
	}

	@Override
	public int getTotalReview(Map<String, Object> param) {
		return searchDao.getTotalReview(param);
	}

	@Override
	public int getTotalRestaurant(Map<String, Object> param) {
		return searchDao.getTotalRestaurant(param);
	}

//	@Override
//	public List<CustomMap> selectGatherTest(Map<String, Object> param) {
//		return searchDao.selectGatherTest(param);
//	}
//
//	@Override
//	public List<CustomMap> selectReviewTest(Map<String, Object> param) {
//		return searchDao.selectReviewTest(param);
//	}
//
//	@Override
//	public List<TestMap> selectRestaurantTest(Map<String, Object> param) {
//		return searchDao.selectRestaurantTest(param);
//	}

	@Override
	public List<CustomMap> selectDistrictList() {
		return searchDao.selectDistrictList();
	}

	@Override
	public List<CustomMap> selectFoodTypeList() {
		return searchDao.selectFoodTypeList();
	}

	@Override
	public List<TestMap> selectGatherPersonal(Map<String, Object> param) {
		return searchDao.selectGatherPersonal(param);
	}

	@Override
	public List<TestMap> selectRestaurantPersonal(Map<String, Object> param) {
		return searchDao.selectRestaurantPersonal(param);
	}

	@Override
	public List<TestMap> selectReviewPersonal(Map<String, Object> param) {
		return searchDao.selectReviewPersonal(param);
	}

	@Override
	public int getTotalReviewPersonal(Map<String, Object> param) {
		return searchDao.getTotalReviewPersonal(param);
	}

	@Override
	public int getTotalGatherPersonal(Map<String, Object> param) {
		return searchDao.getTotalGatherPersonal(param);
	}

	@Override
	public int getTotalRestaurantPersonal(Map<String, Object> param) {
		return searchDao.getTotalRestaurantPersonal(param);
	}

//	@Override
//	public List<Gather> selectGatherSearch(Map<String, Integer> param) {
//		return searchDao.selectGatherSearch(param);
//	}



}
