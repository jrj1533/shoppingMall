package com.example.shoppingmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.shoppingmall.dto.Item;
import com.example.shoppingmall.dto.ItemFile;
import com.example.shoppingmall.dto.ItemOption;
import com.example.shoppingmall.service.ItemService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ItemController {
	private ItemService itemService;
	
	public ItemController(ItemService itemService) {
		this.itemService = itemService;
	}
	
	@GetMapping("/item/register")
	public String productForm() {
		return "seller/productForm";
	}
	
	@PostMapping("/item/register")
	public String itemRegister(Item item,ItemOption itemOption, ItemFile itemfile ) {
	
		itemService.insertItem(item);
		return "";
	}
	
}
