package com.example.shoppingmall;

import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

public class WebConfig implements WebMvcConfigurer{
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/uploads/**") // 클라이언트의 uploads/** 요청을 서버 실행 디렉토리 uploads 폴더에 있는 파일 매핑하여 서빙
		.addResourceLocations("file:uploads/");
	
	}
	
}
