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
import com.kh.eatwith.gather.model.dto.MemberGather;
import com.kh.eatwith.member.model.dto.Member;

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

	@Insert("insert into member_gather (user_no,gather_no,enroll_at) "
			+ "select #{loginMember},#{gatherNo},sysdate from dual "
			+ "where not exists(select user_no,gather_no from member_gather where user_no=#{loginMember} and gather_no=#{gatherNo})")
	int applyGather(Map<String,Object> param);

	@Select("select count(*) as count from member_gather where gather_no=#{gatherNo}")
	int countGatherMem(int no);

	@Delete("delete from member_gather where user_no=#{loginMember} and gather_no=#{gatherNo}")
	int cancelGather(Map<String, Object> param);

	@Select("select * from member_gather where user_no=#{loginMember} and gather_no=#{gatherNo}")
	Integer chkGatherIn(Map<String, Object> param);

	@Select("select * from member where no=#{no}")
	Member getMemberNo(String loginId);

	@Select("select * from gather where restaurant_no = #{restaurantNo}")
	List<Gather> selectReviewByRestaurantNo(String no);

	List<CustomMap> getNewestGatherings(Map<String, Object> params);

	@Select("select * from gather where food_code=#{checkFood}")
	int checkFood(int checkFood);

	List<Gather> getGatherByLocation(CustomMap param);

	List<Map<String, Object>> gatherMore(int page);

	//@Select("select count(*) as count from member_gather where gather_no=#{no} and user_no=#{loginMember}")

}
