package com.example.shoppingmall.service;

import org.springframework.stereotype.Service;

import com.example.shoppingmall.dto.User;
import com.example.shoppingmall.mapper.LoginMapper;

@Service
public class LoginService {
	private LoginMapper loginMapper;
	
	public LoginService(LoginMapper loginMapper) {
		this.loginMapper = loginMapper;
	}
	
	
	public int loginUser(String username, String password) { // 아이디 비밀번호 로그인하기
		return loginMapper.loginUser(username,password);
	}

	public User loadUserProfile(String username) { // 로그인관련 정보 가져오기
		return loginMapper.loadUserProfile(username); 
		
	}
	
}
