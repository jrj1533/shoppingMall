package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class User {
	private int userNo;
	private int roleNo;
	private String username;
	private String password;
	private String userEmail;
	private String name;
	private String userPhone;
	private String userBirthday;
	private int userPoint;
	private String createDate;
	private String updateDate;
	private String role;
}
