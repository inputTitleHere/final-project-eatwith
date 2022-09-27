package com.kh.eatwith.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.member.model.dto.Member;

@Mapper
public interface MemberDao {

	// mapper.xml에 배치
	@Insert("insert into member values( seq_member_no.nextval,#{id},#{name},#{password},#{email},#{phone},sysdate,default,default,#{bornAt},#{gender},null,#{favDistrict},#{favFoodType})")
	@SelectKey(
		statement = "select seq_member_no.currval from dual", 
		before = false, 
		keyProperty = "no", 
		resultType = int.class
	)
	int insertMember(Member member);

	Member selectOneMember(String id);

	@Select("select * from member where name=#{nickname}")
	Member selectOneByNickname(String nickname);

	@Select("select * from member where name = #{name} and phone = #{phone}")
	Member findIdByInfo(Map<String, Object> map);

	@Select("select * from member where id = #{id} and name = #{name} and email = #{email}")
	Member findPasswordByInfo(Map<String, Object> map);

	@Update("update member set password = #{code} where id = #{id} and name = #{name} and email = #{email}")
	int updatePasswordByReset(Map<String, Object> map);

	int insertFavDistrict(Map<String, Object> params);
	
	int insertFavFood(Map<String, Object> params);

	@Select("select * from member where no=#{no}")
	Member selectOneByNo(int no);

	
	int updateMember(Member member);

	int removeFavDistrict(Map<String, Object> params);

	int removeFavFood(Map<String, Object> params);

	@Update("update member set password=#{password} where no=#{no}")
	int updatePassword(CustomMap param);
	
	@Select("select m.name from review r join member m on r.user_no = m.no where r.user_no = #{userNo}")
	String selectOneNameByNo(int userNo);

	@Update("update member set deleted_at = sysdate where no=#{userNo}")
	int memberQuit(int userNo);

	@Select("select * from member id=#{id} and password = #{password}")
	Member login(Map<String, Object> param);

	@Select("select no from member where name = #{name}")
	int selectNoByName(String name);
	
	
}
