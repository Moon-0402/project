package com.springmvc.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.kakao.KakaoLocalService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/restaurants")
public class AdminRestaurantImportController {

    @Autowired
    private KakaoLocalService kakaoLocalService;

    // 관리자 권한 확인
    private boolean isAdmin(HttpSession session) {
        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        return loginMember != null
                && "ADMIN".equals(loginMember.getRole());
    }

    @PostMapping("/import")
    public String importRestaurants(
            HttpSession session,
            @RequestParam(value = "query", required = false) String query) {

        // 관리자만 가능
        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

        if (query == null || query.trim().isEmpty()) {
            query = "맛집";
        }

        kakaoLocalService.importRestaurants(query);

        return "redirect:/restaurants";
    }
}