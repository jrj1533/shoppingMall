package com.example.shoppingmall.service;

import org.springframework.stereotype.Service;

import com.example.shoppingmall.dto.Cart;
import com.example.shoppingmall.mapper.CartMapper;

@Service
public class CartService {
	private CartMapper cartMapper;
	
	public CartService(CartMapper cartMapper) {
		this.cartMapper = cartMapper;
	}
	
	
	public int insertcart(Cart cart) {
		 return cartMapper.insertcart(cart);
		
	}

}
