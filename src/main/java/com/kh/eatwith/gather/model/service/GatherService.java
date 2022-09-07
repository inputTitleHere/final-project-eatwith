package com.kh.eatwith.gather.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.gather.model.dto.Gather;

public interface GatherService {

	int gatherEnroll(Gather gather);

	List<Gather> selectGatherList(Map<String, Integer> param);

	int getTotalContent();

	Gather selectOneGather(int no);

}
