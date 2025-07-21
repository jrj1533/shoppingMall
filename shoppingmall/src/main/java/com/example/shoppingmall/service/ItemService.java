package com.example.shoppingmall.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.shoppingmall.dto.Item;
import com.example.shoppingmall.dto.ItemFile;
import com.example.shoppingmall.dto.ItemOption;
import com.example.shoppingmall.mapper.ItemFileMapper;
import com.example.shoppingmall.mapper.ItemMapper;
import com.example.shoppingmall.mapper.ItemOptionMapper;

import lombok.Data;
import lombok.Value;
import lombok.extern.slf4j.Slf4j;

@Transactional
@Service
@Data
@Slf4j
public class ItemService {
	private ItemMapper itemMapper;
	private ItemOptionMapper itemOptionMapper; 
	private ItemFileMapper itemFileMapper;
	
	@org.springframework.beans.factory.annotation.Value("${file.upload-dir}")
	private String uploadDir;
	
	public ItemService(ItemMapper itemMapper, ItemOptionMapper itemOptionMapper , ItemFileMapper itemFileMapper) {
		this.itemMapper = itemMapper;
		this.itemOptionMapper = itemOptionMapper;
		this.itemFileMapper = itemFileMapper;
	}
	
	public int insertItem(Item item) { // item 삽입
		if(itemMapper.insertItem(item)!= 0) {
			return item.getItemNo();   // 아이템 번호 반환
		}
		
		return 0; 
}

	public int insertItemOption(ItemOption i) {
		if (itemOptionMapper.insertItemOption(i)!= 0) {
			log.info("옵션생성 성공");
			return 1;
		}
		log.info("옵션생성 실패");
		return 0;
	}


	public void insertItemFile(MultipartFile i, int itemNo, int num) throws IOException {
		Path root = Paths.get(uploadDir);
		if(Files.notExists(root)) {
			Files.createDirectories(root);
		} 
		
		String orig = i.getOriginalFilename();
		String ext = orig.substring(orig.lastIndexOf('.'));
		String saved = UUID.randomUUID()+ext;
		i.transferTo(root.resolve(saved).toFile());
		
		ItemFile meta = new ItemFile();
		
		meta.setItemNo(itemNo);
		meta.setFileName(orig);
		meta.setFilePath(root + "/");
		meta.setSaveName(saved);
		meta.setFileSize((int)i.getSize());
		meta.setFileType(ext);
		meta.setFileOrder(num);
		
		itemFileMapper.insertFile(meta);
		
		
		
		

	}
}


