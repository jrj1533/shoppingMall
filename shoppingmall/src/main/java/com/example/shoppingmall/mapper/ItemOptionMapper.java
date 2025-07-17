package com.example.shoppingmall.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.shoppingmall.dto.ItemOption;

@Mapper
public interface ItemOptionMapper {

	int insertItemOption(ItemOption i);

}
