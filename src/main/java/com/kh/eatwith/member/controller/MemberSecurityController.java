package com.kh.eatwith.member.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.district.model.dto.District;
import com.kh.eatwith.district.model.service.DistrictService;
import com.kh.eatwith.foodtype.model.service.FoodtypeService;
import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.member.model.dto.MemberSecurity;
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
	private DistrictService districtService;
	
	@Autowired
	private FoodtypeService foodTypeService;
	
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

			log.debug("member = {} ",member);
			// 여기 member 테이블에 직접 저장하는 것을 fav계열 테이블로 변경
			if(favDistrict!=null) {
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

			// 위 코드를 실행하면 member객체에 no정보가 생성되어서 보관될 것이다.
			int no = member.getNo();
			Map<String, Object> params = null;
			if(favDistrict!=null) {
				params = new HashMap<String, Object>();
				params.put("no", no);
				params.put("favDistrict", favDistrict);
				result = memberService.insertFavDistrict(params);
			}
			if(favFoodType!=null) {
				params = new HashMap<String, Object>();
				params.put("no", no);
				params.put("favFood", favFoodType);
				result=memberService.insertFavFood(params);
			}
			
			
			
			log.debug("회원가입에 성공했습니다. : {}",member);
		}catch(Exception e) {
			log.error("회원 가입 오류 : "+e.getMessage(),e);
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
	public void memberLogin() {
		
	}
	
	@PostMapping("/memberLogin")
	public String memberLogin(
						@RequestParam String memberId, 
						@RequestParam String password,
						Model model,
						RedirectAttributes redirectAttr) {
		Member loginMember = memberService.selectOneMember(memberId);
		log.debug("member = {}", loginMember);
		
		String location = "/";
		if(loginMember == null || bcpe.matches(password, loginMember.getPassword())) {
			model.addAttribute("loginMember", null);
			redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다");
			location = "/member/memberLogin";
		}
		else {
			model.addAttribute("loginMember", loginMember);
			location = "/";
		}
		
		return "redirect:/" + location;
	}

	@PostMapping("/memberLoginSuccess")
	public String memberLoginSuccess(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		log.debug("memberLoginSuccess 호출");
		// 로그인 후처리
		String location = "/";
		
		MemberSecurity memberSecurity = (MemberSecurity)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Cookie cookie = new Cookie("no", String.valueOf(memberSecurity.getNo()));
		cookie.setPath("/eatwith");
		cookie.setHttpOnly(true);
//		cookie.setMaxAge(24*60*60); // 1일 // 아예 세션 쿠키로
		response.addCookie(cookie);
		
		for(Cookie c :  request.getCookies()) {
			log.debug("COOKIE Name = {}",c.getName());
			log.debug("COOKIE Value = {}",c.getValue());
		}
	
		// security가 관리하는 리다이렉트 url
		SavedRequest savedRequest = (SavedRequest) session.getAttribute("SPRING_SAVED_SECURITY_REQUEST");
		if (savedRequest != null)
			location = savedRequest.getRedirectUrl();
		log.debug("location = {}", location);

		return "redirect:" + location;
	}
	
	@PostMapping("/memberQuit")
	public String memberQuit(@CookieValue(value="no")Cookie cookie) {
		int userNo = Integer.parseInt(cookie.getValue());
		int result = memberService.memberQuit(userNo);
		SecurityContextHolder.clearContext();
		return "redirect:/";
	}
	
	
	@GetMapping("/memberFind")
	public void memberFind() {
		
	}
	
	@PostMapping("/memberFind")
	public String memberFind(Model model) {
		
		return "redirect:member/memberFind";
	}
	
	@GetMapping("/memberFindId")
	public String memberFindId(String name, String phone) {
		Map<String, Object> map = new HashMap<>();
		map.put("name", name);
		map.put("phone", phone);
		Member member = memberService.findIdByInfo(map);
		return "member/memberFind";
	}

	@GetMapping("/memberFindById")
	@ResponseBody
	public ResponseEntity<?> memberFindById(@RequestParam String name, @RequestParam String phone) {
		Map<String, Object> map = new HashMap<>();
		map.put("name", name);
		map.put("phone", phone);

		log.debug("아이디 찾기 실행");
		Member member = memberService.findIdByInfo(map);
		log.debug("member = {}", member);
		return ResponseEntity.ok(member);
	}
			 
	@GetMapping("/memberResetPw")
	public String memberResetPw(String id, String name, String email) {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("name", name);
		map.put("email", email);
		
		Member member = memberService.findPasswordByInfo(map);
		return "member/memberFind";
	}

	@GetMapping("/memberResetPassword")
	@ResponseBody
	public ResponseEntity<?> memberResetPassword(@RequestParam String id, @RequestParam String name, @RequestParam String email) {
		log.debug("비밀번호 초기화 실행");
		String code = randomPassword(8); // 난수처리된 비밀번호
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("name", name);
		map.put("email", email);
		map.put("code", code);
		
		Member member = memberService.findPasswordByInfo(map);
		log.debug("password = {}", code);
		log.debug("member = {}", member);

		// 비번 암호화
		String encodePwd = bcpe.encode(code);
		member.setPassword(code);
		
		map.put("code", encodePwd);
		int result = memberService.updatePasswordByReset(map);
		log.debug("password = {}", encodePwd);

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
		System.out.println("sb = " + sb);
		return sb.toString();
	}
	
	/**
	 * 멤버 정보 업데이트
	 *  @RequestBody List<String> favDistrict, @RequestBody List<String> favFoodType
	 */
	@PutMapping("/updateMember")
	@ResponseBody
	public ResponseEntity<?> updateMember(@RequestBody Member member) throws Exception{
		log.debug("member = {}",member);
		
		int result = memberService.updateMember(member);
		// 기존 fav 
		List<String> originalFavDistrict = districtService.getFavedByNo(member.getNo());
		List<String> originalFavFoodType = foodTypeService.getFavedByNo(member.getNo());
		
		// 새로운 fav
		
		// 지울거, 새로 넣을거 구분
		Map<String, Object> params = null;
		if(member.getFavDistrict()!=null) {
			List<String> favDistrict = new ArrayList<String>(Arrays.asList(member.getFavDistrict()));
			for(String code : member.getFavDistrict()) {
				if(originalFavDistrict.contains(code)) {
					originalFavDistrict.remove(code);
					favDistrict.remove(code);
				}
			}
			if(favDistrict.size()>0) {
				params = new HashMap<String, Object>();
				params.put("no",member.getNo());
				params.put("favDistrict",favDistrict);
				result = memberService.insertFavDistrict(params);				
			}
		}
		if(member.getFavFoodType()!=null) {
			List<String> favFoodType = new ArrayList<String>(Arrays.asList(member.getFavFoodType()));
			log.debug("favFood = {} ",favFoodType);
			for(String code : member.getFavFoodType()) {
				if(originalFavFoodType.contains(code)) {
					originalFavDistrict.remove(code);
					favFoodType.remove(code);
				}
			}
			if(favFoodType.size()>0) {
				params = new HashMap<String, Object>();
				params.put("no",member.getNo());
				params.put("favFood",favFoodType);
				result = memberService.insertFavFood(params);				
			}
		}
		// 체크 해제 데이터 삭제
		log.debug("Originals DISTRICT = {} FOODTYPE = {}",originalFavDistrict, originalFavFoodType);
		params=new HashMap<String, Object>();
		params.put("no",member.getNo());
		params.put("favDistrict", originalFavDistrict);
		params.put("favFood", originalFavFoodType);
		result = memberService.removeFav(params);
		
		
		return ResponseEntity.ok(result);
	}
	
	
	@GetMapping("/checkPassword")
	@ResponseBody
	public ResponseEntity<?> checkPassword(@RequestParam int no, @RequestParam String password){
		log.debug("no = {}, Password = {}",no,password);
		Member member = memberService.selectOneByNo(no);
		boolean result = bcpe.matches(password, member.getPassword());
		
		return ResponseEntity.ok(result);
	}
	
	@GetMapping("/checkPasswordCookie")
	@ResponseBody
	public ResponseEntity<?> checkPasswordCookie(@RequestParam String oldPassword, HttpServletRequest request){
		log.debug("oldPassword={}",oldPassword);
		Cookie[] cookies = request.getCookies();
		int no=0;
		for(Cookie c : cookies){
			if("no".equals(c.getName())) {
				no = Integer.parseInt(c.getValue());
				log.debug("COOKIE || NO : {}",no);
				break;
			}
		}
		Member member = memberService.selectOneByNo(no);
		log.debug("encrypted = {}",member.getPassword());
		log.debug("bcpe.matches = {}",bcpe.matches(oldPassword, member.getPassword()));
		if(bcpe.matches(oldPassword, member.getPassword())) {
			return ResponseEntity.ok(true);
		}
		return ResponseEntity.ok(false);
	}
	@PutMapping("/updatePassword")
	@ResponseBody
	public ResponseEntity<?> updatePassword(@RequestBody Member member,HttpServletRequest request){
		Cookie[] cookies = request.getCookies();
		int no=0;
		for(Cookie c : cookies){
			if("no".equals(c.getName())) {
				no = Integer.parseInt(c.getValue());
				log.debug("COOKIE || NO : {}",no);
				break;
			}
		}
		String password = member.getPassword();
		log.debug("newPassword = {} ",password);
		String encoded = bcpe.encode(password);
		CustomMap param = new CustomMap();
		param.put("no", no);
		param.put("password",encoded);
		int result = memberService.updatePassword(param);		
		
		return ResponseEntity.ok(null);
	}
	
	@GetMapping("/testResetPassword")
	public ResponseEntity<?> testResetPassword(){
		CustomMap param = new CustomMap();
		param.put("no", 144);
		param.put("password", bcpe.encode("qq11``"));
		int result = memberService.updatePassword(param);
		return ResponseEntity.ok(null);
	}
	
	

}