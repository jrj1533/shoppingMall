package com.example.shoppingmall.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.shoppingmall.dto.ItemOption;
import com.example.shoppingmall.service.ItemOptionService;

@RestController
@RequestMapping("/api/item")
public class RestItemDetailController {
	@Autowired ItemOptionService itemOptionService;


	@GetMapping("/detail/{itemNo}")
	public List<ItemOption> getItemOptions(@PathVariable int itemNo) {
        
        return itemOptionService.optionsByItem(itemNo);
	}
}
