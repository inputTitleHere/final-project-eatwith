package com.kh.eatwith.district.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.eatwith.district.model.dao.DistrictDao;
import com.kh.eatwith.district.model.dto.District;

@Service
public class DistrictServiceImpl implements DistrictService {
	@Autowired
	DistrictDao districtDao;
	
	@Override
	public List<District> getAllDistrict() {
		return districtDao.getAllDistrict();
	}
	
	@Override
	public District findNameByCode(String code) {
		return districtDao.findNameByCode(code);
	}
	@Override
	public List<String> getFavedByNo(int no) {
		return districtDao.getFavedByNo(no);
	}
	
}
