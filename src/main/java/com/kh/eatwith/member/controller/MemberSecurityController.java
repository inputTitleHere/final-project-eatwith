package com.kh.eatwith.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.member.model.service.MemberService;
import com.kh.eatwith.security.model.service.MemberSecurityService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberSecurityController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private MemberSecurityService memberSecurityService;
	/**
	 * BCryptPasswordEncoder의 약자.
	 * -백승윤-
	 */
	@Autowired
	private BCryptPasswordEncoder bcpe;
	
	@GetMapping("/memberEnroll")
	public void memberEnroll() {
		
	}
	
	@PostMapping("/memberEnroll")
	public String memberEnroll(Member member, @RequestParam(required = false) List<String> favDistrict, @RequestParam(required = false) List<String> favFoodType) {
		try {
			log.debug("member = {} ",member);
			if(favDistrict!=null) {
				member.setFavDistrict(favDistrict.toArray(new String[0]));
			}
			if(favFoodType!=null) {
				member.setFavFoodType(favFoodType.toArray(new String[0]));
			}
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
	
	@GetMapping("/checkDuplicateId")
	@ResponseBody
	public ResponseEntity<?> checkDuplicateId(@RequestParam String id){
		log.debug("check duplicate id = {} ",id);
		Member member = memberService.selectOneMember(id);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(member==null) {
			resultMap.put("result", true);
		}else {
			resultMap.put("result",	false);
		}
		return ResponseEntity.ok(resultMap);
	}
	
	@GetMapping("/checkDuplicateNickname")
	@ResponseBody
	public ResponseEntity<?> checkDuplicateNickname(@RequestParam String nickname){
		log.debug("check duplicate nickname = {} ",nickname);	
		Member member = memberService.selectOneByNickname(nickname);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(member==null) {
			resultMap.put("result", true);
		}else {
			resultMap.put("result",	false);
		}	
		return ResponseEntity.ok(resultMap);
	}
	
	
	@GetMapping("/memberLogin")
	public String memberLogin() {
		
		return "member/memberLogin";
	}
	
	@PostMapping("/memberLoginSuccess")
	public String memberLoginSuccess(HttpSession session) {
		log.debug("memberLoginSuccess 호출");
		// 로그인 후처리
		String location = "/";
		
		// security가 관리하는 리다이렉트 url
		SavedRequest savedRequest = (SavedRequest) session.getAttribute("SPRING_SAVED_SECURITY_REQUEST");
		if(savedRequest != null)
			location =  savedRequest.getRedirectUrl();
		log.debug("location = {}", location);
		
		return "redirect:" + location;
	}
	
	@GetMapping("/memberFind")
	public void memberFind(
			@RequestParam String name,
			@RequestParam String phone,
			@RequestParam String email,
			@RequestParam String id,
			Model model) {

		
	}
}
