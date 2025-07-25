package com.example.shoppingmall.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.shoppingmall.dto.OrderCart;
import com.example.shoppingmall.dto.OrderCartItem;
import com.example.shoppingmall.dto.OrderCartSearch;
import com.example.shoppingmall.dto.Paging;
import com.example.shoppingmall.mapper.OrderCartMapper;

@Service
public class OrderCartService {
		// 의존성 주입
		private final OrderCartMapper orderCartMapper;
		
		// 생성자 주입
		public OrderCartService(OrderCartMapper orderCartMapper) {
			this.orderCartMapper = orderCartMapper;
		}
		
		// 주문내역 리스트
		public List<OrderCart> OrderCartList(Paging page, OrderCartSearch orderCartSearch) {
			return orderCartMapper.selectOrderCartList(page, orderCartSearch);
		}
		
		// 주문내역 리스트 총 개수
		public int totalCount(OrderCartSearch orderCartSearch) {
			return orderCartMapper.totalCount(orderCartSearch);
		}
		
		// 주문내역 상세보기
		public List<OrderCartItem> selectOrderCartDetail(String username, String orderNo) {
			
			 System.out.println("username: " + username);
			    System.out.println("orderNo: " + orderNo);
			return orderCartMapper.selectOrderCartDetail(username, orderNo);
		}

}
