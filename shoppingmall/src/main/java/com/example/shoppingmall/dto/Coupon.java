package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class Coupon {
	private int couponNo;
	private String title;
	private String content;
	private String type;
	private int amount;
	private int percentage;
	private String createDate;
	private String startDate;
	private String endDate;
}
