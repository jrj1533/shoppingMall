package com.example.shoppingmall.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.example.shoppingmall.dto.Item;
import com.example.shoppingmall.dto.ItemFile;
import com.example.shoppingmall.dto.ItemOption;
import com.example.shoppingmall.service.ItemService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ItemController {
	private ItemService itemService;
	
	public ItemController(ItemService itemService) {
		this.itemService = itemService;
	}
	
	@GetMapping("/item/register")
	public String productForm(Model model) {
		
		
		List<ItemOption> opts = new ArrayList<>();
		opts.add(new ItemOption());
		model.addAttribute("itemOption", opts);
		
		
		
		
		return "seller/productForm";
	}
	
	@PostMapping("/item/register")
	public String itemRegister(Item item) throws IOException {
	
		int itemNo = itemService.insertItem(item);
		log.info("아이템생성됨");
		log.info("아이템 옵션"+ item.getItemOption());
		List<ItemOption> itemOption = item.getItemOption();
		for(ItemOption i : itemOption) {
			log.info("옵션생성중"+i);
			i.setItemNo(itemNo);
			itemService.insertItemOption(i);
			
		}
		
		List<MultipartFile> itemFile = item.getItemFile();
		for(MultipartFile i : itemFile) {
			log.info("파일 개별저장중" +i);
			
			itemService.insertItemFile(i, itemNo);
			
		}
		
		
		return "";
	}
	
}
