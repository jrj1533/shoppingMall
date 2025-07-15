package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class Item {
	private int itemNo;
	private String username;
	private int optionNo;
	private String itemTitle;
	private String itemAmount;
	private String status;
	private String createDate;
}
