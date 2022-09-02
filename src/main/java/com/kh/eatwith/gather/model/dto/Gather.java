package com.kh.eatwith.gather.model.dto;

import java.util.Date;

import com.kh.eatwith.member.model.dto.Gender;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Gather {
	
	private int no; //모임 고유번호
	private String gatherTitle;//모임제목
	private int gatherCount;//인원수
	private Date gatherTime;//모임시각
	private String gatherContent;//모임내용
	private int gatherMin;//최소나이
	private int gatherMax;//최대나이
	private Gender gatherGender;//모임 성별제한
}
