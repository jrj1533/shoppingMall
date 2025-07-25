package com.example.shoppingmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.shoppingmall.dto.OrderCart;
import com.example.shoppingmall.dto.OrderCartItem;
import com.example.shoppingmall.dto.OrderCartSearch;
import com.example.shoppingmall.dto.Paging;

@Mapper
public interface OrderCartMapper {
		
	// 구매내역 리스트(페이징 + 검색 포함)
	List<OrderCart> selectOrderCartList(@Param("page") Paging page, 
									@Param("search") OrderCartSearch orderCartSearch);
	
	// 구매내역 리스트 총 개수
	int totalCount(@Param("search") OrderCartSearch orderCartSearch);
	
	// 구매내역 상세보기
	int selectOrderCartDetail(int orderNo);

	List<OrderCartItem> selectOrderCartDetail(@Param("username") String username,
            								  @Param("orderNo") String orderNo);
}
