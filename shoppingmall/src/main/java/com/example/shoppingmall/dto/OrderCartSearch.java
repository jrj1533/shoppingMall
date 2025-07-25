package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class OrderCartSearch {
	private String username;		// 구매자
	private String deliveryStatus;	// 배송상태
	private String orderStatus;		// 결제 상태
	private String searchWord;		// 검색어
	private String searchType;		// 검색 타입

}
