package com.example.shoppingmall.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.shoppingmall.dto.ItemFile;

@Mapper
public interface ItemFileMapper {

	int insertFile(ItemFile meta);

}
