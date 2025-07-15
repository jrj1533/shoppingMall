package com.example.shoppingmall.dto;

import java.util.List;

import lombok.Data;

@Data
public class Item {
	private int itemNo;
	private String username;
	private List<Integer> optionNo;
	private String itemTitle;
	private String itemContent;
	private String itemAmount;
	private String status;
	private String createDate;
}
