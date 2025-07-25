package com.example.shoppingmall.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.shoppingmall.dto.OrderCart;
import com.example.shoppingmall.dto.OrderCartItem;
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
									HttpSession session,
									Paging page,
									OrderCartSearch search
									) {
			
			search.setUsername((String) session.getAttribute("username"));
			List<OrderCart> list = orderCartService.OrderCartList(page, search);

			page.beginRow();
			int totalCount = orderCartService.totalCount(search);
			page.setTotalCount(totalCount); // 총 개수 세팅
			page.totalPage();
			
			model.addAttribute("orderCartList", list);
			model.addAttribute("paging", page);
			model.addAttribute("orderCartSearch", search);
			
			// System.out.println("username = " + search.getUsername());
			
			return "buyer/orderCartList";
			
		}
		
		// 주문내역 상세보기
		@GetMapping("/buyer/orderCartDetail")
		@ResponseBody
		public List<OrderCartItem> orderCartDetail(@RequestParam("orderNo") String orderNo,
									  HttpSession session
									  ) {
			String username = (String) session.getAttribute("username");
			return orderCartService.selectOrderCartDetail(username, orderNo);
			
		}
}
