package com.kh.eatwith.security.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.member.model.dto.MemberSecurity;
import com.kh.eatwith.security.model.dao.MemberSecurityDao;


@Service
public class MemberSecurityService implements UserDetailsService {

	@Autowired
	MemberSecurityDao memberSecurityDao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberSecurity memberSecurity = memberSecurityDao.loadUserByUsername(username);
		if(memberSecurity == null) {
			throw new UsernameNotFoundException(username);
		}
		return memberSecurity;
	}


}
