package com.springmvc.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.dto.common.PageDTO;
import com.springmvc.dto.restaurant.Restaurant;
import com.springmvc.dto.restaurant.RestaurantDTO;
import com.springmvc.service.restaurant.RestaurantService;

@Controller
public class AdminRestaurantController {

    @Autowired
    private RestaurantService restaurantService;

    // 관리자 맛집 목록 + 페이징 + 검색
    @GetMapping("/admin/restaurants")
    public String adminRestaurantList(
            Model model,
            @RequestParam(value = "page", defaultValue = "1") Integer page,
            @RequestParam(value = "size", defaultValue = "10") Integer size,
            @RequestParam(value = "keyword", required = false) String keyword) {

        if (page == null || page < 1) {
            page = 1;
        }

        if (size == null || size < 1) {
            size = 10;
        }

        if (keyword != null) {
            keyword = keyword.trim();
        }

        int totalCount;
        List<RestaurantDTO> restaurantList;

        int offset = (page - 1) * size;

        if (keyword != null && !keyword.isEmpty()) {
            totalCount = restaurantService.countSearchAdminRestaurantList(keyword);
            restaurantList = restaurantService.searchAdminRestaurantList(keyword, offset, size);
        } else {
            totalCount = restaurantService.countAdminRestaurantList();
            restaurantList = restaurantService.getAdminRestaurantList(offset, size);
        }

        PageDTO pageDTO = new PageDTO(page, size, totalCount);

        model.addAttribute("restaurantList", restaurantList);
        model.addAttribute("pageDTO", pageDTO);
        model.addAttribute("keyword", keyword);

        return "admin/restaurant/list";
    }

    // 맛집 등록 폼
    @GetMapping("/admin/restaurants/add")
    public String addRestaurantForm(Model model) {
        model.addAttribute("restaurant", new Restaurant());
        model.addAttribute("edit",false);
        return "admin/restaurant/form";
    }

    // 맛집 등록 처리
    @PostMapping("/admin/restaurants/add")
    public String addRestaurant(Restaurant restaurant) {
        restaurantService.insertRestaurant(restaurant);
        return "redirect:/admin/restaurants";
    }

    // 맛집 수정 폼
    @GetMapping("/admin/restaurants/update")
    public String updateRestaurantForm(
            @RequestParam("restaurantId") Long restaurantId,
            Model model) {

        Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);
        model.addAttribute("restaurant", restaurant);
        model.addAttribute("edit",true);
        return "admin/restaurant/form";
    }

    // 맛집 수정 처리
    @PostMapping("/admin/restaurants/update")
    public String updateRestaurant(Restaurant restaurant) {
        restaurantService.updateRestaurant(restaurant);
        return "redirect:/admin/restaurants";
    }

    // 맛집 삭제
    @PostMapping("/admin/restaurants/delete")
    public String deleteRestaurant(@RequestParam("restaurantId") Long restaurantId) {
        restaurantService.deleteRestaurant(restaurantId);
        return "redirect:/admin/restaurants";
    }
}