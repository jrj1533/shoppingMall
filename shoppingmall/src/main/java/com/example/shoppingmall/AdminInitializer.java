package com.example.shoppingmall;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.example.shoppingmall.dto.Admin;
import com.example.shoppingmall.mapper.AdminMapper;

import jakarta.annotation.PostConstruct;

// "자동 실행용 초기 설정 클래스"
@Component
public class AdminInitializer {
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	// application.priperties 값 주입
	@Value("${admin.id}")
	private String adminId;		// 아이디
	
	@Value("${admin.password}")
	private String adminPassword;
	
	  // 생성자 주입
    public AdminInitializer(AdminMapper adminMapper, PasswordEncoder passwordEncoder) {
        this.adminMapper = adminMapper;
        this.passwordEncoder = passwordEncoder;
    }
    
    
	// 서버가 시작되면 이 메서드가 자동으로 1번 실행
	@PostConstruct
	public void createInitialAdmin() {
		// 관리자 기본 계정 정보 설정
		
		
		try {
			// DB에 이미 관리자 아이디가 있는 지 조회
			Admin existingAdmin = adminMapper.findById(adminId);
			
			// 없으면 새로 생성
			
			if(existingAdmin == null) {
				Admin admin = new Admin();		// 관리자 객체 생성
				admin.setAdminId(adminId);		// 아이디 설정
				admin.setPassword(passwordEncoder.encode(adminPassword));			// 비밀번호 설정
				admin.setRoleNo(1);				// 관리자 권한
				
				adminMapper.insertAdmin(admin);	// DB에 관리자 추가
				
				System.out.println("최초 관리자 계정 생성완료 (아이디:JJY / 비밀번호:)");
				
			} else {
				// 이미 관리자 아이디가 있는 경우
				System.out.println("관리자 계정 이미 존재함 (아이디: admin)");
			}
			
		} catch(Exception e) {
			// 에러가 발생했을 경우 출력(예: DB 연결 오류 등)
			System.out.println("관리자 초기화 중 오류 발생: " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	
}
