package com.example.shoppingmall.service;

import java.util.List;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.springframework.stereotype.Service;

import com.example.shoppingmall.dto.Item;
import com.example.shoppingmall.mapper.ItemMapper;

@Service
public class ItemService {
	private ItemMapper itemMapper;
	
	public ItemService(ItemMapper itemMapper) {
		this.itemMapper = itemMapper;
	}
	
	public void insertItem(Item item) { // 옵셔 개수만큼 item 삽입
		for(int i=1; i <=item.getOptionNo().size(); i++) {
			 itemMapper.insertItem(item , i);
	
		}
	}

}
