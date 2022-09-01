package com.kh.eatwith.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	/**
	 * BCryptPasswordEncoder의 약자.
	 * -백승윤-
	 */
	@Autowired
	private BCryptPasswordEncoder bcpe;
	
	@GetMapping("/memberEnroll")
	public void memberEnroll() {
		// memberEnroll.jsp으로 보내자.
	}
	
	@PostMapping("/memberEnroll")
	public String memberEnroll(Member member) {
		try {
			log.debug("member = {} ",member);
			// 비번 암호화
			String rawPwd = member.getPassword();
			String encodePwd = bcpe.encode(rawPwd);
			member.setPassword(encodePwd);
			log.debug("encodedPassword : {}",encodePwd);
			
			int result = memberService.insertMember(member);
			log.debug("회원가입에 성공했습니다. : {}",member);
		}catch(Exception e) {
			log.error("회원 가입 오류 : "+e.getMessage(),e);
			throw e;
		}
		return "redirect:/";
	}
	
	
}
