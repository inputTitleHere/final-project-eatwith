package com.kh.eatwith.review.model.dao;

import java.util.List;
import java.util.Map;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.eatwith.review.model.dto.Review;
import com.kh.eatwith.review.model.dto.ReviewExt;

@Mapper
public interface ReviewDao {

	int insertReview(Review review);

	@Select("select * from review where restaurant_no = #{restaurant_no}")
	List<Review> selectOneReview(String no);
	
	List<Map<String, Object>> getBestReviews();

	List<ReviewExt> getNewestReviews(RowBounds rowBounds);

	Map<String, Object> writeReview(int gatherNo);

}
