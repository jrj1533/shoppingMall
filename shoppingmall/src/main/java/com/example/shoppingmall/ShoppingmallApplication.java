package com.example.shoppingmall;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class ShoppingmallApplication {

	public static void main(String[] args) {
		SpringApplication.run(ShoppingmallApplication.class, args);
	}

}
