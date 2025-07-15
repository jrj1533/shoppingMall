package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class Orders {
	private int orderNo;
	private String username;
	private int totalPrice;
	private String status;
	private String orderDate;
	private String updateDate;
}
