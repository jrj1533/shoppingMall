package com.example.shoppingmall.restcontroller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.shoppingmall.dto.Page;
import com.example.shoppingmall.service.MainPageService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api")
public class RestMainPageController {

private MainPageService mainPageService;

public RestMainPageController(MainPageService mainPageService) {
	this.mainPageService = mainPageService;
}

/*	@GetMapping("/session")
	public Map<String,Object> getSession(HttpSession session){
		Map<String, Object> data = new HashMap<>();
		data.put("roleNo", session.getAttribute("roleNo"));
		data.put("name", session.getAttribute("name"));
		return data;
	}*/

@GetMapping("/products")
public Map<String, Object> list(
    @RequestParam(defaultValue = "1") int page,
    @RequestParam(defaultValue = "10") int size) {

 
	
  int totalCount = mainPageService.totalCount();
  int lastPage = totalCount/size;
  if(totalCount % size != 0) {
	  lastPage += 1;
  }

  // 블록 페이지 계산
  int blockSize = 10;
  int blockIndex = (page - 1) / blockSize;
  int startPage = blockIndex * blockSize + 1;
  int endPage   = Math.min(startPage + blockSize - 1, lastPage);

  // 조회 시작 위치
  int beginRow = (page - 1) * size;
  log.info("endPage:"+endPage);
  // 정렬 파라미터 전달
  List<Map<String,Object>> products = mainPageService.findProductsList(beginRow, size);

  Map<String,Object> result = new HashMap<>();
  result.put("size", size);
  result.put("currentPage", page);
  result.put("startPage", startPage);
  result.put("endPage", endPage);
  result.put("products", products);
  
 
  return result;
}
}