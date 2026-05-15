package com.springmvc.controller.reviewAdmin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.dto.common.PageDTO;
import com.springmvc.dto.review.ReviewDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.reviewAdmin.ReviewAdminService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class ReviewAdminController {

	@Autowired
	private ReviewAdminService reviewAdminService;

	@GetMapping("/reviewList")
	public String reviewManagement(HttpSession session, Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size,
			@RequestParam(name = "restaurantName", required = false) String restaurantName, RedirectAttributes rttr) {
		LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			rttr.addFlashAttribute("errorMessage", "로그인 후 이용할 수 있습니다.");
			return "redirect:/member/login";
		}
		if (!"ADMIN".equals(loginMember.getRole())) {
			rttr.addFlashAttribute("errorMessage", "관리자만 접근할 수 있습니다.");
			return "redirect:/";
		}
		if (page < 1) {
			page = 1;
		}
		if (size < 1) {
			size = 10;
		}
		int offset = (page - 1) * size;
		List<ReviewDTO> reviewList;
		int totalCount;
		if (restaurantName == null || restaurantName.trim().isEmpty()) {
			reviewList = reviewAdminService.reviewManagement(offset, size);
			totalCount = reviewAdminService.countReviewManagement();
			model.addAttribute("restaurantName", "");
		} else {
			String keyword = restaurantName.trim();
			reviewList = reviewAdminService.findReviewByRestaurantName(keyword, offset, size);
			totalCount = reviewAdminService.countReviewByRestaurantName(keyword);
			model.addAttribute("restaurantName", keyword);
		}
		PageDTO pageDTO = new PageDTO(page, size, totalCount);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pageDTO", pageDTO);
		return "admin/reviewList";
	}

	@PostMapping("/status")
	public String updateReviewStatus(HttpSession session, Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size,
			@RequestParam(name = "restaurantName", required = false) String restaurantName, RedirectAttributes rttr,
			@RequestParam("reviewId") Long reviewId, @RequestParam("status") String status) {
			LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");
			if (loginMember == null) {
				rttr.addFlashAttribute("errorMessage", "로그인 후 이용할 수 있습니다.");
				return "redirect:/member/login";
			}
			if (!"ADMIN".equals(loginMember.getRole())) {
				rttr.addFlashAttribute("errorMessage", "관리자만 접근할 수 있습니다.");
				return "redirect:/";
			}
			if(!"ACTIVE".equals(status) && !"BLOCKED".equals(status)) {
				rttr.addFlashAttribute("errorMessage","잘못된 리뷰 상태입니다.");
				return "redirect:/admin/reviewList?page=" + page
			            + "&size=" + size
			            + "&restaurantName=" + restaurantName.trim();
			}
			reviewAdminService.updateReviewStatus(reviewId, status);
			rttr.addFlashAttribute("successMessage","리뷰 상태가 변경되었습니다.");
			return "redirect:/admin/reviewList?page=" + page
		            + "&size=" + size
		            + "&restaurantName=" + restaurantName.trim();
	}
	
	@GetMapping("/reviewDetail")
	public String reviewDetail(@RequestParam("reviewId") Long reviewId,
							   HttpSession session,
							   Model model,
							   RedirectAttributes rttr) {

		LoginMemberDTO loginMember =
				(LoginMemberDTO) session.getAttribute("loginMember");

		if (loginMember == null) {
			rttr.addFlashAttribute("errorMessage", "로그인 후 이용할 수 있습니다.");
			return "redirect:/member/login";
		}

		if (!"ADMIN".equals(loginMember.getRole())) {
			rttr.addFlashAttribute("errorMessage", "관리자만 접근할 수 있습니다.");
			return "redirect:/";
		}

		ReviewDTO review = reviewAdminService.findReviewDetailById(reviewId);

		model.addAttribute("review", review);

		return "admin/reviewDetail";
	}
}
