package com.example.shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.shoppingmall.service.CancelService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CancelController {
	@Autowired CancelService cancelService;
	
	public CancelController(CancelService cancelService) {
		this.cancelService = cancelService;
	}

	@GetMapping("/cancel")
	public String calcel() {
		
		return "buyer/cancel";
	}
	
	@PostMapping("/cancel")
	public String cancel(@RequestParam int deliveryNo, @RequestParam String reasonCode, @RequestParam String etcReason) {
		// log.info("reasonCode: " + reasonCode);
		cancelService.cancelReason(deliveryNo, reasonCode, etcReason);
		return ""; // 주문리스트로 리다이렉트
	}
}
