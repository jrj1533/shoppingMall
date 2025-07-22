package com.example.shoppingmall.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.example.shoppingmall.mapper.MainPageMapper;

@Service
public class MainPageService{

	private MainPageMapper mainPageMapper;
	
	public MainPageService(MainPageMapper mainPageMapper) {
		this.mainPageMapper = mainPageMapper;
	}
	
	
	public int totalCount() {
		return mainPageMapper.totalCount(); // 허용된 아이템 개수찾기
	}

	
	public List<Map<String,Object>> findProductsList(int beginRow, int size ){
		List<Map<String,Object>> list  =   mainPageMapper.findProductsList(beginRow, size);
	    
	    for (Map<String,Object> row : list) {
	        String file = Objects.toString(row.get("saveName"), "");
	        // 1) 맨 앞에 slash를 붙이고,
	        // 2) contextPath가 없다면 "/" 로 시작하도록
	        row.put("saveName", "/upload/" + file);
	    }
		 	
		 	return list;
	}
	
	
}
