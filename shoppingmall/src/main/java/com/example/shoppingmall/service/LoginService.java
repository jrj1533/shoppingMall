package com.example.shoppingmall.service;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.shoppingmall.dto.Admin;
import com.example.shoppingmall.dto.User;
import com.example.shoppingmall.mapper.AdminMapper;
import com.example.shoppingmall.mapper.LoginMapper;


@Service
public class LoginService {
	private LoginMapper loginMapper;
	private AdminMapper adminMapper;
	private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	public LoginService(LoginMapper loginMapper, AdminMapper adminMapper) {
		this.loginMapper = loginMapper;
		this.adminMapper = adminMapper;
	}
	
	// 관리자 로그인
	public Admin loginAdmin(Admin adminDto) {						// 정처기 공부하면서 예외처리가 실무에 많이쓰인다 하여 작성
		 System.out.println("=== loginAdmin() 실행됨 ==="); // ← 반드시 찍혀야 함
		// 입력한 아이디로 dto로 전달 db에 조회
		Admin admin = adminMapper.findById(adminDto.getAdminId());
		if (admin == null) {
			System.out.println("입력 ID: " + adminDto.getAdminId());
			// admin id가 없을경우 runtimeException 예외로 컨트롤러에 RuntimeException e 로 가서 예외 처리를 던진다.
			throw new RuntimeException("아이디가 존재하지 않습니다.");
		}
		System.out.println("아이디 조회 결과: " + admin); // null 여부 확인
		if(!passwordEncoder.matches(adminDto.getPassword(), admin.getPassword())) {
			System.out.println("입력 PW: " + adminDto.getPassword());
			System.out.println("DB PW: " + admin.getPassword());
			System.out.println("매치 결과: " + passwordEncoder.matches(adminDto.getPassword(), admin.getPassword()));
			throw new RuntimeException("비밀번호가 틀립니다.");
		}
		
		
		
		
		// 아이디와 비밀번호가 맞을경우 admin 정보 반환
		return admin;
		
	}
	
	
	public int loginUser(String username, String password) { // 아이디 비밀번호 로그인하기
		return loginMapper.loginUser(username,password);
	}

	public User loadUserProfile(String username) { // 로그인관련 정보 가져오기
		return loginMapper.loadUserProfile(username); 
		
	}
	
}
