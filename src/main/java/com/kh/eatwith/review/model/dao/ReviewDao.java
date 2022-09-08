package com.kh.eatwith.review.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.eatwith.review.model.dto.Review;

@Mapper
public interface ReviewDao {

	int insertReview(Review review);

	List<Map<String, Object>> getBestReviews();

}
