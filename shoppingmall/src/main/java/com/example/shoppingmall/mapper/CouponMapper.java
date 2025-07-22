package com.example.shoppingmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.shoppingmall.dto.Coupon;
import com.example.shoppingmall.dto.Page;

@Mapper
public interface CouponMapper {

	// 쿠폰리스트(관리자)
	List<Coupon> selectCouponList(Page page);
	
	// 쿠폰리스트 전체개수
	int totalCount(Page page);
	
	// 쿠폰 등록
	int insertCoupon(Coupon coupon);

	// 쿠폰 스케줄 만료처리
	int updateExpiredCoupons();

	// 관리자 쿠폰삭제
	int updateDeleteCoupons(int couponNo);


}
