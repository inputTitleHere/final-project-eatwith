package com.kh.eatwith.review.model.dto;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Review {
	
	private List<Attachment> attachments = new ArrayList<>();
	protected int no;
	protected int gather_no;
	protected String restaurant_no;
	protected int overallScore;
	protected int tasteStars;
	protected int priceStars;
	protected int serviceStars;
	protected String content;
	protected String image_name;
	public void add(Attachment attach) {
		this.attachments.add(attach);
	}
}
