package com.kh.eatwith.member.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.eatwith.member.model.dto.Member;

@Mapper
public interface MemberDao {

	// mapper.xml에 배치
	int insertMember(Member member);

	Member selectOneMember(String id);

}
