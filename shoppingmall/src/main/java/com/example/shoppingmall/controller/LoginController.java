package com.example.shoppingmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.shoppingmall.service.LoginService;

import jakarta.servlet.http.HttpSession;


@Controller
public class LoginController {
	private LoginService loginService;
	
	public LoginController(LoginService loginService) {
		 this.loginService = loginService;
	}
	
	@GetMapping("/login")  // 로그인 페이지 이동
	public String login() {  
		return "login";
	}
	
	@GetMapping("/logOut")
	public String logout(HttpSession session) {
		
		session.invalidate();
		return "redirect:/login";
	}
	
}
