package com.example.shoppingmall.dto;

import java.util.List;

import lombok.Data;

@Data
public class ProductOptionListDto {
	private int itemNo;
	private String itemTitle;
	private String itemAmount;
	private List<ItemOption> options;
	private String saveName;
}
