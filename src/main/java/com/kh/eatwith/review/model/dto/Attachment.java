package com.kh.eatwith.review.model.dto;


import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Attachment {

	private int no;
	private String restaurantNo;
	private int reviewNo;
	private String imageName;
	@NonNull
	private String renamedFilename;
	private LocalDateTime createdAt;
}
