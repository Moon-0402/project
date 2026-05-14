package com.springmvc.controller.inquiry;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.dto.common.PageDTO;
import com.springmvc.dto.inquiry.InquiryDTO;
import com.springmvc.dto.inquiry.InquiryReplyDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.inquiry.InquiryService;

@Controller
public class AdminInquiryController {

    private final InquiryService inquiryService;

    @Autowired
    public AdminInquiryController(InquiryService inquiryService) {
        this.inquiryService = inquiryService;
    }

    // 관리자 권한 확인
    private boolean isAdmin(HttpSession session) {
        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        return loginMember != null && "ADMIN".equals(loginMember.getRole());
    }

    // 관리자 문의 목록 + 페이징 + 검색
    @GetMapping("/admin/inquiries")
    public String inquiryManagement(
            HttpSession session,
            Model model,
            @RequestParam(value = "page", defaultValue = "1") Integer page,
            @RequestParam(value = "size", defaultValue = "10") Integer size,
            @RequestParam(value = "keyword", required = false) String keyword) {

        if (!isAdmin(session)) {
            return "redirect:/";
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

        int totalCount = inquiryService.countInquiriesByKeyword(keyword);

        PageDTO pageDTO = new PageDTO(page, size, totalCount);

        int offset = (page - 1) * size;

        List<InquiryDTO> inquiryList =
                inquiryService.findInquiriesWithPagingAndKeyword(offset, size, keyword);

        model.addAttribute("inquiryList", inquiryList);
        model.addAttribute("pageDTO", pageDTO);
        model.addAttribute("keyword", keyword);

        return "admin/inquiryManagement";
    }

    // 관리자 문의 상세
    @GetMapping("/admin/inquiry/{inquiryId}")
    public String inquiryDetail(
            @PathVariable("inquiryId") Long inquiryId,
            HttpSession session,
            Model model) {

        if (!isAdmin(session)) {
            return "redirect:/";
        }

        InquiryDTO inquiry = inquiryService.findByInquiryId(inquiryId);

        if (inquiry == null) {
            return "redirect:/admin/inquiries";
        }

        List<InquiryReplyDTO> replyList =
                inquiryService.findRepliesByInquiryId(inquiryId);

        model.addAttribute("inquiry", inquiry);
        model.addAttribute("replyList", replyList);

        return "admin/inquiryDetail";
    }

    // 관리자 답변 등록
    @PostMapping("/admin/inquiry/{inquiryId}/reply")
    public String writeReply(
            @PathVariable("inquiryId") Long inquiryId,
            @RequestParam("content") String content,
            HttpSession session,
            RedirectAttributes rttr) {

        if (!isAdmin(session)) {
            return "redirect:/";
        }

        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        if (content == null || content.trim().isEmpty()) {
            rttr.addFlashAttribute("msg", "답변 내용을 입력해주세요.");
            return "redirect:/admin/inquiry/" + inquiryId;
        }

        inquiryService.saveReply(
                inquiryId,
                loginMember.getMemberId(),
                content.trim()
        );

        inquiryService.updateInquiryStatus(inquiryId, "ANSWERED");

        rttr.addFlashAttribute("msg", "답변이 등록되었습니다.");

        return "redirect:/admin/inquiry/" + inquiryId;
    }

    // 관리자 문의 삭제
    @PostMapping("/admin/inquiry/{inquiryId}/delete")
    public String deleteInquiry(
            @PathVariable("inquiryId") Long inquiryId,
            HttpSession session,
            RedirectAttributes rttr) {

        if (!isAdmin(session)) {
            return "redirect:/";
        }

        inquiryService.deleteInquiry(inquiryId);

        rttr.addFlashAttribute("msg", "문의가 삭제되었습니다.");

        return "redirect:/admin/inquiries";
    }
}