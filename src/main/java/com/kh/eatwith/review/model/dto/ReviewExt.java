package com.kh.eatwith.review.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewExt extends Review {
	private String restaurantName;
	private String restaurantDong;
	private String foodType;
	private int reviewCount;
	private double avgScore;
}
