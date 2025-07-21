package com.example.shoppingmall.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.shoppingmall.dto.Page;
import com.example.shoppingmall.service.AdminProductService;

@Controller
public class AdminProductController {
	private AdminProductService adminProductService;
	
	public AdminProductController(AdminProductService adminProductService) {
		this.adminProductService = adminProductService;
	}
	
	@GetMapping("/admin/product")
	public String productManagement(
	        Model model,
	        @RequestParam(defaultValue = "1") int page,
	        @RequestParam(defaultValue = "10") int size,
	        @RequestParam(defaultValue = "list") String view ) {

	    // 1) 전체 건수와 마지막 페이지 계산
	    int totalCount = adminProductService.totalfindRequestingItem();
	    int lastPage   = totalCount / size + (totalCount % size == 0 ? 0 : 1);

	    // 2) 페이지 블록 단위 계산 (한 블록에 표시할 페이지 수는 10)
	    int blockSize  = 10;
	    int blockIndex = (page - 1) / blockSize;           // 0-based
	    int startPage  = blockIndex * blockSize + 1;       // ex) blockIndex=0→1, 1→11
	    int endPage    = Math.min(startPage + blockSize - 1, lastPage);

	    // 3) 실제 데이터 조회
	    Page paging    = new Page(size, page);
	    int beginRow   = paging.getBeginRow();
	    List<Map<String,Object>> requestingItem =
	    adminProductService.findRequestingItem(beginRow, size);
	    
	    
	    // 4) 모델에 담아서 JSP로 전달
	    model.addAttribute("requestingItem", requestingItem);
	    model.addAttribute("currentPage",   page);
	    model.addAttribute("lastPage",      lastPage);
	    model.addAttribute("startPage",     startPage);
	    model.addAttribute("endPage",       endPage);
	    model.addAttribute("view", view);
	    
	    return "admin/productManagement";
	}

}
