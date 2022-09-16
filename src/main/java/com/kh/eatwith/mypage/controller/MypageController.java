package com.kh.eatwith.mypage.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.cookie;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.member.model.service.MemberService;
import com.kh.eatwith.mypage.model.service.MypageService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mypage")
@CrossOrigin(origins = "*")
public class MypageController {
	@Autowired
	MypageService mypageService;
	
	@Autowired
	MemberService memberService;
	
	@GetMapping()
	public String mypage(HttpServletResponse response) {
		return "mypage/mypage";
	}
	
	@GetMapping("/currentUser")
	public ResponseEntity<?> currentUser(HttpServletRequest request){
		Cookie[] cookies = request.getCookies();
		int no = 0;
		for(Cookie c : cookies){
			if("no".equals(c.getName())) {
				no = Integer.parseInt(c.getValue());
				log.debug("COOKIE || NO : {}",no);
			}
		}
		
//		Object MemberObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		log.debug("@@@@@@@ MemberObj :{}",MemberObj);
//		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("no", ((MemberSecurity)MemberObj).getNo());
		
		Member result = memberService.selectOneByNo(no);
		log.debug("@@Mypage Currmember : {}",result);
		return ResponseEntity.ok(result);
	}
	
	
	
}
