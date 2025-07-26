package com.example.shoppingmall.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class CartDto {
	private int cartNo;
	private String username;
	private ItemDto item;
	private ItemOption option;
	private Address address; 
	private int count;
	private LocalDate createDate;
}
