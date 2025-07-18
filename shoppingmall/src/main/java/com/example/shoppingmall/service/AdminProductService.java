package com.example.shoppingmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.shoppingmall.mapper.AdminProductMapper;

@Service
public class AdminProductService {
	private AdminProductMapper adminProductMapper;
	
	public AdminProductService(AdminProductMapper adminProductMapper) {
		this.adminProductMapper = adminProductMapper;
	}
	
	// 전체 조회 'REQUESTING' 조회
	public List<Map<String,Object>> findRequestingItem(int beginRow, int size) {
		return adminProductMapper.findRequestingItem(beginRow, size);
	}

	//  전체 조회 'REQUESTING' 개수 조회
	public int totalfindRequestingItem() {
		return adminProductMapper.totalfindRequestingItem();
	}


	
	
	
}
