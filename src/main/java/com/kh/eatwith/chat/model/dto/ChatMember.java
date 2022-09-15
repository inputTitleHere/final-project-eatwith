package com.kh.eatwith.chat.model.dto;


import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatMember {
	
	private String chatroomId;
	private int userNo;
	private int lastCheck;
	private Date joinedAt;
	private Date deletedAt;
	
}
