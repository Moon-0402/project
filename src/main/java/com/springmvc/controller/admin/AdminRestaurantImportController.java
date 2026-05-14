package com.springmvc.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.service.kakao.KakaoLocalService;

@Controller
@RequestMapping("/admin/restaurants")
public class AdminRestaurantImportController {

    @Autowired
    private KakaoLocalService kakaoLocalService;

    @GetMapping("/import")
    public String importRestaurants(
            @RequestParam(value = "query", required = false) String query) {

        if (query == null || query.trim().isEmpty()) {
            query = "맛집";
        }

        kakaoLocalService.importRestaurants(query);

        return "redirect:/restaurants";
    }
}