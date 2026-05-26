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
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.restaurant.RestaurantService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminRestaurantController {

    @Autowired
    private RestaurantService restaurantService;

    // ===========================
    // 관리자 권한 확인 공통 메서드
    // ===========================
    private boolean isAdmin(HttpSession session) {
        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        return loginMember != null && "ADMIN".equals(loginMember.getRole());
    }

    // 관리자 맛집 목록 + 페이징 + 검색
    @GetMapping("/admin/restaurants")
    public String adminRestaurantList(
            Model model,
            HttpSession session,
            @RequestParam(value = "page", defaultValue = "1") Integer page,
            @RequestParam(value = "size", defaultValue = "10") Integer size,
            @RequestParam(value = "keyword", required = false) String keyword) {

        // 추가: 관리자만 접근 가능
        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

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
    public String addRestaurantForm(Model model, HttpSession session) {

        // 추가: 관리자만 접근 가능
        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

        model.addAttribute("restaurant", new Restaurant());
        model.addAttribute("edit", false);

        return "admin/restaurant/form";
    }

    // 맛집 등록 처리
    @PostMapping("/admin/restaurants/add")
    public String addRestaurant(Restaurant restaurant, HttpSession session) {

        // 추가: 관리자만 접근 가능
        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

        // 추가: 맛집 이름 유효성 검사
        if (restaurant.getName() == null || restaurant.getName().trim().isEmpty()) {
            return "redirect:/admin/restaurants/add";
        }

        restaurantService.insertRestaurant(restaurant);

        return "redirect:/admin/restaurants";
    }

    // 맛집 수정 폼
    @GetMapping("/admin/restaurants/update")
    public String updateRestaurantForm(
            @RequestParam("restaurantId") Long restaurantId,
            Model model,
            HttpSession session) {

        // 추가: 관리자만 접근 가능
        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

        Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);

        // 추가: 존재하지 않는 맛집 ID 처리
        if (restaurant == null) {
            return "redirect:/admin/restaurants";
        }

        model.addAttribute("restaurant", restaurant);
        model.addAttribute("edit", true);

        return "admin/restaurant/form";
    }

    // 맛집 수정 처리
    @PostMapping("/admin/restaurants/update")
    public String updateRestaurant(Restaurant restaurant, HttpSession session) {

        // 추가: 관리자만 접근 가능
        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

        // 추가: restaurantId 없으면 수정 불가
        if (restaurant.getRestaurantId() == null) {
            return "redirect:/admin/restaurants";
        }

        // 추가: 맛집 이름 유효성 검사
        if (restaurant.getName() == null || restaurant.getName().trim().isEmpty()) {
            return "redirect:/admin/restaurants/update?restaurantId=" + restaurant.getRestaurantId();
        }

        restaurantService.updateRestaurant(restaurant);

        return "redirect:/admin/restaurants";
    }

    // 맛집 삭제
    @PostMapping("/admin/restaurants/delete")
    public String deleteRestaurant(
            @RequestParam("restaurantId") Long restaurantId,
            HttpSession session) {

        // 추가: 관리자만 접근 가능
        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

        // 추가: restaurantId 없으면 삭제하지 않음
        if (restaurantId == null) {
            return "redirect:/admin/restaurants";
        }

        restaurantService.deleteRestaurant(restaurantId);

        return "redirect:/admin/restaurants";
    }
}