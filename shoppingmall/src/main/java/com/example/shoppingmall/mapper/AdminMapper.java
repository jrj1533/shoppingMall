package com.example.shoppingmall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.shoppingmall.dto.Admin;
import com.example.shoppingmall.dto.AdminLogin;
import com.example.shoppingmall.dto.Page;

@Mapper
public interface AdminMapper {

	int totalCount(Page paging);

	// 배송리스트
	List<Map<String, Object>> deliveryList(int beginRow, int size, String seller, String buyer);
	
	// 관리자 추가
	int insertAdmin(Admin admin);

	// 관리자 로그인
	Admin loginAdmin(AdminLogin dto);
	
	// 관리자 정보 조회
	Admin adminProfile(String adminId);
	
	// 관리자 리스트(인원이 많지 않아서 map으로 안받음)
	List<Admin> adminList();
	
	// 관리자 아이디 중복확인
	int adminIdCheck(String adminId);

}
