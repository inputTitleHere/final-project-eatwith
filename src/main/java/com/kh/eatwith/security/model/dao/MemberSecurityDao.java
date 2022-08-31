package com.kh.eatwith.security.model.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.kh.eatwith.member.model.dto.Member;

@Mapper
public interface MemberSecurityDao {

	/**
	 * 기본적으로 Authority테이블을 서버를 통해 가입하는 회원은 모두 유저이다.
	 * ADMIN계정은 SQL으로 넣도록 합니다.
	 * 
	 */
	@Insert("insert into authority values('ROLE_USER',#{no})")
	int insertMember(Member member);
	
	
	
}
