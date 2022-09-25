package com.kh.eatwith.gather.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.gather.model.dto.MemberGather;
import com.kh.eatwith.member.model.dto.Member;

public interface GatherService {

	int gatherEnroll(Gather gather);

	int getTotalContent();

	Gather selectOneGather(int no);

	List<CustomMap> getNearClosure();
	
	List<Map<String, Object>> getGatherList();

	Map<String, Object> getOneGather(int no);

	Map<String, Object> selectOneGatherInfo(int no);

	int gatherUpdate(Gather gather);

	int gatherDelete(int no);

	int applyGather(Map<String,Object> param);

	int countGatherMem(int no);

	int cancelGather(Map<String, Object> param);

	Integer chkGatherIn(Map<String, Object> param);

	Member getMemberNo(String loginId);

	List<Gather> selectReviewByRestaurantNo(String restaurantNo);

	List<CustomMap> getNewestGatherings(Map<String, Object> params);

	List<Gather> checkFood(int checkFood);

	List<Map<String, Object>> getGatherByLocation(CustomMap param);

	List<Map<String, Object>> gatherMore(int startNum);

	List<Map<String, Object>> getLatestList();

	List<Map<String, Object>> checkLeader(int gatherNo);

	int checkLeaderIn(Map<String, Object> param);

	int checkLeaderOut(Map<String, Object> param);

}
