package com.example.shoppingmall.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.shoppingmall.dto.User;

@Mapper
public interface LoginMapper {

	int loginUser(@Param("username")String username, @Param("password") String password); // 로그인

	User loadUserProfile(String username); // 로그인 정보 가져오기
	 

}
