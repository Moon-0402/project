package com.springmvc.dto.user;

public class SignupDTO {
	private String Id;
    private String pw;
    private String pwCheck;
    private String name;
    private String email;
    private String phone;
    private boolean termsAgree;
	public String getId() {
		return Id;
	}
	public void setId(String id) {
		Id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getPwCheck() {
		return pwCheck;
	}
	public void setPwCheck(String pwCheck) {
		this.pwCheck = pwCheck;
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
	public boolean isTermsAgree() {
		return termsAgree;
	}
	public void setTermsAgree(boolean termsAgree) {
		this.termsAgree = termsAgree;
	}
	public SignupDTO(String id, String pw, String pwCheck, String name, String email, String phone,
			boolean termsAgree) {
		super();
		Id = id;
		this.pw = pw;
		this.pwCheck = pwCheck;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.termsAgree = termsAgree;
	}
	public SignupDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
    
    
}
