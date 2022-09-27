package com.kh.eatwith.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.eatwith.admin.model.dto.VisitantCount;
import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.common.TestMap;
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.notice.model.dto.Notice;
import com.kh.eatwith.review.model.dto.Review;

@Mapper
public interface AdminDao {

	List<TestMap> selectRestaurant();

	List<TestMap> selectGather();

	List<TestMap> selectMember();

	int selectGatherTo();

	int selectGatherYes();

	int selectGatherNow();

	List<TestMap> selectGatherRatio();
}
