package com.example.shoppingmall.schedule;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.shoppingmall.service.CouponService;
import com.example.shoppingmall.service.SellerService;

@Component
public class Schedule {
	
	private final SellerService sellerService;
	private final CouponService couponService;
	
	public Schedule(SellerService sellerService, CouponService couponService ) {
		this.sellerService = sellerService;
		this.couponService = couponService;
	}
	/*
	현재 설정한 "0 0 * * * ?"은 매 시간 정각마다 실행
	설명:

	초: 0

	분: 0

	시: 매시

	일: 매일

	월: 매월

	요일: 매일

	즉, 매시 정각 (예: 00:00, 01:00, 02:00...)에 실행
	*/
	
	// 배송시작 후 3일 지나면 배송 완료로 변경
	@Scheduled(cron = "0 0 * * * ?")
	public void changeDelivery() {
		int updateCount = sellerService.deliveryChangeToFinish();
		System.out.println("배송완료 처리된 건수: " + updateCount + "건");
	}
	
	// 배송완료 후 7일 지나면 구매 확정
	@Scheduled(cron = "0 0 * * * ?")
	public void itemConfirm() {
		int itemConfirm = sellerService.deliveryChangeToConfirm();
		System.out.println("구매 확정 처리 및 포인트 지급 건수: " + itemConfirm + "건");
	}
	
	@Scheduled(cron = "0 0 * * * *") 
	public void expireCoupons() {
		int count = couponService.expireOldCoupons();
		System.out.println("만료 처리된 쿠폰 수: :" + count + "건");
	}

}
