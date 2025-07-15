package com.example.shoppingmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.shoppingmall.dto.Page;
import com.example.shoppingmall.mapper.SellerMapper;

@Service
public class SellerService {
	@Autowired SellerMapper sellerMapper;

	public int totalCount(Page paging) {
		return sellerMapper.totalCount(paging);
	}

	public List<Map<String, Object>> orderList(int beginRow, int size, String username, String buyer, String deliveryStatus, String ordersStatus) {
		
		return sellerMapper.selectOrderList(beginRow, size, username, buyer, deliveryStatus, ordersStatus);
	}

}
