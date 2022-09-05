package com.kh.eatwith.restaurant.model.dto;

import java.util.Date;

import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.member.model.dto.Gender;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Restaurant {
	protected String no;
	protected String districtCode;
	protected String foodCode;
	protected String name;
	protected String dong;
	protected String address;
	protected String workHours;
	protected String menu;
	protected String phone;
	protected String naverFoodType;
}
