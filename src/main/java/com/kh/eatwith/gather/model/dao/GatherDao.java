package com.kh.eatwith.gather.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.eatwith.common.CustomMap;
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

	List<CustomMap> getNearClosure();
	
	List<Map<String, Object>> getGatherList();

	Map<String, Object> getOneGather(int no);
	
	@Select("select "
			+ "g.no,g.restaurant_no,r.name,g.title,g.count,g.meet_date,g.food_code,f.type,g.district_code,d.name as loca_name,g.content,g.user_no,g.age_restriction_top,g.age_restriction_bottom,g.gender_restriction"
			+ " from"
			+ " gather g join district d on g.district_code=d.code"
			+ " left join food_type f on g.food_code=f.code"
			+ " left join (select no,name from restaurant) r on g.restaurant_no=r.no"
			+ " where g.no=#{g.no}")
	Map<String, Object> selectOneGatherInfo(int no);
	
	@Update("update gather set title=#{title},count=#{count},meet_date=#{meetDate},content=#{content},age_restriction_top=#{ageRestrictionTop},age_restriction_bottom=#{ageRestrictionBottom},gender_restriction=#{genderRestriction} where no=#{no}")
	int gatherUpdate(Gather gather);

	@Delete("delete gather where no=#{no}")
	int gatherDelete(int no);
}
