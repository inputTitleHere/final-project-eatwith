package com.kh.eatwith.review.model.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Attachment {

	private int no;
	private String restaurantNo;
	private int reviewNo;
	private String imageName;
}
