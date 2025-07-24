package com.example.shoppingmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.shoppingmall.dto.ItemOption;
import com.example.shoppingmall.mapper.ItemOptionMapper;

@Service
public class ItemOptionService {
	public ItemOptionService(ItemOptionMapper itemOptionMapper) {
		this.itemOptionMapper = itemOptionMapper;
	}

	@Autowired ItemOptionMapper itemOptionMapper;

	public List<ItemOption> optionsByItem(int itemNo) {
		return itemOptionMapper.optionsByItem(itemNo);
	}

}
