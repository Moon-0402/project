package com.springmvc.controller.aipick;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.dto.aipick.AiPickDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.aipick.AiPickService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AiPickController {

    @Autowired
    private AiPickService aiPickService;

    /**
     * AI PICK 페이지
     */
    @GetMapping("/aipick")
    public String aiPick(
            @RequestParam(value = "lat", required = false) Double lat,
            @RequestParam(value = "lng", required = false) Double lng,
            HttpSession session,
            Model model) {

        // 로그인 사용자 정보 가져오기
        LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

        // 로그인하지 않은 경우 로그인 페이지로 이동
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        /*
         * 아직 현재 위치가 넘어오지 않은 경우
         * JSP에서 위치 권한을 요청한 뒤 다시 /aipick?lat=...&lng=... 형태로 이동시킨다.
         */
        if (lat == null || lng == null) {
            model.addAttribute("needLocation", true);
            return "aipick/aiPick";
        }

        // 로그인한 회원 번호
        Long memberId = loginMember.getMemberId();

        // AI PICK 추천 결과 3개 조회
        List<AiPickDTO> aiPickList = aiPickService.getAiPickList(memberId, lat, lng);

        // JSP로 데이터 전달
        model.addAttribute("aiPickList", aiPickList);
        model.addAttribute("needLocation", false);

        return "aipick/aiPick";
    }
}