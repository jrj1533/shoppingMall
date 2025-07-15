package com.example.shoppingmall.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.shoppingmall.dto.Page;
import com.example.shoppingmall.service.SellerService;

import jakarta.servlet.http.HttpSession;

@Controller
public class SellerController {

	@Autowired SellerService sellerService;
	
	@GetMapping("/seller/orderList")
	public String orderList(Model model, HttpSession session
			,@RequestParam(defaultValue = "1") int page
			,@RequestParam(defaultValue = "10") int size
			,@RequestParam(required  = false) String buyer
			,@RequestParam(required  = false) String deliveryStatus
			,@RequestParam(required  = false) String ordersStatus) {
		
		String username = (String) session.getAttribute("username");
		
		Page paging = new Page(size, page, buyer, deliveryStatus, ordersStatus);
		int totalCount = sellerService.totalCount(paging);
		
		
		List<Map<String, Object>> orderList = sellerService.orderList(paging.getBeginRow(), size, username
				, buyer, deliveryStatus, ordersStatus);
		// System.out.println("username:" + username);
		model.addAttribute("username", session.getAttribute("username"));
		model.addAttribute("buyer", buyer);
		model.addAttribute("deliveryStatus", deliveryStatus);
		model.addAttribute("ordersStatus", ordersStatus);
		model.addAttribute("orderList", orderList);

		return "seller/orderList";
	}
}
