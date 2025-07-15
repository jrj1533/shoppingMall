package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class ItemOption {
	private int optionNo;
	private int itemNo;
	private String optionName;
	private String optionValue;
	private int stock;
	private String createDate;
}
