package com.example.shoppingmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.shoppingmall.dto.ItemOption;

@Mapper
public interface ItemOptionMapper {

	int insertItemOption(ItemOption i);

	// 상품상세페이지 옵션
	List<ItemOption> optionsByItem(int itemNo);

}
