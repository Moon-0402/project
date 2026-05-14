package com.springmvc.dto.admin;

import java.time.LocalDateTime;

public class MemberManagementDTO {
	private Long memberId;
    private String loginId;
    private String name;
    private String email;
    private String phone;
    private String role;
    private LocalDateTime created_at;
	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	
	
	public LocalDateTime getCreated_at() {
		return created_at;
	}
	public void setCreated_at(LocalDateTime created_at) {
		this.created_at = created_at;
	}
	
	public MemberManagementDTO(Long memberId, String loginId, String name, String email, String phone,
			String role, LocalDateTime created_at) {
		super();
		this.memberId = memberId;
		this.loginId = loginId;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.role = role;
		this.created_at = created_at;
	}
	public MemberManagementDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
    
}
