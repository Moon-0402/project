package com.springmvc.controller.restaurant;

import java.util.ArrayList;
import java.util.List;

// import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.dto.restaurant.Restaurant;
import com.springmvc.dto.restaurant.RestaurantDTO;
import com.springmvc.dto.restaurant.RestaurantMapDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.service.kakao.KakaoLocalService;
import com.springmvc.service.restaurant.RestaurantService;

import jakarta.servlet.http.HttpSession;

@Controller
public class RestaurantController {

	@Autowired
	private RestaurantService restaurantService;

	@Autowired
	private KakaoLocalService kakaoLocalService;
	
	// 맛집 리스트 페이지
	@GetMapping("/restaurants")
	public String restaurantList(
	        @RequestParam(value = "regionKeyword", required = false) String regionKeyword,
	        @RequestParam(value = "foodKeyword", required = false) String foodKeyword,
	        @RequestParam(value = "page", defaultValue = "1") int page,
	        Model model,
	        HttpSession session) {

	    LoginMemberDTO loginMember =
	            (LoginMemberDTO) session.getAttribute("loginMember");

	    if (loginMember == null) {
	        return "redirect:/member/login";
	    }

	    int size = 5;
	    int offset = (page - 1) * size;

	    List<RestaurantDTO> restaurantList;
	    List<RestaurantMapDTO> mapList;
	    int totalCount;

	    boolean hasRegion = regionKeyword != null && !regionKeyword.trim().isEmpty();
	    boolean hasFood = foodKeyword != null && !foodKeyword.trim().isEmpty();

	    if (hasRegion || hasFood) {

	        restaurantList = restaurantService.searchRestaurantList(regionKeyword, foodKeyword, offset, size);
	        totalCount = restaurantService.countSearchRestaurantList(regionKeyword, foodKeyword);
	        mapList = restaurantService.getSearchRestaurantMapList(regionKeyword, foodKeyword);

	        if (restaurantList == null || restaurantList.isEmpty()) {

	            String kakaoQuery = makeKakaoRestaurantQuery(regionKeyword, foodKeyword);

	            System.out.println("DB 검색 결과 없음. 카카오 API 검색어 = " + kakaoQuery);

	            kakaoLocalService.importRestaurants(kakaoQuery);

	            // API로 저장한 뒤에는 반드시 사용자가 입력한 원래 조건으로 다시 조회해야 함.
	            // 기존 코드는 음식 키워드가 있으면 지역 조건을 빼고 재조회해서 지역 검색 결과가 흔들릴 수 있었음.
	            restaurantList = restaurantService.searchRestaurantList(regionKeyword, foodKeyword, offset, size);
	            totalCount = restaurantService.countSearchRestaurantList(regionKeyword, foodKeyword);
	            mapList = restaurantService.getSearchRestaurantMapList(regionKeyword, foodKeyword);
	        }

	    } else {
	        restaurantList = new ArrayList<>();
	        mapList = new ArrayList<>();
	        totalCount = 0;
	    }

	    int totalPage = (int) Math.ceil((double) totalCount / size);

	    int pageLimit = 10;
	    int startPage = ((page - 1) / pageLimit) * pageLimit + 1;
	    int endPage = startPage + pageLimit - 1;

	    if (endPage > totalPage) {
	        endPage = totalPage;
	    }

	    model.addAttribute("restaurantList", restaurantList);
	    model.addAttribute("mapList", mapList);
	    model.addAttribute("regionKeyword", regionKeyword);
	    model.addAttribute("foodKeyword", foodKeyword);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("totalCount", totalCount);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("pageLimit", pageLimit);

	    return "restaurant/list";
	}

    private String makeKakaoRestaurantQuery(String regionKeyword, String foodKeyword) {

        String region = regionKeyword == null ? "" : regionKeyword.trim();
        String food = foodKeyword == null ? "" : foodKeyword.trim();

        if (!region.isEmpty() && !food.isEmpty()) {
            return region + " " + food;
        }

        if (!region.isEmpty()) {
            return region + " 맛집";
        }

        return food;
    }


    // 맛집 상세 페이지
    @GetMapping("/restaurants/{restaurantId}")
    public String restaurantDetail(@PathVariable("restaurantId") Long restaurantId, Model model, HttpSession session) {
        Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);
        
        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long memberId = loginMember.getMemberId();
        restaurantService.insertRecentlyRestaurant(memberId, restaurantId);
        // 상세보기한 맛집을 최근 본 맛집으로 저장하기 위해서

        model.addAttribute("restaurant", restaurant);

        return "restaurant/detail";
    }

    // 지도 전체보기 페이지
    @GetMapping("/restaurants/map")
    public String restaurantMap(Model model) {
        List<RestaurantMapDTO> mapList = restaurantService.getRestaurantMapList();

        model.addAttribute("mapList", mapList);

        return "restaurant/map";
    }
    
    @GetMapping("/restaurants/recent")
    public String recentRestaurant(
            Model model,
            HttpSession session,
            @RequestParam(value = "page", defaultValue = "1") int page) {

        LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long memberId = loginMember.getMemberId();

        int size = 5;
        int offset = (page - 1) * size;

        List<RestaurantDTO> recentList =
                restaurantService.getRecentlyRestaurantList(memberId, offset, size);

        int totalCount =
                restaurantService.countRecentlyRestaurantList(memberId);

        int totalPage = (int) Math.ceil((double) totalCount / size);

        int pageLimit = 5;
        int startPage = ((page - 1) / pageLimit) * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;

        if (endPage > totalPage) {
            endPage = totalPage;
        }

        model.addAttribute("recentList", recentList);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("pageLimit", pageLimit);

        return "restaurant/recent";
    }
}