package com.kh.eatwith.review.model.service;

import java.util.List;
import java.util.Map;


import com.kh.eatwith.review.model.dto.Review;

public interface ReviewService {

	int insertReview(Review review);

	List<Review> selectOneReview(String no);

	List<Map<String, Object>> getBestReviews();

}
