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

	            String kakaoQuery = "";

	            if (hasRegion) {
	                kakaoQuery += regionKeyword.trim();
	            }

	            if (hasFood) {
	                if (!kakaoQuery.isEmpty()) {
	                    kakaoQuery += " ";
	                }

	                kakaoQuery += foodKeyword.trim();
	            }

	            kakaoLocalService.importRestaurants(kakaoQuery);

	            if (hasFood) {
	                restaurantList = restaurantService.searchRestaurantList(null, foodKeyword, offset, size);
	                totalCount = restaurantService.countSearchRestaurantList(null, foodKeyword);
	                mapList = restaurantService.getSearchRestaurantMapList(null, foodKeyword);
	            } else {
	                restaurantList = restaurantService.searchRestaurantList(regionKeyword, null, offset, size);
	                totalCount = restaurantService.countSearchRestaurantList(regionKeyword, null);
	                mapList = restaurantService.getSearchRestaurantMapList(regionKeyword, null);
	            }
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

        model.addAttribute("restaurant", restaurant);

        return "restaurant/detail";
    }
    
// // 맛집 상세 페이지
//    @GetMapping("/restaurants/{restaurantId}")
//    public String restaurantDetail(@PathVariable("restaurantId") Long restaurantId,
//                                   Model model,
//                                   HttpSession session) {
//
//        Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);
//
//        Long memberId = (Long) session.getAttribute("memberId");
//
//        if (memberId != null) {
//            restaurantService.insertRecentlyRestaurant(memberId, restaurantId);
//        }
//
//        model.addAttribute("restaurant", restaurant);
//
//        return "restaurant/detail";
//    }

    // 지도 전체보기 페이지
    @GetMapping("/restaurants/map")
    public String restaurantMap(Model model) {
        List<RestaurantMapDTO> mapList = restaurantService.getRestaurantMapList();

        model.addAttribute("mapList", mapList);

        return "restaurant/map";
    }
    
    @GetMapping("/restaurants/recent")
    public String recentRestaurant(Model model,HttpSession session) {

    	LoginMemberDTO loginMember =
                (LoginMemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long memberId = loginMember.getMemberId();
        List<RestaurantDTO> recentList =
            restaurantService.getRecentlyRestaurantList(memberId);

        model.addAttribute("recentList", recentList);

        return "restaurant/recent";
    }
    
// // 최근 본 맛집 페이지
//    @GetMapping("/restaurants/recent")
//    public String recentRestaurant(Model model, HttpSession session) {
//
//        Long memberId = (Long) session.getAttribute("memberId");
//
//        if (memberId == null) {
//            return "redirect:/login";
//        }
//
//        List<RestaurantDTO> recentList =
//            restaurantService.getRecentlyRestaurantList(memberId);
//
//        model.addAttribute("recentList", recentList);
//
//        return "restaurant/recent";
//    }
}