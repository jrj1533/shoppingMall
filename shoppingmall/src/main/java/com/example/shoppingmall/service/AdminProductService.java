package com.example.shoppingmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.format.datetime.DateFormatter;
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
		List<Map<String, Object>> findRequestingItem = adminProductMapper.findRequestingItem(beginRow, size);
		for( Map<String, Object> row  :findRequestingItem) {
		Object raw = row.get("createDate");
		if( raw == null) continue;
		
		String s = raw.toString().replace("T", " ");
	
		row.put("createDate", s);
			}
		
		return findRequestingItem;
	
			
	}

	//  전체 조회 'REQUESTING' 개수 조회
	public int totalfindRequestingItem() {
		return adminProductMapper.totalfindRequestingItem();
	}

	
	// 승인 상태로 변환
	public void approveItem(int itemNo) {
		adminProductMapper.approveItem(itemNo);
		
	}

	public void notApproveItem(int itemNo) {
		adminProductMapper.notApproveItem(itemNo);
		
	}


	
	
	
}
