package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class ItemFile {
	private int fileNo;
	private int itemNo;
	private String fileName;
	private String filePath;
	private String saveName;
	private int fileSize;
	private String fileType;
}
