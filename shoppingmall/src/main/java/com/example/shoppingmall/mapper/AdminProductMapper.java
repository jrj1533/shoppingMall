package com.example.shoppingmall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminProductMapper {

	List<Map<String, Object>> findRequestingItem(@Param("beginRow") int beginRow , @Param("size") int size); // Requesting  갯수 조회

	int totalfindRequestingItem();  // 전체 갯수 조회

}
