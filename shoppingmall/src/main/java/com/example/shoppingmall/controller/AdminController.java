package com.example.shoppingmall.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.shoppingmall.dto.Admin;
import com.example.shoppingmall.dto.Page;
import com.example.shoppingmall.service.AdminService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminController {
	
	@Autowired AdminService adminService;
	public AdminController(AdminService adminService) {
		this.adminService = adminService;
	}

	@GetMapping("/admin/deliveryList")
	public String deliveryList(Model model
			, @RequestParam(defaultValue = "1") int page
			, @RequestParam(defaultValue = "10") int size
			, @RequestParam(required = false, defaultValue = "") String seller
			, @RequestParam(required = false, defaultValue = "") String buyer) {
		
		Page paging = new Page(size, page, seller, buyer);
		int totalCount = adminService.totalCount(paging);
		int totalPages = (int) Math.ceil((double) totalCount / size);
		
		// 리스트
		List<Map<String, Object>> deliveryList = adminService.deliveryList(paging.getBeginRow(), size,
				seller, buyer);
		
		model.addAttribute("currentPage", page);
		model.addAttribute("seller", seller);
		model.addAttribute("buyer", buyer);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("deliveryList", deliveryList);

		return "/admin/deliveryList";
	}
	
	// 관리자 리스트 출력
	@GetMapping("/admin/adminList")
	public String adminList(Model model) {
		List<Admin> adminList = adminService.adminList();
		
		model.addAttribute("adminList", adminList);
		
		return "/admin/adminList";
	}
	
	// 관리자 생성
}
