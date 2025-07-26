package com.example.shoppingmall.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.shoppingmall.dto.Cart;

@Mapper
public interface CartMapper {

	int insertcart(Cart cart); // 카트 목록에 추가

	boolean existsByItemNo(Cart cart); // 확인작업

	int updatecartCount(Cart cart); // 카트 수량 업데이트 하기


}
