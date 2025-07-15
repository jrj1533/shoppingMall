package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class StockLog {
	private int logNo;
	private int optionNo;
	private int changed;
	private String reason;
	private String updateDate;
}
