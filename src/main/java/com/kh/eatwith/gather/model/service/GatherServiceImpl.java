package com.kh.eatwith.gather.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.eatwith.gather.model.dao.GatherDao;

@Service
public class GatherServiceImpl implements GatherService{
	@Autowired
	GatherDao gatherDao;
}
