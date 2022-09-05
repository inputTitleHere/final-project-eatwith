package com.kh.eatwith.restaurant.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RestaurantExt extends Restaurant{
	private String districtName;
	private String type; //음식타입
	
}
