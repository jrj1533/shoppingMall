package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class Cart {
	private int cartNo;
	private String username;
	private int itemNo;
	private int optionNo;
	private int visitorId;
	private String status;
	private int count;
	private String createDate;
}
