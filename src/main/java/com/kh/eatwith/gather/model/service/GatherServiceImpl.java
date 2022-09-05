package com.kh.eatwith.gather.model.service;

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
}
