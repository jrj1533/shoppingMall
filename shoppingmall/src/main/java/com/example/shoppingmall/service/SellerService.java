package com.example.shoppingmall.service;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.shoppingmall.dto.Page;
import com.example.shoppingmall.mapper.SellerMapper;

@Service
public class SellerService {
	@Autowired SellerMapper sellerMapper;

	public int totalCount(Page paging) {
		return sellerMapper.totalCount(paging);
	}
	
	// 주문리스트
	public List<Map<String, Object>> orderList(int beginRow, int size, String username, String buyer, String deliveryStatus, String ordersStatus) {
		
		return sellerMapper.selectOrderList(beginRow, size, username, buyer, deliveryStatus, ordersStatus);
	}

	// 배송준비중 -> 배송중 업데이트
	@Transactional
	public void startDelivery(Integer deliveryNo, Integer orderNo) { // 배송상태 변경ㅇ, 상태변경시 송장번호 임의 숫자입력 해야함!
		
		// 랜덤 송장번호 생성 함수
		String deliveryNumber = generateRandomInvoice();
		
		// 송장번호 update
		sellerMapper.updateDeliveryNumber(deliveryNo, orderNo, deliveryNumber);
		
		// 배송상태 변태변경 update
		sellerMapper.startDelivery(deliveryNo);
	}
	
	// 랜덤 송장 생성 함수
	private String generateRandomInvoice() {
		StringBuilder sb = new StringBuilder();
		Random rand = new Random();

		// 운송장생성(임의의 숫자로 0000-0000-0000-0000)
		for (int i = 0; i < 4; i++) {
			int num = rand.nextInt(10000); // 0000 ~ 9999
			sb.append(String.format("%04d", num)); 
			if (i < 3) sb.append("-"); // 마지막 0000뒤에 - 안붙임
		}

		return sb.toString();
	}

	// 배송 완료로 변경
	public int deliveryChangeToFinish() {
		return sellerMapper.deliveryChangeToFinish();
		
	}

	// 구매확정
	@Transactional
	public int deliveryChangeToConfirm() {
		// 배송완료(FINISH)랑 포인트미지급(N) 상태값의 데이터 구해오기
		List<Map<String, Object>> finishDelivery = sellerMapper.selectFinishDelivery();
		
		int successCount = 0;
		
		for(Map<String, Object> delivery : finishDelivery) {
			String buyer = (String) delivery.get("buyer");
			Integer orderNo = (Integer) delivery.get("orderNo");
			Integer totalPrice = (Integer) delivery.get("totalPrice");
			
			// 포인트계산
			int point = (int)(totalPrice * 0.01); // 구매금액의 1%
			
			// 적립
			sellerMapper.addPoint(buyer, point);
			
			int result = sellerMapper.changPointProvessed(orderNo);
			
			if(result > 0) {
				successCount ++;
			}
		}
		return successCount;
	}

}
