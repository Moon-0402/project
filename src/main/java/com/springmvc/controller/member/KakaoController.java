package com.springmvc.controller.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;

import com.springmvc.dto.user.KakaoUserDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.user.KakaoService;
import com.springmvc.service.user.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/kakao")
public class KakaoController {

    @Autowired
    private KakaoService kakaoService;

    @Autowired
    private MemberService memberService;

    private final String REST_API_KEY = "bb90d370055218fddaec7cd1d7044494";

    // 로컬 테스트용
//     private final String REDIRECT_URI =
//            "http://localhost:8080/AppProject01/member/kakao/callback";

    // AWS 배포용
    private final String REDIRECT_URI =
            "http://3.37.130.240:8080/AppProject01/member/kakao/callback";

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
            HttpServletRequest request,
            HttpServletResponse response) {

        if (error != null) {
            System.out.println("카카오 로그인 error = " + error);
            return "redirect:/member/login";
        }

        if (code == null || code.trim().isEmpty()) {
            System.out.println("카카오 code 없음");
            return "redirect:/member/login";
        }

        try {
            String accessToken = kakaoService.getAccessToken(code);

            KakaoUserDTO kakaoUser = kakaoService.getKakaoUserInfo(accessToken);

            LoginMemberDTO loginMember = memberService.kakaoLogin(kakaoUser);

            if (loginMember == null) {
                System.out.println("loginMember null");
                return "redirect:/member/login?error=true";
            }

            HttpSession session = request.getSession(true);

            // 기존 프로젝트에서 쓰던 세션 값
            session.setAttribute("loginMember", loginMember);

            String role = loginMember.getRole();

            if (role == null || role.trim().isEmpty()) {
                role = "USER";
            }

            if (role.startsWith("ROLE_")) {
                role = role.replace("ROLE_", "");
            }

            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(
                            loginMember,
                            null,
                            List.of(new SimpleGrantedAuthority("ROLE_" + role))
                    );

            SecurityContext securityContext = SecurityContextHolder.createEmptyContext();
            securityContext.setAuthentication(authentication);

            SecurityContextHolder.setContext(securityContext);

            session.setAttribute(
                    HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,
                    securityContext
            );

            new HttpSessionSecurityContextRepository()
                    .saveContext(securityContext, request, response);


            return "redirect:http://3.37.130.240:8080/AppProject01/";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/member/login?error=true";
        }
    }
}