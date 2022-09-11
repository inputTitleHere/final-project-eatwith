package com.kh.eatwith.gather.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.gather.model.dto.Gather;

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

}
