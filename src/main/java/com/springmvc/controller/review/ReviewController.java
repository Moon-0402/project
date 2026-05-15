package com.springmvc.controller.review;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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

	// 리뷰 메인 페이지
	// 최신 리뷰 목록 + 리뷰 검색 + 페이징
	@GetMapping("/review")
	public String reviewMain(
	        @RequestParam(value = "regionKeyword", required = false) String regionKeyword,
	        @RequestParam(value = "foodKeyword", required = false) String foodKeyword,
	        @RequestParam(value = "page", defaultValue = "1") int page,
	        @RequestParam(value = "size", defaultValue = "6") int size,
	        Model model) {

	    boolean isSearch =
	            (regionKeyword != null && !regionKeyword.trim().isEmpty())
	         || (foodKeyword != null && !foodKeyword.trim().isEmpty());

	    int offset = (page - 1) * size;

	    int totalCount;
	    List<ReviewDTO> latestReviewList;

	    if (isSearch) {

	        totalCount =
	                reviewService.countSearchReviewList(regionKeyword, foodKeyword);

	        latestReviewList =
	                reviewService.searchReviewList(
	                        regionKeyword,
	                        foodKeyword,
	                        offset,
	                        size
	                );

	    } else {

	        totalCount = reviewService.countReview();

	        latestReviewList =
	                reviewService.getReviewList(offset, size);
	    }

	    int totalPage =
	            (int) Math.ceil((double) totalCount / size);

	    int pageLimit = 5;
	    int startPage = ((page - 1) / pageLimit) * pageLimit + 1;
	    int endPage = startPage + pageLimit - 1;

	    if (endPage > totalPage) {
	        endPage = totalPage;
	    }

	    model.addAttribute("latestReviewList", latestReviewList);
	    model.addAttribute("regionKeyword", regionKeyword);
	    model.addAttribute("foodKeyword", foodKeyword);
	    model.addAttribute("isSearch", isSearch);

	    model.addAttribute("totalCount", totalCount);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("pageLimit", pageLimit);
	    model.addAttribute("size", size);

	    return "review/main";
	}

	@GetMapping("/review/list")
	public String reviewList(@RequestParam("restaurantId") Long restaurantId,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "5") int size, Model model) {

		int totalCount = reviewService.countReviewByRestaurantId(restaurantId);

		int offset = (page - 1) * size;

		List<ReviewDTO> reviewList = reviewService.getReviewListByRestaurantId(restaurantId, offset, size);

		int totalPage = (int) Math.ceil((double) totalCount / size);

		int pageLimit = 5;
		int startPage = ((page - 1) / pageLimit) * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;

		if (endPage > totalPage) {
			endPage = totalPage;
		}

		model.addAttribute("reviewList", reviewList);
		model.addAttribute("restaurantId", restaurantId);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pageLimit", pageLimit);
		model.addAttribute("size", size);

		return "review/list";
	}

	@GetMapping("/review/write")
	public String reviewWriteForm(@RequestParam("restaurantId") Long restaurantId, Model model, HttpSession session) {

		LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

		if (loginMember == null) {
			return "redirect:/member/login";
		}

		Long memberId = loginMember.getMemberId();
		// ===========================
		// 기존: 같은 맛집 리뷰 중복 제한
		// 여러 리뷰 작성 허용을 위해 제거
		// ===========================
//        int reviewCount =
//                reviewService.countReviewByMemberAndRestaurant(memberId, restaurantId);
//
//        if (reviewCount > 0) {
//            return "redirect:/restaurants/" + restaurantId;
//        }

		Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);

		ReviewDTO review = new ReviewDTO();
		review.setRestaurantId(restaurantId);
		review.setMemberId(memberId);
		review.setRestaurantName(restaurant.getName());

		model.addAttribute("review", review);
		model.addAttribute("edit", false);

		return "review/form";
	}

	@PostMapping("/review/write")
	public String reviewWrite(ReviewDTO review,
			@RequestParam(value = "imageFile", required = false) MultipartFile imageFile, HttpSession session)
			throws IOException {

		LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

		if (loginMember == null) {
			return "redirect:/member/login";
		}

		review.setMemberId(loginMember.getMemberId());

		if (imageFile != null && !imageFile.isEmpty()) {
			String savedImagePath = saveReviewImage(imageFile, session);
			review.setImage(savedImagePath);
		}

		reviewService.insertReview(review);

		// ===========================
		// 리뷰 작성 후 리뷰 목록으로 이동
		// 방금 작성한 리뷰를 바로 확인 가능
		// ===========================
		return "redirect:/review/list?restaurantId=" + review.getRestaurantId();
	}

	@GetMapping("/review/update")
	public String reviewUpdateForm(@RequestParam("reviewId") Long reviewId, Model model, HttpSession session) {

		LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

		if (loginMember == null) {
			return "redirect:/member/login";
		}

		ReviewDTO review = reviewService.getReviewById(reviewId);

		if (!review.getMemberId().equals(loginMember.getMemberId())) {
			return "redirect:/restaurants/" + review.getRestaurantId();
		}

		model.addAttribute("review", review);
		model.addAttribute("edit", true);

		return "review/form";
	}

	@PostMapping("/review/update")
	public String reviewUpdate(ReviewDTO review,
			@RequestParam(value = "imageFile", required = false) MultipartFile imageFile, HttpSession session)
			throws IOException {

		LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

		if (loginMember == null) {
			return "redirect:/member/login";
		}

		review.setMemberId(loginMember.getMemberId());

		if (imageFile != null && !imageFile.isEmpty()) {
			String savedImagePath = saveReviewImage(imageFile, session);
			review.setImage(savedImagePath);
		} else {
			ReviewDTO oldReview = reviewService.getReviewById(review.getReviewId());
			review.setImage(oldReview.getImage());
		}

		reviewService.updateReview(review);

		return "redirect:/review/list?restaurantId=" + review.getRestaurantId();
	}


    @GetMapping("/member/mypage/reviews")
    public String myReviewList(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "6") int size,
            HttpSession session,
            Model model) {


		LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

		if (loginMember == null) {
			return "redirect:/member/login";
		}

		Long memberId = loginMember.getMemberId();

		int totalCount = reviewService.countReviewByMemberId(memberId);

		int offset = (page - 1) * size;

		List<ReviewDTO> reviewList = reviewService.getReviewListByMemberId(memberId, offset, size);

		int totalPage = (int) Math.ceil((double) totalCount / size);

		int pageLimit = 5;
		int startPage = ((page - 1) / pageLimit) * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;

		if (endPage > totalPage) {
			endPage = totalPage;
		}
		System.out.println("memberId = " + memberId);
		System.out.println("page = " + page);
		System.out.println("size = " + size);
		System.out.println("offset = " + offset);
		System.out.println("totalCount = " + totalCount);

		System.out.println("reviewList size = " + reviewList.size());

		for (ReviewDTO r : reviewList) {
			System.out.println(r.getReviewId());
			System.out.println(r.getRestaurantName());
		}

		model.addAttribute("reviewList", reviewList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pageLimit", pageLimit);
		model.addAttribute("size", size);

		return "review/myList";
	}

	private String saveReviewImage(MultipartFile imageFile, HttpSession session) throws IOException {

		// 실제 파일 저장 위치
		String uploadPath = "C:/upload/review/";

		File dir = new File(uploadPath);

		if (!dir.exists()) {
			dir.mkdirs();
		}

		String originalName = imageFile.getOriginalFilename();

		String savedName = UUID.randomUUID().toString() + "_" + originalName;

		File saveFile = new File(uploadPath, savedName);

		imageFile.transferTo(saveFile);

		// DB에 저장될 경로
		return "/upload/review/" + savedName;
	}
}