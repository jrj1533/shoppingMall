package com.example.shoppingmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.shoppingmall.dto.Admin;
import com.example.shoppingmall.service.LoginService;

import jakarta.servlet.http.HttpSession;


@Controller
public class LoginController {
	private LoginService loginService;
	
	public LoginController(LoginService loginService) {
		 this.loginService = loginService;
	}
	
	// 관리자 로그인
	@GetMapping("/admin/loginAdmin")
	public String loginAdmin() {
		return "admin/loginAdmin";
	}
	
	@PostMapping("/admin/loginAdmin")
	public String loginAdmin(Admin adminDto, 
							 HttpSession session,
							 RedirectAttributes ra) {
		try {
			// 서비스에서 정보 호출
			Admin loginAdmin = loginService.loginAdmin(adminDto);
			
			// 로그인 성공 시 세션에 저장
			session.setAttribute("loginAdmin", loginAdmin.getAdminId());
			session.setAttribute("name", loginAdmin.getAdminId());
			session.setAttribute("roleNo", loginAdmin.getRoleNo());
			
			// 로그인 후 관리자 메인페이지로 이동
			return "redirect:/mainPage";
			
			// 서비스에서 아이디 와 비밀번호 틀린정보 예외처리를 받아
		} catch (RuntimeException e) {
			// 로그인 실패 시 RedirectAttributes ra 선언한 걸로 메시지 출력
			ra.addFlashAttribute("errorMessage", e.getMessage());
			
			// 다시 로그인 페이지로 리다이렉트( 로그인 경우 post 요청으로 새로고침 방지)
			return "redirect:/admin/loginAdmin";
		}
		
		
	}
	
	
	// user 로그인
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
