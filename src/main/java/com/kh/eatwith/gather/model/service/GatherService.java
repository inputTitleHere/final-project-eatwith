package com.kh.eatwith.gather.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.gather.model.dto.MemberGather;
import com.kh.eatwith.member.model.dto.Member;

public interface GatherService {

	int gatherEnroll(Gather gather);

	int getTotalContent();

	Gather selectOneGather(int no);

	List<Map<String, Object>> getGatherList();

	Map<String, Object> getOneGather(int no);

	Map<String, Object> selectOneGatherInfo(int no);

	int gatherUpdate(Gather gather);

	int gatherDelete(int no);

	int applyGather(int no, MemberGather memberGather, Member member);

}
