package com.kh.eatwith.admin.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VisitantCount {

	private LocalDate visitantsDate;
	private int visitants_number;

}
