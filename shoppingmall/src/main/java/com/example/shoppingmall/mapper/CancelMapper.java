package com.example.shoppingmall.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CancelMapper {

	void insertCancelReason(int deliveryNo, String reasonCode, String etcReason);

}
