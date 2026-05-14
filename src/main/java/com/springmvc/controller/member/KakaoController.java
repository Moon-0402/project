package com.springmvc.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;

import com.springmvc.dto.user.KakaoUserDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.user.KakaoService;
import com.springmvc.service.user.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/kakao")
public class KakaoController {

    @Autowired
    private KakaoService kakaoService;

    @Autowired
    private MemberService memberService;

    private final String REST_API_KEY = "bb90d370055218fddaec7cd1d7044494";
    private final String REDIRECT_URI = "http://localhost:8080/AppProject01/member/kakao/callback";

    @GetMapping("/login")
    public String kakaoLogin() {

    	String kakaoLoginUrl =
    	        "https://kauth.kakao.com/oauth/authorize"
    	        + "?response_type=code"
    	        + "&client_id=" + REST_API_KEY
    	        + "&redirect_uri=" + UriUtils.encode(REDIRECT_URI, "UTF-8")
    	        + "&prompt=login";

        return "redirect:" + kakaoLoginUrl;
    }

    @GetMapping("/callback")
    public String kakaoCallback(
            @RequestParam(value = "code", required = false) String code,
            @RequestParam(value = "error", required = false) String error,
            HttpSession session) {

        if (error != null) {
            System.out.println("카카오 로그인 에러: " + error);
            return "redirect:/member/login";
        }

        if (code == null || code.trim().isEmpty()) {
            System.out.println("카카오 인가 코드 없음");
            return "redirect:/member/login";
        }

        String accessToken = kakaoService.getAccessToken(code);

        KakaoUserDTO kakaoUser = kakaoService.getKakaoUserInfo(accessToken);

        LoginMemberDTO loginMember = memberService.kakaoLogin(kakaoUser);

        session.setAttribute("loginMember", loginMember);

        return "redirect:/";
    }
}