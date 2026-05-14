package com.springmvc.dto.user;

public class AlertSettingDTO {
	private Long memberId;
    private boolean pushAlert;
    private boolean emailAlert;
	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	public boolean isPushAlert() {
		return pushAlert;
	}
	public void setPushAlert(boolean pushAlert) {
		this.pushAlert = pushAlert;
	}
	public boolean isEmailAlert() {
		return emailAlert;
	}
	public void setEmailAlert(boolean emailAlert) {
		this.emailAlert = emailAlert;
	}
	public AlertSettingDTO(Long memberId, boolean pushAlert, boolean emailAlert) {
		super();
		this.memberId = memberId;
		this.pushAlert = pushAlert;
		this.emailAlert = emailAlert;
	}
    
}
