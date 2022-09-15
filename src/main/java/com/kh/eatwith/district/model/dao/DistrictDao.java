package com.kh.eatwith.district.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.eatwith.district.model.dto.District;

@Mapper
public interface DistrictDao {

	@Select("select * from district order by name")
	List<District> getAllDistrict();

	@Select("select * from district where code = #{code}")
	District findNameByCode(String code);
	
}
