package com.example.shoppingmall.restcontroller;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.shoppingmall.dto.Admin;
import com.example.shoppingmall.service.AdminService;

@RestController
@RequestMapping("/admin") // 기본 url을 admin으로 지정
public class AdminListController {
	// 의존성 주입 - filnal로 해야 한번 주입되면 변경 불가 -> 안정성과 코드 올라감 ( 강사님도 실무에서는 fianl은 쓴다고함)
	private final AdminService adminService;
	private final BCryptPasswordEncoder passwordEncoder;
	
	// 생성자 생성
	public AdminListController(AdminService adminService, BCryptPasswordEncoder passwordEncoder) {
		this.adminService = adminService;
		this.passwordEncoder = passwordEncoder;
	}
	
	@PostMapping("/add")
	// ajax를 쓰면 JSON 형태로 데이터를 받을때 RequestBody 써야 자동으로 객체로 변환
	public String addAdmin(@RequestBody Admin admin) {
		
		// 아이디 중복확인
		if(adminService.adminIdCheck(admin.getAdminId()) > 0) {
			return "이미 존재하는 아이디입니다.";
		}
		// 입력한 비밀번호를 암호화
		admin.setPassword(passwordEncoder.encode(admin.getPassword()));
		// db에 저장
		adminService.insertAdmin(admin);
		return "관리자 등록 성공";
	}
	
}
