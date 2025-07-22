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
	
	// 쿠폰 등록
	public int insertCoupon(Coupon coupon) {
		return couponMapper.insertCoupon(coupon);
	}

	// 쿠폰 스케줄러 만료처리
	public int expireOldCoupons() {
		return couponMapper.updateExpiredCoupons();
	}
	
	// 관리자 쿠폰 삭제
	public int updateDeleteCoupons(int couponNo) {
		return couponMapper.updateDeleteCoupons(couponNo);
	}
}
