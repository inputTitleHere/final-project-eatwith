package com.kh.eatwith.review.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.session.RowBounds;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.review.model.dto.Attachment;
import com.kh.eatwith.review.model.dto.Review;
import com.kh.eatwith.review.model.dto.ReviewExt;

@Mapper
public interface ReviewDao {
	@Insert("insert into review values(seq_review_no.nextval,#{gatherNo},#{restaurantNo},#{overallScore},#{tasteScore},#{priceScore},#{serviceScore},#{content},#{userNo}) ")
	@SelectKey(
			statement="select seq_review_no.currval from dual",
			before=false,
			keyProperty="no",
			resultType=int.class
			)
	int insertReview(Review review);

//	@Select("select * from (select * from review r join member m on r.user_no = m.no) where restaurant_no = #{restaurantNo}")
	List<Review> selectOneReview(String no);
	
	List<Map<String, Object>> getBestReviews();

	List<ReviewExt> getNewestReviews(RowBounds rowBounds);

	Map<String, Object> writeReview(int gatherNo);

	@Insert("insert into review_image values(seq_review_image_no.nextval,#{restaurantNo},#{reviewNo},#{imageName})")
	int insertImage(Attachment image);

	@Select("select name from (select * from review r join member m on r.user_no = m.no) where user_no = #{userNo}")
	List<String> findName(int userNo);

	@Select("select * from review_image where restaurant_no = #{restaurantNo} order by no desc")
	List<Attachment> selectAttachByResNo(String no);

	@Delete("delete from review where user_no = #{userNo} and restaurant_no = #{restaurantNo}")
	List<Review> deleteReviewInRest(Map<String, Object> param);

}
