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
	public Gather selectOneGather(int no) {
		return gatherDao.selectOneGather(no);
	}
	
	@Override
	public List<Map<String, Object>> getGatherList() {
		return gatherDao.getGatherList();
	}
	
	@Override
	public Map<String, Object> getOneGather(int no) {
		return gatherDao.getOneGather(no);
	}
	@Override
	public Map<String, Object> gatherUpdate() {
		return gatherDao.gatherUpdate();
	}
}
