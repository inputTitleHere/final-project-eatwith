package com.kh.eatwith.email.service;

import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class EmailServiceImpl implements EmailService {
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Value("${email.account}")
	private String sendEmailFrom;
	
	@Override
	public void sendEmail(Map<String, String> params) {
		// TODO Auto-generated method stub
		String title = "같이먹을래 인증메일";
		String content = String.format("안녕하세요, 같이먹을래에 회원가입에 필요한 인증 번호를 보내드립니다."
				+ "<br><br>인증 번호는 아래와 같습니다.<br><h2>%s</h2><br>해당 인증 번호를 회원가입의 인증번호란에 입력하여주세요.", params.get("code"));
		log.debug("content = {}",content);
		mailSend(sendEmailFrom, params.get("sendEmailTo"),title,content);
	}
	
	public void mailSend(String sendEmailFrom,String sendEmailTo, String title, String content) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(sendEmailFrom);
			helper.setTo(sendEmailTo);
			helper.setSubject(title);
			helper.setText(content, true); // 2번인자 : HTML으로 전송 여부.
			log.debug("메일발송 From : {}, To {}",sendEmailFrom, sendEmailTo);
			mailSender.send(message);
		}catch(MessagingException e) {
			e.printStackTrace();
		}
	}
	
	
}
