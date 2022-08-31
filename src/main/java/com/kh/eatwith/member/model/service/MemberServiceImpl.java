package com.kh.eatwith.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.eatwith.member.model.dao.MemberDao;
import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.security.model.dao.MemberSecurityDao;

@Service
@Transactional(rollbackFor = Exception.class)
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao memberDao;
	
	@Autowired
	MemberSecurityDao memberSecurityDao;
	
	@Override
	public int insertMember(Member member) {
		int result = memberSecurityDao.insertMember(member);
		result = memberDao.insertMember(member); 
		return result;
	}
	
	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}
}
