package com.kh.eatwith.gather.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
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

	@Select("select * from gather where no = #{no}")
	Gather selectOneGather(int no);

	List<Map<String, Object>> getGatherList();

	Map<String, Object> getOneGather(int no);

	@Update("update gather set title=#{title},count=#{count},meet_date=sysdate,content=#{content},age_restriction_top=#{ageRestrictionTop},age_restriction_bottom=#{ageRestrictionBottom},gender_restriction=#{genderRestriction} where no=#{no}")
	Map<String, Object> gatherUpdate();
}
