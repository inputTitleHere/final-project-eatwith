package com.kh.eatwith.review.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.review.model.dto.Review;
import com.kh.eatwith.review.model.dto.ReviewExt;

public interface ReviewService {

	int insertReview(Review review);

	List<Map<String, Object>> getBestReviews();

	List<ReviewExt> getNewestReviews(Map<String, Integer> param);

	Map<String, Object> writeReview(int gatherNo);

}
