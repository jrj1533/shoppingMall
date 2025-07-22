package com.example.shoppingmall.restcontroller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.shoppingmall.dto.Coupon;
import com.example.shoppingmall.service.CouponService;

@RestController
public class CouponListController {
	// 의존성 주입
	private final CouponService couponService;
	
	// 생성자 주입
	public CouponListController(CouponService couponService) {
		this.couponService = couponService;
	}
	
	@PostMapping("/admin/addCoupon")
	// ajax를 쓰면 json 형태로 데이터를 받을때 requestBody 써야 자동으로 객체로 변환
	public String addCoupon(@RequestBody Coupon coupon) {
		
		couponService.insertCoupon(coupon);
		return "쿠폰 등록 완료";
	}
}
