package com.example.shoppingmall.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
/*
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;*/

/* @EnableWebSecurity*/
@Configuration
public class SecurityConfig {
	// 비밀번호 암호화를 위해 생성
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	
	/*
	 * SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws
	 * Exception { httpSecurity.csrf((csrfConfigure) ->(csrfConfigure).disable());
	 * 
	 * 
	 * httpSecurity.authorizeHttpRequests((a)->
	 * a.requestMatchers("/","WEB-INF/view/**","/").permitAll()
	 * 
	 * );
	 * 
	 * 
	 * 
	 * 
	 * 
	 * httpSecurity.build(); }
	 */
}
