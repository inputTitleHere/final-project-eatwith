package com.kh.eatwith.member.model.service;

import java.util.Map;

import com.kh.eatwith.member.model.dto.Member;

public interface MemberService {

	int insertMember(Member member);

	Member selectOneMember(String id);

	Member selectOneByNickname(String id);

	Member findIdByInfo(Map<String, Object> map);

	Member resetPasswordByInfo(Map<String, Object> map);
	
}
