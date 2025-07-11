package com.example.shoppingmall.service;

import org.springframework.stereotype.Service;

import com.example.shoppingmall.mapper.LoginMapper;

@Service
public class LoginService {
	private LoginMapper loginMapper;
	
	public LoginService(LoginMapper loginMapper) {
		this.loginMapper = loginMapper;
	}
	
	public int loginUser(String username, String password) {
		loginMapper.loginUser(username,password);
	}
	
	
}
