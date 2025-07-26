package com.example.shoppingmall.restcontroller;

import org.springframework.web.bind.annotation.RestController;

import com.example.shoppingmall.dto.CartDto;
import com.example.shoppingmall.service.CartService;

import jakarta.servlet.http.HttpSession;

import java.util.Collections;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;



@RestController
@RequestMapping("/api")
public class RestCartController {

	private final CartService cartService;
	
	public RestCartController(CartService cartService) {
		this.cartService = cartService;
	}
	
	
	
	@GetMapping("/cart")
	public ResponseEntity<?> cartPage(HttpSession session) {
		
		String username = (String)session.getAttribute("username");
		List<CartDto> result = cartService.selectAllcartByusername(username);
		
		return ResponseEntity.ok(Collections.singletonMap("result", result));
	}
	
	@PostMapping("/cart/delete")
	public ResponseEntity<?> deletecartItem(@RequestParam int cartNo){
		
		cartService.deletecartItem(cartNo);
		
		return ResponseEntity.ok(Collections.singleton("삭제되었습니다."));
		
	}
	
	@PostMapping("/cart/deletecartItems")
	public ResponseEntity<?> deletecartItems(HttpSession session){
		String username =  (String)session.getAttribute("username");
		 if(cartService.deletecartItems(username)!=0) {
			 return ResponseEntity.ok(Collections.singletonMap("msg", "전체 삭제되었습니다."));
		 }
		 
		 return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
				 .body(Collections.singletonMap("message", "삭제를 실패하였습니다."));
				 
	}

} 
