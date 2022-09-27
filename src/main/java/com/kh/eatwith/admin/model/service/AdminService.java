package com.kh.eatwith.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.common.TestMap;
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.notice.model.dto.Notice;
import com.kh.eatwith.review.model.dto.Review;

public interface AdminService {

	List<TestMap> selectRestaurant();

	List<TestMap> selectGather();

	List<TestMap> selectMember();

	int selectGatherYes();

	int selectGatherTo();

	int selectGatherNow();

	List<TestMap> selectGatherRatio();

	
}
