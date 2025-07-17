package com.example.shoppingmall.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
		int totalPages = (int) Math.ceil((double) totalCount / size);
		
		
		List<Map<String, Object>> orderList = sellerService.orderList(paging.getBeginRow(), size, username
				, buyer, deliveryStatus, ordersStatus);
		
		// 주문일의 출력 형태
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		for (Map<String, Object> order : orderList) {
			Object dateObj = order.get("orderDate");

			if (dateObj instanceof LocalDateTime) {
				order.put("orderDateStr", ((LocalDateTime) dateObj).format(formatter));
			} else if (dateObj instanceof String) {
				try {
					LocalDateTime parsed = LocalDateTime.parse((String) dateObj);
					order.put("orderDateStr", parsed.format(formatter));
				} catch (Exception e) {
					order.put("orderDateStr", dateObj);
				}
			} else if (dateObj instanceof java.sql.Timestamp) {
				LocalDateTime orderDate = ((java.sql.Timestamp) dateObj).toLocalDateTime();
				order.put("orderDateStr", orderDate.format(formatter));
			}
		}
		// System.out.println("username:" + username);
		model.addAttribute("username", session.getAttribute("username"));
		model.addAttribute("buyer", buyer);
		model.addAttribute("deliveryStatus", deliveryStatus);
		model.addAttribute("ordersStatus", ordersStatus);
		model.addAttribute("orderList", orderList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

		return "seller/orderList";
	}
	
	// 주문리스트에서 배송준비중 -> 배송중으로 변경
	@PostMapping("/seller/startDelivery")
	public String startDelivery(HttpSession session, @RequestParam  Integer deliveryNo
								, @RequestParam  Integer orderNo) {
		
		String username = (String) session.getAttribute("username");
		System.out.println("deliveryNo:" + deliveryNo);
		System.out.println("orderNo:" + orderNo);
		
		sellerService.startDelivery(deliveryNo, orderNo);
		
		return "redirect:/seller/orderList";
	}
}
