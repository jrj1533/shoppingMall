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
							 @RequestParam(defaultValue = "1") int currentPage,
							 @RequestParam(defaultValue = "10") int rowPerPage,
							 @RequestParam(defaultValue = "") String searchWord,
							 @RequestParam(defaultValue = "") String couponTitle,
							 @RequestParam(defaultValue = "") String couponContent,
							 @RequestParam(defaultValue = "") String couponType,
							 @RequestParam(defaultValue = "0") int couponAmount,
							 @RequestParam(defaultValue = "0") int couponPercentage) {
		
			
			// Dto 생성
			Page page = new Page(rowPerPage, currentPage, searchWord, couponTitle, couponContent, couponType, couponAmount, couponPercentage);
			
			// 리스트 + 전체 개수
			List<Coupon> list = couponService.getCouponList(page.getBeginRow(), rowPerPage, currentPage, searchWord, couponTitle, couponContent, couponType, couponAmount, couponPercentage);
			int totalCount = couponService.getTotalCount(page);
			int lastPage = (int) Math.ceil((double) totalCount / rowPerPage);
			
			// 뷰에 모델에 담아서 전달
			model.addAttribute("couponList", list);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("lastPage", lastPage);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("couponTitle", couponTitle);
			model.addAttribute("couponContent", couponContent);
			model.addAttribute("couponType", couponType);
			model.addAttribute("couponAmount", couponAmount);
			model.addAttribute("couponPercentage", couponPercentage);
			
			System.out.println("rowPerPage = " + rowPerPage);
			System.out.println("totalCount = " + totalCount);
			System.out.println("list:" + list.toString());
			return "admin/couponList";
			
			
		
	}
	
}
