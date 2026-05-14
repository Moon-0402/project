package com.springmvc.dto.user;

public class MyPwChangeDTO {

    private String currentPw;
    private String newPw;
    private String newPwCheck;

    public MyPwChangeDTO() {
    }

    public String getCurrentPw() {
        return currentPw;
    }

    public void setCurrentPw(String currentPw) {
        this.currentPw = currentPw;
    }

    public String getNewPw() {
        return newPw;
    }

    public void setNewPw(String newPw) {
        this.newPw = newPw;
    }

    public String getNewPwCheck() {
        return newPwCheck;
    }

    public void setNewPwCheck(String newPwCheck) {
        this.newPwCheck = newPwCheck;
    }
}