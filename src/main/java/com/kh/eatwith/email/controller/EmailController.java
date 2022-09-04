package com.kh.eatwith.email.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.eatwith.email.service.EmailService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/email")
public class EmailController {

	@Autowired
	private EmailService emailService;
	/**
	 * 난수생성 (6자리 난수) (000000 ~ 999999)
	 * @return
	 */
	private String generateRNGNumber() {
		Random r = new Random();
		StringBuilder sb = new StringBuilder();
		for(int i=0;i<6;i++) {
			sb.append(r.nextInt(10));
		}
		
		return sb.toString();
	}
	
	@GetMapping("/sendEmail")
	@ResponseBody
	public ResponseEntity<?> sendEmail(@RequestParam String emailToSend){
		log.debug("이메일 인증 요청 : {}",emailToSend);
		String code = generateRNGNumber();
		Map<String, String> params = new HashMap<String, String>();
		params.put("code", code);
		params.put("sendEmailTo", emailToSend);
		// 이메일 전송은 Service에서 관리한다.
		emailService.sendEmail(params);
//		code="123456";
		try {
			Thread.sleep(1500);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", code);
		return ResponseEntity.ok(result);
	}
}
