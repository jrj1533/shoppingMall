package com.example.shoppingmall.service;

import java.util.List;

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
		int result = 0;
		if(cartMapper.existsByItemNo(cart)){
			result = cartMapper.updatecartCount(cart); // itemNo와 optionNo 가 같은것이 있으면 update를 해줘야한다. 
			
		} else { 
			result = cartMapper.insertcart(cart);   // cart를 추가한다.
		}
		
		return result;
	}


	public List<Cart> selectAllcartByusername(String username) {
		return null;
		// TODO Auto-generated method stub
		
	}

}
