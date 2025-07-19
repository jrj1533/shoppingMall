package com.example.shoppingmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.shoppingmall.dto.Admin;
import com.example.shoppingmall.dto.Page;
import com.example.shoppingmall.mapper.AdminMapper;

@Service
public class AdminService {
	@Autowired AdminMapper adminMapper;
	
	// 배송리스트 페이징
	public int totalCount(Page paging) {
		return adminMapper.totalCount(paging);
	}
	
	// 배송리스트
	public List<Map<String, Object>> deliveryList(int beginRow, int size, String seller, String buyer) {
		return adminMapper.deliveryList(beginRow, size, seller, buyer);
	}
	
	// 관리자 리스트
	public List<Admin> adminList() {
		return adminMapper.adminList();
	}
	
	// 관리자 생성
	public int insertAdmin(Admin admin) {
		return adminMapper.insertAdmin(admin);
	}
	
	// 관리자 아이디 중복확인
	public int adminIdCheck(String adminId) {
		return adminMapper.adminIdCheck(adminId);
	}
}
