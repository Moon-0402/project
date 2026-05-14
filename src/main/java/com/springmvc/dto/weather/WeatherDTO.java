package com.springmvc.dto.weather;

public class WeatherDTO {

    private String sky;       // 하늘상태
    private String pty;       // 강수형태
    private String temp;      // 기온
    private String weatherText; // 화면 표시용
	public WeatherDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public WeatherDTO(String sky, String pty, String temp, String weatherText) {
		super();
		this.sky = sky;
		this.pty = pty;
		this.temp = temp;
		this.weatherText = weatherText;
	}
	public String getSky() {
		return sky;
	}
	public void setSky(String sky) {
		this.sky = sky;
	}
	public String getPty() {
		return pty;
	}
	public void setPty(String pty) {
		this.pty = pty;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getWeatherText() {
		return weatherText;
	}
	public void setWeatherText(String weatherText) {
		this.weatherText = weatherText;
	}
}