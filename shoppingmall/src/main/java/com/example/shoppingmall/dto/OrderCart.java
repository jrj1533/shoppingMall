package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class OrderCart {
	private int orderCartNo;
	private int orderNo;
	private int itemNo;
	private int count;
	private int price;
	private String status;
	private String orderDate;
	private String updateDate;
}
