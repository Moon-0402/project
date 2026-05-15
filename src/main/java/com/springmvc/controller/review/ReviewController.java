package com.springmvc.controller.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.dto.restaurant.Restaurant;
import com.springmvc.dto.review.ReviewDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.restaurant.RestaurantService;
import com.springmvc.service.review.ReviewService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ReviewController {

    @Autowired
    private ReviewService reviewService;
    
    @Autowired
    private RestaurantService restaurantService;

    // 특정 맛집 리뷰 목록
    @GetMapping("/review")
    public String reviewList(
            @RequestParam("restaurantId") Long restaurantId,
            Model model) {

        List<ReviewDTO> reviewList =
                reviewService.getReviewListByRestaurantId(restaurantId);

        model.addAttribute("reviewList", reviewList);
        model.addAttribute("restaurantId", restaurantId);

        return "review/list";
    }

    // 리뷰 작성 폼
    @GetMapping("/review/write")
    public String reviewWriteForm(
            @RequestParam("restaurantId") Long restaurantId,
            Model model,
            HttpSession session) {

        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long memberId = loginMember.getMemberId();

        int reviewCount =
                reviewService.countReviewByMemberAndRestaurant(memberId, restaurantId);

        if (reviewCount > 0) {
            return "redirect:/restaurants/" + restaurantId;
        }

        Restaurant restaurant =
                restaurantService.getRestaurantById(restaurantId);

        ReviewDTO review = new ReviewDTO();

        review.setRestaurantId(restaurantId);
        review.setMemberId(memberId);
        review.setRestaurantName(restaurant.getName());

        model.addAttribute("review", review);

        return "review/form";
    }

    // 리뷰 등록
    @PostMapping("/review/write")
    public String reviewWrite(
            ReviewDTO review,
            HttpSession session) {

        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long memberId = loginMember.getMemberId();

        review.setMemberId(memberId);

        reviewService.insertReview(review);

        return "redirect:/restaurants/" + review.getRestaurantId();
    }

    // 리뷰 수정 폼
    @GetMapping("/review/update")
    public String reviewUpdateForm(
            @RequestParam("reviewId") Long reviewId,
            Model model,
            HttpSession session) {

        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long memberId = loginMember.getMemberId();

        ReviewDTO review = reviewService.getReviewById(reviewId);

        if (!review.getMemberId().equals(memberId)) {
            return "redirect:/restaurants/" + review.getRestaurantId();
        }

        model.addAttribute("review", review);

        return "review/form";
    }

    // 리뷰 수정 처리
    @PostMapping("/review/update")
    public String reviewUpdate(
            ReviewDTO review,
            HttpSession session) {

        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long memberId = loginMember.getMemberId();

        review.setMemberId(memberId);

        reviewService.updateReview(review);

        return "redirect:/restaurants/" + review.getRestaurantId();
    }

    // 내가 쓴 리뷰 목록
    @GetMapping("/mypage/reviews")
    public String myReviewList(
            HttpSession session,
            Model model) {

        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long memberId = loginMember.getMemberId();

        List<ReviewDTO> reviewList =
                reviewService.getReviewListByMemberId(memberId);

        model.addAttribute("reviewList", reviewList);

        return "review/myList";
    }
}