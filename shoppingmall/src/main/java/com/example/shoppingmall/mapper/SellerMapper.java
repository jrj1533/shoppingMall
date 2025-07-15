package com.example.shoppingmall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.shoppingmall.dto.Page;
@Mapper
public interface SellerMapper {

	List<Map<String, Object>> selectOrderList(int beginRow, int size, String username, String buyer, String deliveryStatus, String ordersStatus);

	int totalCount(Page paging);

}
