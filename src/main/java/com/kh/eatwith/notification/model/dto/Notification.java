package com.kh.eatwith.notification.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Notification {
	long no; // long을 사용하겠다.
	int userNo;
	String content;
	LocalDate sentAt;
	LocalDate readAt;
	LocalDate DeletedAt; // 이거 안쓰고 그냥 날리겠다. 
	
}
