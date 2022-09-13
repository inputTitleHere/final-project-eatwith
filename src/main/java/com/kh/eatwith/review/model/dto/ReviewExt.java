package com.kh.eatwith.review.model.dto;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * ReviewExtension을 위한 DTO객체
 * 간단한 레스트랑 정보 및 이미지 collection 함유
 * @author Lunatine
 *
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewExt extends Review {
	private List<Attachment> reviewImages = new ArrayList<Attachment>();
	private String restaurantName;
	private String restaurantDong;
	private String foodType;
	private int reviewCount;
	private double avgScore;
	private String writer;
}
