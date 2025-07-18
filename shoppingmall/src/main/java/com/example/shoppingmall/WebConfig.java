package com.example.shoppingmall;

import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.unit.DataSize;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.apache.catalina.connector.Connector;

import jakarta.servlet.MultipartConfigElement;



@Configuration
public class WebConfig implements WebMvcConfigurer{
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/uploads/**") // 클라이언트의 uploads/** 요청을 서버 실행 디렉토리 uploads 폴더에 있는 파일 매핑하여 서빙
		.addResourceLocations("file:uploads/");
	
	}

	/*
	 * @Bean public ServletRegistrationBean<DispatcherServlet>
	 * dispatcherRegistration(DispatcherServlet dispatcherServlet) {
	 * MultipartConfigFactory factory = new MultipartConfigFactory(); // 개별 파일 최대 크기
	 * factory.setMaxFileSize(DataSize.ofMegabytes(20)); // 전체 요청 최대 크기
	 * factory.setMaxRequestSize(DataSize.ofMegabytes(100));
	 * 
	 * // (Tomcat 구현체에서 지원하는 확장 옵션) multipart 파트 개수 제한 해제 MultipartConfigElement
	 * multipartConfig = factory.createMultipartConfig();
	 * ServletRegistrationBean<DispatcherServlet> registration = new
	 * ServletRegistrationBean<>(dispatcherServlet);
	 * registration.setMultipartConfig(multipartConfig); return registration; }
	 */
	

	
}
