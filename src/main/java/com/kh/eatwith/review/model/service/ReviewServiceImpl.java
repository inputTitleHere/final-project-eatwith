package com.kh.eatwith.review.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.eatwith.review.model.dao.ReviewDao;
import com.kh.eatwith.review.model.dto.Review;



@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	ReviewDao reviewDao;
	
	@Override
	public int insertReview(Review review) {
		int result = reviewDao.insertReview(review);
		return result;
	}

	@Override
	public List<Review> selectOneReview(String no) {
		return reviewDao.selectOneReview(no);
	}

}
