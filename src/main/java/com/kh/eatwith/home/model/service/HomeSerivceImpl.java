package com.kh.eatwith.home.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.eatwith.home.model.dao.HomeDao;

@Service
public class HomeSerivceImpl implements HomeService {

	@Autowired
	HomeDao homeDao;
	
}
