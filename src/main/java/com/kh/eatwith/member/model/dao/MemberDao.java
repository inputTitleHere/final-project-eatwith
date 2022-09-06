package com.kh.eatwith.member.model.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

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

}
