package com.kh.eatwith.gather.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.eatwith.gather.model.dto.Gather;

@Mapper
public interface GatherDao {

	@Insert("insert all "
			+ "into gather values(seq_gather_no.nextval,#{restaurantNo},#{title},#{count},#{meetDate},#{foodCode},#{districtCode},#{content},#{userNo},#{ageRestrictionTop},#{ageRestrictionBottom},#{genderRestriction})"
			+ "into member_gather values(#{userNo},seq_gather_no.nextval,default) select*from dual")
	int gatherEnroll(Gather gather);

	@Select("select count(*) from gather")
	int getTotalContent();

	@Select("select * from gather order by no desc")
	List<Gather> selectGatherList(RowBounds rowBounds);

	@Select("select * from gather where no = #{no}")
	Gather selectOneGather(int no);
	

}
