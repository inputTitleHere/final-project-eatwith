package com.kh.eatwith.gather.model.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

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
	private String title;//모임제목
	private int count;//인원수
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime meetDate;//모임시각
	private String content;//모임내용
	private int ageRestrictionTop;//최소나이
	private int ageRestrictionBottom;//최대나이
	private Gender genderRestriction;//모임 성별제한
	private String restaurantNo;//모임위치(가게)
	private String foodCode;
	private String districtCode;
	private int userNo;//유저넘버
}
