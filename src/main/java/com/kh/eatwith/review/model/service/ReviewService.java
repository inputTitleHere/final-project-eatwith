package com.kh.eatwith.review.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.review.model.dto.Attachment;
import com.kh.eatwith.review.model.dto.Review;
import com.kh.eatwith.review.model.dto.ReviewExt;

public interface ReviewService {

	int insertReview(Review review);

	List<Review> selectOneReview(String no);

	List<Map<String, Object>> getBestReviews();

	List<ReviewExt> getNewestReviews(Map<String, Integer> param);

	Map<String, Object> writeReview(int gatherNo);

	List<String> findName(int userNo);

	List<Attachment> selectAttachByResNo(String no);

}
