package com.example.shoppingmall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.shoppingmall.dto.ProductOptionListDto;

@Mapper
public interface MainPageMapper {

	// 최신 상품 전체 데이터 조회
	int totalCount();

	// 최신 상품 조회
	List<Map<String, Object>> findProductsList(@Param("beginRow") int beginRow, @Param("size") int size);

	// 상품 재고가 0이 아닌 옵션 조회 
	ProductOptionListDto findProductsOption(int itemNo);

}
