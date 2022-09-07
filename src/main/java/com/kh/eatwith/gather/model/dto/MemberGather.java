package com.kh.eatwith.gather.model.dto;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberGather {
	private int userNo;//유저번호
	private int gatherNo;//모임번호
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime enrollAt;
}
