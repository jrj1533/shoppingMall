package com.example.shoppingmall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MainPageMapper {

	int totalCount();

	List<Map<String, Object>> findProductsList(@Param("beginRow") int beginRow, @Param("size") int size);

}
