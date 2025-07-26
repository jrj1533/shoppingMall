package com.example.shoppingmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.shoppingmall.dto.Cart;
import com.example.shoppingmall.dto.CartDto;

@Mapper
public interface CartMapper {

	int insertcart(Cart cart); // 카트 목록에 추가

	boolean existsByItemNo(Cart cart); // 확인작업

	int updatecartCount(Cart cart); // 카트 수량 업데이트 하기

	List<CartDto> findCartByUsername(String username); // 전체 카트 항목 불러오기

	void deletecartItem(int cartNo);  // 카트 아이템 삭제

	int deletecartItems(String username); // 전체 카트 아이템 삭제

	



}
