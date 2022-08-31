package com.kh.eatwith.member.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.eatwith.member.model.dto.Member;

@Mapper
public interface MemberDao {

	Member selectOneMember(String id);

}
