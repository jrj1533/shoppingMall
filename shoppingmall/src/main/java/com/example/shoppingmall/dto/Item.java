package com.example.shoppingmall.dto;

import java.util.ArrayList;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import lombok.Data;

@Data
public class Item {
	private int itemNo;
	private String category;
	private String username;
	private String itemTitle;
	private String itemContent;
	private String itemAmount;
	private String status;
	private String createDate;
	
	private List<ItemOption> itemOption = new ArrayList<>();
	private List<MultipartFile> itemFile = new ArrayList<>();
}
