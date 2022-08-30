package com.kh.eatwith.testing.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.eatwith.testing.model.dao.TestDao;
import com.kh.eatwith.testing.model.dto.TestTable;

@Service
public class TestServiceImpl implements TestService {

	@Autowired
	private TestDao testDao;
	
	@Override
	public TestTable getAll() {
		return testDao.getAll();
	}

}
