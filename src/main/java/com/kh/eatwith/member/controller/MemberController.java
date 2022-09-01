package com.kh.eatwith.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
@SessionAttributes({"loginMember"}) // model에 저장하고 여기에 저장된 이름을 사용하면, 세션에 저장됨.
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
	public String memberEnroll(Member member, Model model) {
		try {
			log.debug("member = {} ",member);
			// 비번 암호화
			String rawPwd = member.getPassword();
			String encodePwd = bcpe.encode(rawPwd);
			member.setPassword(encodePwd);
			log.debug("encodedPassword : {}",encodePwd);
			
			int result = memberService.insertMember(member);
			log.debug("회원가입에 성공했습니다. : {}",member);
			model.addAttribute("member",member);
		}catch(Exception e) {
			log.error("회원 가입 오류 : "+e.getMessage(),e);
			throw e;
		}
		return "redirect:/";
	}
	
	@GetMapping("/memberLogin")
	public void memberLogin() {
		
	}
	
	@PostMapping("/memberLogin")
	public String memberLogin(
			@RequestParam String id, 
			@RequestParam String password,
			RedirectAttributes redirectAttr,
			Model model) {
		
		Member member = memberService.selectOneMember(id);
		
		String location = "/";
		if(member != null && bcpe.matches(password, member.getPassword())) {
			model.addAttribute("loginMember", member);
		} else {
			redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			location = "/member/memberLogin.do";
		}
		
		return "redirect:" + location;
	}
	
	@GetMapping("/memberLogout")
	public String memberLogout(SessionStatus sessionStatus) {
		// @SessionAttributes와 짝꿍
		if(!sessionStatus.isComplete())
			sessionStatus.setComplete();
		
		return "redirect:/";
	}
	
}
