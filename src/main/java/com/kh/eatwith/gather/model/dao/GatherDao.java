package com.kh.eatwith.gather.model.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.kh.eatwith.gather.model.dto.Gather;

@Mapper
public interface GatherDao {

	@Insert("insert into gather values(seq_gather_no.nextval,#{restaurantNo},#{gatherTitle},#{gatherCount},#{gatherTime},#{foodCode},#{districtCode},#{gatherContent},#{userNo},#{gatherMax},#{gatherMin},#{gatherGender})")
	int gatherEnroll(Gather gather);

}
