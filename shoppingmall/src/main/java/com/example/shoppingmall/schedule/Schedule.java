package com.example.shoppingmall.schedule;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.shoppingmall.mapper.SellerMapper;
import com.example.shoppingmall.service.SellerService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class Schedule {
	private SellerService sellerService;
	private SellerMapper sellerMapper;
	
	// 배송시작 후 3일 지나면 배송 완료로 변경
	@Scheduled(cron = "0 0 0 * * ?")
	public void changeDelivery() {
		int updateCount = sellerService.deliveryChangeToFinish();
		System.out.println("배송완료 처리된 건수: " + updateCount + "건");
	}
}
