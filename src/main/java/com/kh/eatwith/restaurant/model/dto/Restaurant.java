package com.kh.eatwith.restaurant.model.dto;

import java.util.Date;

import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.member.model.dto.Gender;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Restaurant {
	private String no;
	private String districtCode;
	private String foodCode;
	private String name;
	private String dong;
	private String address;
	private String workHours;
	private String menu;
	private String phone;
	private String naverFoodType;
}
