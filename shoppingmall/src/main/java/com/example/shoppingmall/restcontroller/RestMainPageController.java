	package com.example.shoppingmall.restcontroller;
	
	import java.util.Collections;
import java.util.HashMap;
	import java.util.List;
	import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.apache.ibatis.annotations.Param;
	import org.springframework.ui.Model;
	import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
	import org.springframework.web.bind.annotation.RequestParam;
	import org.springframework.web.bind.annotation.RestController;

import com.example.shoppingmall.dto.Cart;
import com.example.shoppingmall.dto.Page;
	import com.example.shoppingmall.dto.ProductOptionListDto;
import com.example.shoppingmall.service.CartService;
import com.example.shoppingmall.service.MainPageService;
	
	import jakarta.servlet.http.HttpSession;
	import lombok.extern.slf4j.Slf4j;
	
	@Slf4j
	@RestController
	@RequestMapping("/api")
	public class RestMainPageController {
	
	private MainPageService mainPageService;
	private CartService cartService;
	
	public RestMainPageController(MainPageService mainPageService, CartService cartService) {
		this.mainPageService = mainPageService;
		this.cartService = cartService;
	}



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
	 // log.info("endPage:"+endPage);
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

	 @GetMapping(value = "/productsOption", produces = MediaType.APPLICATION_JSON_VALUE)
	 public ProductOptionListDto productsOption(@RequestParam int itemNo){
		   ProductOptionListDto  list = mainPageService.findProductsOption(itemNo);
		   return list;
	 }
 
	 
	 @PostMapping("/insertCart")
	 public ResponseEntity<?> insertCart(Cart cart, HttpSession session) {
		 
		 String username = (String) session.getAttribute("username");
		 cart.setUsername(username);
		 
		 if(cartService.insertcart(cart) == 1) {
			 return ResponseEntity.ok(Collections.singletonMap("message", "입력성공"));
		 }
		 
		 return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body
				 (Collections.singletonMap("message","입력실패"));
	 }
 
}