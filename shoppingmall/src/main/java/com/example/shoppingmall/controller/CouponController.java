package com.example.shoppingmall.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.shoppingmall.dto.Coupon;
import com.example.shoppingmall.dto.Page;
import com.example.shoppingmall.service.CouponService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CouponController {
	// 의존성 주입
	private final CouponService couponService;
	
	// 생성자 주입
	public CouponController(CouponService couponService) {
		this.couponService = couponService;
	}
	
	// 쿠폰리스트(관리자)
	@GetMapping("/admin/couponList")
	public String couponList(Model model,
							 HttpSession session,
							 Page page) {
		

	 // 금액/퍼센트부분 필터는 숫자인데 검색은 문자열이어서 변환 해줘야한다.
		if ("PERCENT".equals(page.getCouponType())) {
			// 입력된 검색어를 꺼낸다
		    String word = page.getSearchWord();
		    // 입력된 검색어가 null이 아니고 공백이 아닌 경우
		    if (word != null && !word.trim().isEmpty()) {
		        try {
		        	// 문자열을 숫자로 바꿔서 couponPercentage에 저장
		            page.setCouponPercentage(Integer.parseInt(word.trim()));
		            // 숫자가 아니면 numberformatException e 로 예외 던짐
		        } catch (NumberFormatException e) {
		            System.out.println("숫자 아님");
		        }
		    }
		    // 기존 검색어는 숫자만 보고 필터링 하기 때문에 기존 검색 조건은 초기화
		    page.setSearchType(null);
		  
		    
		} else if ("AMOUNT".equals(page.getCouponType())) {
			// 입력된 검색어 꺼내고
		    String word = page.getSearchWord();
		    // 검색어가 null 아니고 공백이 아닐경우
		    if (word != null && !word.trim().isEmpty()) {
		        try {
		        	// 문자열을 숫자로 변환해서 CouponAmout에 저장
		            page.setCouponAmount(Integer.parseInt(word.trim()));
		            // 숫자가 아닐경우 예외로 던짐
		        } catch (NumberFormatException e) {
		            System.out.println("숫자 아님");
		        }
		    }
		    // 기존 텍스트 검색 필터는 제거
		    page.setSearchType(null);
		}
	    /*
		System.out.println("==== 쿠폰 검색 디버깅 ====");
		System.out.println("couponType = " + page.getCouponType());
		System.out.println("searchWord = " + page.getSearchWord());
		System.out.println("couponPercentage = " + page.getCouponPercentage());
		System.out.println("couponAmount = " + page.getCouponAmount());
		System.out.println("searchType = " + page.getSearchType());
		*/
			// 페이지 계산(page dto에서 호출)
			page.setBeginRow();
			
			// 리스트 + 전체 개수
			List<Coupon> list = couponService.getCouponList(page);
			int totalCount = couponService.getTotalCount(page);
			int rowPerPage = page.getRowPerPage();
			int lastPage = (int) Math.ceil((double) totalCount / rowPerPage);
			
			// 뷰에 모델에 담아서 전달
			model.addAttribute("couponList", list);
			model.addAttribute("page", page);
			model.addAttribute("lastPage", lastPage);

			System.out.println("totalCount = " + totalCount);
			System.out.println("list:" + list.toString());
			 System.out.println("couponAmount: " + page.getCouponAmount());
			return "admin/couponList";
			
			
		
	}
	
}
