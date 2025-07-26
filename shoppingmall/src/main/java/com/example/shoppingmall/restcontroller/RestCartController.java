package com.example.shoppingmall.restcontroller;

import org.springframework.web.bind.annotation.RestController;

import com.example.shoppingmall.service.CartService;

import jakarta.servlet.http.HttpSession;

import java.util.Collections;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@RestController
@RequestMapping("/api")
public class RestCartController {

	private final CartService cartService;
	
	public RestCartController(CartService cartService) {
		this.cartService = cartService;
	}
	
	
	
	@GetMapping("/cart")
	public ResponseEntity<?> cartPage(HttpSession session) {
		
		String username = (String)session.getAttribute("username");
		cartService.selectAllcartByusername(username);
		
		
		return ResponseEntity.ok(Collections.singletonMap(null, null));
	}
	
}
