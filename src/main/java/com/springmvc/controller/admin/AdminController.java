package com.springmvc.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.dto.admin.MemberManagementDTO;
import com.springmvc.dto.admin.MemberUpdateDTO;
import com.springmvc.dto.common.PageDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.admin.AdminService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    // 관리자 권한 확인 메서드
    private boolean isAdmin(HttpSession session) {
        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        return loginMember != null && "ADMIN".equals(loginMember.getRole());
    }

    // 관리자 메인 페이지
    @GetMapping
    public String adminPage(HttpSession session) {

        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

        return "admin/admin";
    }

 // 회원 목록 페이지 + 페이징 + 검색
    @GetMapping("/members")
    public String memberList(
            HttpSession session,
            Model model,
            @RequestParam(value = "page", defaultValue = "1") Integer page,
            @RequestParam(value = "size", defaultValue = "10") Integer size,
            @RequestParam(value = "keyword", required = false) String keyword) {

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

        int totalCount = adminService.countMembersByKeyword(keyword);

        PageDTO pageDTO = new PageDTO(page, size, totalCount);

        int offset = (page - 1) * size;

        List<MemberManagementDTO> memberList =
                adminService.findMembersWithPagingAndKeyword(offset, size, keyword);

        model.addAttribute("memberList", memberList);
        model.addAttribute("pageDTO", pageDTO);
        model.addAttribute("keyword", keyword);

        return "admin/memberList";
    }

    // 회원 상세 페이지
    @GetMapping("/member/detail")
    public String memberDetail(
            @RequestParam("memberId") Long memberId,
            Model model,
            HttpSession session) {

        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

        MemberManagementDTO member = adminService.findBymemberId(memberId);

        model.addAttribute("member", member);

        return "admin/memberDetail";
    }

    // 회원 수정 페이지
    @GetMapping("/member/update")
    public String updateMemberForm(
            @RequestParam("memberId") Long memberId,
            Model model,
            HttpSession session) {

        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

        MemberManagementDTO member = adminService.findBymemberId(memberId);

        model.addAttribute("member", member);

        return "admin/memberUpdate";
    }

    // 회원 수정 처리
    @PostMapping("/member/update")
    public String updateMember(
            @RequestParam("memberId") Long memberId,
            @ModelAttribute MemberUpdateDTO memberUpdateDTO,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

        adminService.updateMember(memberId, memberUpdateDTO);

        redirectAttributes.addFlashAttribute("msg", "회원 정보가 수정되었습니다.");

        return "redirect:/admin/member/detail?memberId=" + memberId;
    }

    // 회원 삭제 처리
    @DeleteMapping("/member/delete")
    public String deleteMember(
            @RequestParam("memberId") Long memberId,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        if (!isAdmin(session)) {
            return "redirect:/member/login";
        }

        adminService.deleteMember(memberId);

        redirectAttributes.addFlashAttribute("msg", "회원이 삭제되었습니다.");

        return "redirect:/admin/members";
    }
    
    
}