package com.kh.eatwith.member.model.service;

import java.util.List;
import java.util.Map;

import com.kh.eatwith.member.model.dto.Member;

public interface MemberService {

	int insertMember(Member member);

	Member selectOneMember(String id);

	Member selectOneByNickname(String id);

	Member findIdByInfo(Map<String, Object> map);

	Member findPasswordByInfo(Map<String, Object> map);

	int updatePasswordByReset(Map<String, Object> map);
	
	int insertFavDistrict(Map<String, Object> params);

	int insertFavFood(Map<String, Object> params);

	String selectOneNameByNo(int userNo);
}
