package com.kh.eatwith.gather.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.eatwith.gather.model.dao.GatherDao;
import com.kh.eatwith.gather.model.dto.Gather;

@Service
public class GatherServiceImpl implements GatherService{
	@Autowired
	GatherDao gatherDao;
	
	@Override
	public int gatherEnroll(Gather gather) {
		return gatherDao.gatherEnroll(gather);
	}
	
	@Override
	public int getTotalContent() {
		return gatherDao.getTotalContent();
	}
	
	@Override
	public List<Gather> selectGatherList(Map<String, Integer> param) {
		int limit = param.get("limit");
		int offset = (param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return gatherDao.selectGatherList(rowBounds);
	}
	@Override
	public Gather selectOneGather(int no) {
		return gatherDao.selectOneGather(no);
	}
}
