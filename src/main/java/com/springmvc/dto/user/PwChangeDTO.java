package com.springmvc.dto.user;

public class PwChangeDTO {
	private String id;
    private String pw;
    private String pwCheck;

    public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public PwChangeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PwChangeDTO(String id, String pw, String pwCheck) {
		super();
		this.id = id;
		this.pw = pw;
		this.pwCheck = pwCheck;
	}
    
}
