package com.springmvc.dto.user;

public class LoginMemberDTO {
	private Long memberId;
    private String loginId;
    private String name;
    private String role;
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
	
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public LoginMemberDTO(Long memberId, String loginId, String name, String role) {
		super();
		this.memberId = memberId;
		this.loginId = loginId;
		this.name = name;
		this.role = role;
	}
	public LoginMemberDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
    
}
