package com.kh.eatwith.chat.model.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatLog extends ChatMember{
	
	private int no;
	private String msg;
	private Date time;
	
}
