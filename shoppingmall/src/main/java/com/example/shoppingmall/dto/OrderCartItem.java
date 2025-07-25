package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class OrderCartItem {
	// 주문내역 상세보기 출력용 DTO
	private int orderNo;
	private String itemTitle; 	// 상품명
	private String savaName;	// 상품 이미지
	private int count;			// 개수
	private int price;			// 가격
	private String optionName;	// 상품 옵션
	private String orderStatus;	// 주문상태(PAYED, CANCEL)
	
	
}
