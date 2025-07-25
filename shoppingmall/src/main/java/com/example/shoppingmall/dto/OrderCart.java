package com.example.shoppingmall.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class OrderCart {
	private int orderCartNo;
	private int orderNo;
	private String username;
	private int itemNo;
	private String saveName;
	private String itemTitle;
	private int itemCount;
	private int totalPrice;
	private String orderStatus;
	private String deliveryStatus;
	private Date orderDate;
	private String updateDate;
	
	
	public String getDisplayTitle() {
		if (itemCount <= 1) return itemTitle;
		return itemTitle + " 외 " + (itemCount - 1) + "개";
	}
}
