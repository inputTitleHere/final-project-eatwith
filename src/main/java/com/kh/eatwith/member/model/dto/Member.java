package com.kh.eatwith.member.model.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private String id;
	private String name;
	private String password;
	private String email;
	private String phone;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate enrollAt;
	private Role role;
	private int point;
	private int age;
	private Gender gender;
}
