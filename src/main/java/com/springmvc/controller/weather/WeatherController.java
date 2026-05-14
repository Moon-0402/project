package com.springmvc.controller.weather;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.springmvc.dto.weather.WeatherDTO;
import com.springmvc.service.weather.WeatherService;

@RestController
public class WeatherController {

    @Autowired
    private WeatherService weatherService;

    @GetMapping("/api/weather")
    public WeatherDTO getWeather(@RequestParam("lat") double lat, @RequestParam("lng") double lng) {
        return weatherService.getWeather(lat, lng);
    }
}