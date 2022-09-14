package com.kh.eatwith.review.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.eatwith.review.model.dao.ReviewDao;
import com.kh.eatwith.review.model.dto.Attachment;
import com.kh.eatwith.review.model.dto.Review;
import com.kh.eatwith.review.model.dto.ReviewExt;



@Service
@Transactional(rollbackFor = Exception.class)
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	ReviewDao reviewDao;
	
	@Override
	public int insertReview(Review review) {
		int result = reviewDao.insertReview(review);
		List<Attachment> images = review.getAttachments();
		if(images!=null) {
		for(Attachment image:images) {
			image.setReviewNo(review.getNo());
			image.setRestaurantNo(review.getRestaurantNo());
			
			result=reviewDao.insertImage(image);
		}}
		
		return result;
	}
	@Override
	public List<Map<String, Object>> getBestReviews() {
		return reviewDao.getBestReviews();
	}
	
	@Override
	public List<ReviewExt> getNewestReviews(Map<String, Integer> param) {
		int limit = param.get("limit");
		int currItem = (param.get("currPage")-1)*limit; 
		RowBounds rowBounds = new RowBounds(currItem, limit);
		
		return reviewDao.getNewestReviews(rowBounds);
	}
	
	@Override
	public Map<String, Object> writeReview(int gatherNo) {
		return reviewDao.writeReview(gatherNo);
	}


}
