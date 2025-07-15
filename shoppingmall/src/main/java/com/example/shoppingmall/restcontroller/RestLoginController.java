package com.example.shoppingmall.restcontroller;

import java.util.Collections;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.shoppingmall.dto.User;
import com.example.shoppingmall.service.LoginService;

import jakarta.servlet.http.HttpSession;

@RestController
public class RestLoginController {
	private LoginService loginService;
	
	public RestLoginController(LoginService loginService) {
		 this.loginService = loginService;
	}
	
	@PostMapping("/loginAction")
	public ResponseEntity<?> loginAction(@RequestParam String username, @RequestParam String password,
			HttpSession session) {
		if(loginService.loginUser(username,password) == 1) {
			User user =loginService.loadUserProfile(username);
			
			
			session.setAttribute("username", username); // 로그인 id 저장
			session.setAttribute("name", user.getName());
			session.setAttribute("roleNo", user.getRoleNo());
			
			return ResponseEntity.ok(Collections.singletonMap("redirectUrl", "/mainPage"));
		}
		
		return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
				.body(Collections.singletonMap("message", "아이디 또는 비밀번호가 올바르지 않습니다"));
	}
}
