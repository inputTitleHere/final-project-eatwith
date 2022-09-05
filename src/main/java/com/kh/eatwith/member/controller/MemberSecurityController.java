package com.kh.eatwith.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
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
	 * BCryptPasswordEncoder의 약자. -백승윤-
	 */
	@Autowired
	private BCryptPasswordEncoder bcpe;

	@GetMapping("/memberEnroll")
	public void memberEnroll() {

	}

	@PostMapping("/memberEnroll")
	public String memberEnroll(Member member, @RequestParam(required = false) List<String> favDistrict,
			@RequestParam(required = false) List<String> favFoodType) {
		try {
			log.debug("member = {} ", member);
			if (favDistrict != null) {
				member.setFavDistrict(favDistrict.toArray(new String[0]));
			}
			if (favFoodType != null) {
				member.setFavFoodType(favFoodType.toArray(new String[0]));
			}
			// 비번 암호화
			String rawPwd = member.getPassword();
			String encodePwd = bcpe.encode(rawPwd);
			member.setPassword(encodePwd);
			log.debug("encodedPassword : {}", encodePwd);

			int result = memberService.insertMember(member);
			log.debug("회원가입에 성공했습니다. : {}", member);
		} catch (Exception e) {
			log.error("회원 가입 오류 : " + e.getMessage(), e);
			throw e;
		}
		return "redirect:/";
	}

	@GetMapping("/checkDuplicateId")
	@ResponseBody
	public ResponseEntity<?> checkDuplicateId(@RequestParam String id) {
		log.debug("check duplicate id = {} ", id);
		Member member = memberService.selectOneMember(id);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (member == null) {
			resultMap.put("result", true);
		} else {
			resultMap.put("result", false);
		}
		return ResponseEntity.ok(resultMap);
	}

	@GetMapping("/checkDuplicateNickname")
	@ResponseBody
	public ResponseEntity<?> checkDuplicateNickname(@RequestParam String nickname) {
		log.debug("check duplicate nickname = {} ", nickname);
		Member member = memberService.selectOneByNickname(nickname);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (member == null) {
			resultMap.put("result", true);
		} else {
			resultMap.put("result", false);
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
		if (savedRequest != null)
			location = savedRequest.getRedirectUrl();
		log.debug("location = {}", location);

		return "redirect:" + location;
	}

	@GetMapping("/memberFindId")
	public String memberFind(String name, String phone) {
		Map<String, Object> map = new HashMap<>();
		map.put("name", name);
		map.put("phone", phone);
		Member member = memberService.findIdByInfo(map);
		return "member/memberFind";
	}

	@GetMapping("/memberFindById")
	@ResponseBody
	public ResponseEntity<?> memberFindId(@RequestParam String name, @RequestParam String phone) {
		Map<String, Object> map = new HashMap<>();
		map.put("name", name);
		map.put("phone", phone);

		log.debug("아이디 찾기 실행");
		Member member = memberService.findIdByInfo(map);
		log.debug("member = {}", member);
		return ResponseEntity.ok(member);
	}
			 
	@GetMapping("/memberResetPw")
	public String memberReset(String id, String name, String email) {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("name", name);
		map.put("email", email);
		
		Member member = memberService.resetPasswordByInfo(map);
		return "member/memberFind";
	}

	@GetMapping("/memberResetPassword")
	@ResponseBody
	public ResponseEntity<?> memberResetPassword(@RequestParam String id, @RequestParam String name, @RequestParam String email) {
		log.debug("비밀번호 초기화 실행");
		String code = randomPassword(8);
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("name2", name);
		map.put("email", email);
		map.put("password", code);
		
		Member member = memberService.resetPasswordByInfo(map);
		log.debug("password = {}", code);
		log.debug("member = {}", member);
		
		return ResponseEntity.ok(member);
	}

	/**
	 * 비밀번호 알파벳(대소문자)+숫자 랜덤 값 생성
	 */
	public static String randomPassword(int length) {

		int index = 0;

		char[] charset = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
				'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a',
				'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
				'w', 'x', 'y', 'z' };
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			index = (int) (charset.length * Math.random());
			sb.append(charset[index]);
		}
		return sb.toString();
	}

}