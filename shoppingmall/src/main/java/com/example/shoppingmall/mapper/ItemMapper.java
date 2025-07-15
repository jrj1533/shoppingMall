package com.example.shoppingmall.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.shoppingmall.dto.Item;

@Mapper
public interface ItemMapper {

	int insertItem(@Param("item") Item item, @Param("num") int num);
}
