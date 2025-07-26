package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class ItemDto {
	private int itemNo;
	private String itemTitle;  // 상품 이름
	private String category;  // 카테고리
	private int itemAmount;   // 상품 가격 
	private String saveName; // 파일 이름
	
}
