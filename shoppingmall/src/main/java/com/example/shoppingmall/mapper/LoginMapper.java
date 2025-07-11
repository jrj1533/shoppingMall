package com.example.shoppingmall.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginMapper {

	int loginUser(String username, String password); // 로그인

}
