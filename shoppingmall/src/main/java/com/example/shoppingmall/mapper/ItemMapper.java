package com.example.shoppingmall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.shoppingmall.dto.Item;
import com.example.shoppingmall.dto.ItemFile;
import com.example.shoppingmall.dto.ItemOption;

@Mapper
public interface ItemMapper {

	int insertItem(@Param("item") Item item);

	// item Info
	List<Map<String, Object>> itemInfo(int itemNo);
	
	List<ItemFile> itemImg(int itemNo);

	List<ItemOption> itemOption(int itemNo);

}
