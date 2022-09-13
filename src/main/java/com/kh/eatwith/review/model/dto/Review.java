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
	protected int gatherNo;
	protected String restaurantNo;
	protected int overallScore;
	protected int tasteScore;
	protected int priceScore;
	protected int serviceScore;
	protected String content;
	protected int userNo;
	
	public void add(Attachment attach) {
		this.attachments.add(attach);
	}
	
	
}
