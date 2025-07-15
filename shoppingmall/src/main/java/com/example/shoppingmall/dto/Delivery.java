package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class Delivery {
	private int deliveryNo;
	private int orderNo;
	private int deliveryNumber;
	private String status;
	private String createDate;
	private String updateDate;
}
