package com.kh.eatwith.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.eatwith.member.model.dao.MemberDao;
import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.security.model.dao.MemberSecurityDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao memberDao;
	
	@Autowired
	MemberSecurityDao memberSecurityDao;
	
	@Override
	public int insertMember(Member member) {
		int result = memberDao.insertMember(member); 
		log.debug("@memberService - member = {}",member);
		result = memberSecurityDao.insertMember(member);
		return result;
	}
	
	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}

	@Override
	public Member selectOneByNickname(String nickname) {
		return memberDao.selectOneByNickname(nickname);
	}
	
	@Override
	public Member findIdByInfo(Map<String, Object> map) {
		return memberDao.findIdByInfo(map);
	}
	
	@Override
	public Member findPasswordByInfo(Map<String, Object> map) {
		return memberDao.findPasswordByInfo(map);
	}
	
	@Override
	public int updatePasswordByReset(Map<String, Object> map) {
		return memberDao.updatePasswordByReset(map);
	}

	@Override
	public int insertFavDistrict(Map<String, Object> params) {
		return memberDao.insertFavDistrict(params);
	}
	@Override
	public int insertFavFood(Map<String, Object> params) {
		return memberDao.insertFavFood(params);
	}
	
	@Override
	public String selectOneNameByNo(int userNo) {
		return memberDao.selectOneNameByNo(userNo);
	}
}
