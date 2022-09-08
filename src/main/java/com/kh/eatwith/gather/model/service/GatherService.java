package com.kh.eatwith.gather.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.gather.model.dto.Gather;

public interface GatherService {

	int gatherEnroll(Gather gather);

	int getTotalContent();

	Gather selectOneGather(int no);

	List<Map<String, Object>> getGatherList();

	Map<String, Object> getOneGather(int no);

	Map<String, Object> gatherUpdate();

}
