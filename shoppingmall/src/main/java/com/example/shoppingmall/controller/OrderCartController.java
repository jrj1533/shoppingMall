package com.example.shoppingmall.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.shoppingmall.dto.OrderCart;
import com.example.shoppingmall.dto.OrderCartSearch;
import com.example.shoppingmall.dto.Paging;
import com.example.shoppingmall.service.OrderCartService;

import jakarta.servlet.http.HttpSession;

@Controller
public class OrderCartController {
		// 의존성 주입
		private final OrderCartService orderCartService;
		
		// 생성자 주입
		public OrderCartController(OrderCartService orderCartService) {
			this.orderCartService = orderCartService;
		}
		
		// 주문내역 리스트
		@GetMapping("/buyer/orderCartList")
		public String orderCartList(Model model,
									HttpSession seesion,
									Paging page,
									OrderCartSearch search
									) {
			page.beginRow();
			
			List<OrderCart> list = orderCartService.OrderCartList(page, search);
			int totalCount = orderCartService.totalCount(search);
			page.totalPage();
			
			model.addAttribute("orderCartList", list);
			model.addAttribute("paging", page);
			model.addAttribute("orderCartSearch", search);
			
			
			
			return "buyer/orderCartList";
			
		}
}
