package com.example.shoppingmall.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.shoppingmall.dto.Coupon;
import com.example.shoppingmall.dto.Page;
import com.example.shoppingmall.mapper.CouponMapper;

@Service
public class CouponService {
	// 의존성 주입
	private final CouponMapper couponMapper;
	
	// 생성자 주입
	public CouponService(CouponMapper couponMapper) {
		this.couponMapper = couponMapper;
	}
	
	// 쿠폰리스트(관리자)전체 개수
	public int getTotalCount(Page page) {
		return couponMapper.totalCount(page);
	}
	
	// 쿠폰리스트(관리자)
	public List<Coupon> getCouponList(Page page) {
		return couponMapper.selectCouponList(page);
	}
}
