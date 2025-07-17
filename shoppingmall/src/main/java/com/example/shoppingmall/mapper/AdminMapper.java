package com.example.shoppingmall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.shoppingmall.dto.Page;

@Mapper
public interface AdminMapper {

	int totalCount(Page paging);

	// 배송리스트
	List<Map<String, Object>> deliveryList(int beginRow, int size, String seller, String buyer);

}
