package com.example.shoppingmall.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.example.shoppingmall.dto.Item;
import com.example.shoppingmall.dto.ItemFile;
import com.example.shoppingmall.dto.ItemOption;
import com.example.shoppingmall.service.ItemService;

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
		  int num = 1; 
		  for(MultipartFile file :itemFile){
		  if(file != null && !file.isEmpty()) { 
		  log.info("파일 개별저장중" +file);
		  itemService.insertItemFile(file, itemNo, num);
		  
		  num++;
		  }
		  
		}

		return "redirect:/mainPage";
	}
	
	// 상세페이지
	@GetMapping("/item/detail/{itemNo}")
	public String itemDetail(Model model, @PathVariable int itemNo) {
		
		// item 정보가져오기
		List<Map<String,Object>> itemInfoList = itemService.itemInfo(itemNo);
		
		Map<String, Object> itemInfo = null;
		   if (itemInfoList != null && !itemInfoList.isEmpty()) {
		       itemInfo = itemInfoList.get(0); // 첫 번째 항목만 사용
		   }
		//log.info("itemInfo:" + itemInfo);
		
		// item-file(이미지)
		List<ItemFile> itemFile = itemService.itemImg(itemNo);
		//log.info("itemFile:" + itemFile);
		
		// item-option(옵션가져오기)
		List<ItemOption> itemOption = itemService.itemOption(itemNo);
		//log.info("itemOption:" + itemOption);
		
		model.addAttribute("itemNo", itemNo);
		model.addAttribute("itemInfo", itemInfo);
		model.addAttribute("itemFile", itemFile);
		model.addAttribute("itemOption", itemOption);
		return "/seller/itemDetail";
	}
	
}
