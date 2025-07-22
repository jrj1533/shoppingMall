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
			return "admin/couponList";
			
			
		
	}
	
}
