package com.kh.eatwith.member.model.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 2022/08/31 변경사항
 * 선호 지역, 선호 음식 종류 추가.
 *
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	protected int no;
	protected String id;
	protected String name;
	protected String password;
	protected String email;
	protected String phone;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDate enrollAt;
	protected Role role;
	protected int point;
	protected int bornAt; // age -> bornAt으로 변경하였습니다(DB변경했습니다)(백)
	protected Gender gender;
	protected LocalDate deletedAt;
	// ERD -> 지역
	protected String[] favRegion;
	// ERD -> 선호 음식
	protected String[] favFoodType;
	protected boolean enabled;
	
}
