package com.springmvc.dto.admin;

public class MemberUpdateDTO {

    private String loginId;
    private String name;
    private String email;
    private String phone;

    public MemberUpdateDTO() {
    }

    public MemberUpdateDTO(String loginId, String name, String email, String phone) {
        this.loginId = loginId;
        this.name = name;
        this.email = email;
        this.phone = phone;
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

}