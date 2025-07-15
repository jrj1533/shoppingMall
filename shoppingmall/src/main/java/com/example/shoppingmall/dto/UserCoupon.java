package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class UserCoupon {
	private int userCouponNo;
	private String username;
	private int couponNo;
	private String used;
	private String createDate;
	private String usedAt;
}
