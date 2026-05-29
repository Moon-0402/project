package com.springmvc.controller.member;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.repository.member.MemberRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private MemberRepository memberRepository;

    @Override
    public void onAuthenticationSuccess(
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication)
            throws IOException, ServletException {

        String loginId = authentication.getName();

        LoginMemberDTO loginMember =
                memberRepository.findLoginMemberByLoginId(loginId);

        HttpSession session = request.getSession();
        session.setAttribute("loginMember", loginMember);

        if (loginMember != null && "ADMIN".equals(loginMember.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/");
    }
}