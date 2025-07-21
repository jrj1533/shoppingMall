package com.example.shoppingmall.restcontroller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.shoppingmall.service.AdminProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class RestAdminProductController {
  private AdminProductService adminProductService;
	
  public RestAdminProductController(AdminProductService adminProductService) {
	   this.adminProductService = adminProductService;
  }
  
  
	@PostMapping("/items/approve")
	public ResponseEntity<String> itemapprove(@RequestParam int itemNo 
			, @RequestParam(defaultValue = "list") String view ) {
		log.info( "itemNO:"+itemNo);
		adminProductService.approveItem(itemNo); 
		return ResponseEntity.ok(view);
	}
	
	@PostMapping("/items/notapprove")
	public ResponseEntity<String> itemnotApprove(@RequestParam int itemNo, @RequestParam  String view){
		adminProductService.notApproveItem(itemNo);
		
		return ResponseEntity.ok(view);
		
	}
}
