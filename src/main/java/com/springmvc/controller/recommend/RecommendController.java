package com.springmvc.controller.recommend;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.dto.recommend.RecommendHistory;
import com.springmvc.dto.restaurant.RestaurantDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.kakao.KakaoLocalService;
import com.springmvc.service.recommend.RecommendService;
import com.springmvc.service.restaurant.RestaurantService;

import jakarta.servlet.http.HttpSession;

@Controller
public class RecommendController {

	// 추천 기록 서비스
	@Autowired
	private RecommendService recommendService;

	// 맛집 서비스
	@Autowired
	private RestaurantService restaurantService;

	// 카카오 API 서비스
	@Autowired
	private KakaoLocalService kakaoLocalService;

	
	
	// =========================
	// 추천 페이지 이동
	// =========================
	@GetMapping("/recommend")
	public String recommend(HttpSession session) {

		// 로그인 사용자 정보 가져오기
		LoginMemberDTO loginMember =
				(LoginMemberDTO) session.getAttribute("loginMember");

		// 비로그인 시 로그인 페이지로 이동
		if (loginMember == null) {
			return "redirect:/member/login";
		}

		// 추천 페이지 반환
		return "recommend/recommend";
	}

	
	
	// =========================
	// 추천 결과 페이지
	// =========================
	@GetMapping("/recommend/result")
	public String recommendResult(

			// 사용자가 선택한 음식
			@RequestParam("selectedFood") String selectedFood,

			// 현재 위치 위도
			@RequestParam(value = "lat", required = false) Double lat,

			// 현재 위치 경도
			@RequestParam(value = "lng", required = false) Double lng,

			// 세션
			HttpSession session,

			// 화면 전달용 Model
			Model model) {

		// 로그인 사용자 정보 가져오기
		LoginMemberDTO loginMember =
				(LoginMemberDTO) session.getAttribute("loginMember");

		// 비로그인 시 로그인 페이지 이동
		if (loginMember == null) {
			return "redirect:/member/login";
		}

		// 디버깅 로그 출력
		System.out.println("selectedFood = " + selectedFood);
		System.out.println("lat = " + lat);
		System.out.println("lng = " + lng);

		// 추천 맛집 리스트
		List<RestaurantDTO> nearRestaurantList;

		
		
		// =========================================
		// 현재 위치(lat/lng)가 있는 경우
		// → 거리 기반 추천
		// =========================================
		if (lat != null && lng != null) {

			// DB에서 가까운 맛집 조회
			nearRestaurantList =
					restaurantService.getNearRestaurants(
							selectedFood,
							lat,
							lng,
							3
					);

			// DB 결과가 없으면
			if (nearRestaurantList == null || nearRestaurantList.isEmpty()) {

				// 카카오 API에서 현재 위치 기반 맛집 저장
				kakaoLocalService.importRestaurants(
						selectedFood,
						lat,
						lng
				);

				// 저장 후 다시 DB 조회
				nearRestaurantList =
						restaurantService.getNearRestaurants(
								selectedFood,
								lat,
								lng,
								3
						);
			}

			
			
		// =========================================
		// 현재 위치 정보가 없는 경우
		// → 일반 검색 추천
		// =========================================
		} else {

			// 일반 검색
			nearRestaurantList =
					restaurantService.searchRestaurantList(
							null,
							selectedFood,
							0,
							3
					);

			// 검색 결과 없으면
			if (nearRestaurantList == null || nearRestaurantList.isEmpty()) {

				// 카카오 API 일반 검색 후 저장
				kakaoLocalService.importRestaurants(selectedFood);

				// 다시 DB 조회
				nearRestaurantList =
						restaurantService.searchRestaurantList(
								null,
								selectedFood,
								0,
								3
						);
			}
		}

		
		
		// null 방지
		if (nearRestaurantList == null) {
			nearRestaurantList = new ArrayList<>();
		}

		
		
		// =========================================
		// 추천 기록 저장
		// =========================================
		if (!nearRestaurantList.isEmpty()) {

			// 첫 번째 추천 음식점
			RestaurantDTO recommendRestaurant =
					nearRestaurantList.get(0);

			// 추천 기록 객체 생성
			RecommendHistory history =
					new RecommendHistory();

			// 회원 ID 저장
			history.setMemberId(
					loginMember.getMemberId()
			);

			// 사용자가 선택한 음식 저장
			history.setSelectedFood(selectedFood);

			// 추천된 음식점 ID 저장
			history.setResultRestaurantId(
					recommendRestaurant.getRestaurantId()
			);

			// 추천 기록 DB 저장
			recommendService.insertRecommendHistory(history);
		}

		
		
		// 디버깅 출력
		System.out.println(
				"nearRestaurantList = "
				+ nearRestaurantList
		);

		
		
		// JSP 전달 데이터
		model.addAttribute(
				"selectedFood",
				selectedFood
		);

		model.addAttribute(
				"nearRestaurantList",
				nearRestaurantList
		);

		
		
		// 추천 결과 페이지 반환
		return "recommend/result";
	}

	
	
	// =========================
	// 추천 기록 페이지
	// =========================
	@GetMapping("/recommend/history")
	public String recommendHistory(
			HttpSession session,
			Model model) {

		// 로그인 사용자 정보
		LoginMemberDTO loginMember =
				(LoginMemberDTO) session.getAttribute("loginMember");

		// 비로그인 시 로그인 페이지 이동
		if (loginMember == null) {
			return "redirect:/member/login";
		}

		// 회원 ID
		Long memberId =
				loginMember.getMemberId();

		// 추천 기록 조회
		List<RecommendHistory> list =
				recommendService.getRecommendHistoryList(memberId);

		// JSP 전달
		model.addAttribute("historyList", list);

		// 추천 기록 페이지 반환
		return "recommend/history";
	}

	
	
	// =========================
	// 추천 기록 삭제
	// =========================
	@PostMapping("/recommend/history/delete")
	public String deleteRecommendHistory(

			// 삭제할 추천 기록 ID
			@RequestParam("recommendId") Long recommendId,

			HttpSession session) {

		// 로그인 사용자 정보
		LoginMemberDTO loginMember =
				(LoginMemberDTO) session.getAttribute("loginMember");

		// 비로그인 시 로그인 페이지 이동
		if (loginMember == null) {
			return "redirect:/member/login";
		}

		// 회원 ID
		Long memberId =
				loginMember.getMemberId();

		// 추천 기록 삭제
		recommendService.deleteRecommendHistory(
				recommendId,
				memberId
		);

		// 추천 기록 페이지로 이동
		return "redirect:/recommend/history";
	}
}