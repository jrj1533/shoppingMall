package com.example.shoppingmall.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.shoppingmall.dto.Cart;

@Mapper
public interface CartMapper {

	int insertcart(Cart cart);

}
