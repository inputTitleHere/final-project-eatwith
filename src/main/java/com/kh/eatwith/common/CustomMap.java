package com.kh.eatwith.common;

import java.time.format.DateTimeFormatter;
import java.util.HashMap;

import org.springframework.jdbc.support.JdbcUtils;

/**
 * MyBatis으로 받은 값을 Hashmap으로 처리할 때 카멜케이싱이 적용되지 않는 문제가 있다. 
 * 이 클래스는 HashMap 클래스를 상속하여 카멜케이싱 처리를 한다. 그 외에는 기본적인 HashMap과 사용법이 동일하다.
 * 아래 사이트를 참고하였다. 
 * https://kaling88.tistory.com/14
 * @author Lunatine
 *
 */
@SuppressWarnings("serial")
public class CustomMap extends HashMap<String, Object> {

	@Override
	public Object put(String key, Object value) {
		
		if(value instanceof java.sql.Timestamp) {
			
			value = ((java.sql.Timestamp) value).toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
		}
		
		return super.put(JdbcUtils.convertUnderscoreNameToPropertyName(key), value);
	}
}
