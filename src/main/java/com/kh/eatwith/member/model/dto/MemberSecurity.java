package com.kh.eatwith.member.model.dto;

import java.time.LocalDate;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper=true)
public class MemberSecurity extends Member implements UserDetails {

	private static final long serialVersionUID = 1L;
	/**
	 * 문자열로 권한 관리가능한 객체?
	 */
	private List<SimpleGrantedAuthority> authorities;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getUsername() {
		return Integer.toString(no);
	}

	@Override
	public boolean isAccountNonExpired() {
		return deletedAt==null?true:false;
	}

	@Override
	public boolean isAccountNonLocked() {
		return deletedAt==null?true:false;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return deletedAt==null?true:false;
	}

	@Override
	public boolean isEnabled() {
		return deletedAt==null?true:false;
	}


}
