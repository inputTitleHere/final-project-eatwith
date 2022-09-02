package com.kh.eatwith.review.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.eatwith.review.model.dto.Review;

@Mapper
public interface ReviewDao {

	int insertReview(Review review);

}
