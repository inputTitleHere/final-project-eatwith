package com.kh.eatwith.district.model.service;

import java.util.List;

import com.kh.eatwith.district.model.dto.District;

public interface DistrictService {

	List<District> getAllDistrict();

	District findNameByCode(String code);

	List<String> getFavedByNo(int no);


}
