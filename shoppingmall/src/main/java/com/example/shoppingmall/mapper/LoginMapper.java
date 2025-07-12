package com.example.shoppingmall.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LoginMapper {

	int loginUser(@Param("username")String username, @Param("password") String password); // 로그인
	 

}
