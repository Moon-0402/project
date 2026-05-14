package com.springmvc.controller.inquiry;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.springmvc.dto.inquiry.InquiryDTO;
import com.springmvc.dto.inquiry.InquiryReplyDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.inquiry.InquiryService;

import jakarta.servlet.http.HttpSession;

@Controller
public class InquiryController {

    private final InquiryService inquiryService;

    @Autowired
    public InquiryController(InquiryService inquiryService) {
        this.inquiryService = inquiryService;
    }
    
    @GetMapping("/member/inquiries")
    public String inquiryList(HttpSession session, Model model) {

        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        List<InquiryDTO> inquiryList =
                inquiryService.findByMemberId(loginMember.getMemberId());

        model.addAttribute("inquiryList", inquiryList);

        return "member/inquiryList";
    }

    @GetMapping("/member/inquiry/write")
    public String inquiryWriteForm(HttpSession session, Model model) {
        LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        model.addAttribute("inquiryDTO", new InquiryDTO());

        return "member/inquiryWrite";
    }

    @PostMapping("/member/inquiry/write")
    public String inquiryWrite(InquiryDTO inquiryDTO, HttpSession session) {
        LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        inquiryDTO.setMemberId(loginMember.getMemberId());
        inquiryService.saveInquiry(inquiryDTO);

        return "redirect:/member/inquiries";
    }

    @GetMapping("/member/inquiry/{inquiryId}")
    public String inquiryDetail(
            @PathVariable("inquiryId") Long inquiryId,
            HttpSession session,
            Model model) {

        LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        InquiryDTO inquiry = inquiryService.findByInquiryId(inquiryId);

        if (!inquiry.getMemberId().equals(loginMember.getMemberId())) {
            return "redirect:/member/inquiries";
        }

        List<InquiryReplyDTO> replyList = inquiryService.findRepliesByInquiryId(inquiryId);

        model.addAttribute("inquiry", inquiry);
        model.addAttribute("replyList", replyList);

        return "member/inquiryDetail";
    }
    
    @PostMapping("/member/inquiry/{inquiryId}/delete")
    public String deleteMyInquiry(
            @PathVariable("inquiryId") Long inquiryId,
            HttpSession session) {

        LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        InquiryDTO inquiry = inquiryService.findByInquiryId(inquiryId);

        if (!inquiry.getMemberId().equals(loginMember.getMemberId())) {
            return "redirect:/member/inquiries";
        }

        if ("ANSWERED".equals(inquiry.getStatus())) {
            return "redirect:/member/inquiry/" + inquiryId;
        }

        inquiryService.deleteInquiry(inquiryId);

        return "redirect:/member/inquiries";
    }
    
   
}