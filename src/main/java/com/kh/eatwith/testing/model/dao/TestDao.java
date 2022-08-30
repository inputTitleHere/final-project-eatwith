package com.kh.eatwith.testing.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.eatwith.testing.model.dto.TestTable;

@Mapper
public interface TestDao {

	@Select("select * from tester_table")
	TestTable getAll();

}
