package com.example.shoppingmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ItemController {

	@GetMapping("/item/register")
	public String productForm() {
		return "seller/productForm";
	}
	
	@PostMapping("/item/register")
	public String itemRegister() {
		
	}
	
}
