package com.example.shoppingmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.shoppingmall.mapper.CancelMapper;

@Service
public class CancelService {
	@Autowired CancelMapper cancelMapper;

	public CancelService(CancelMapper cancelMapper) {
		this.cancelMapper = cancelMapper;
	}

	public void cancelReason(int deliveryNo, String reasonCode, String etcReason) {
		if("ETC".equals(reasonCode)) {
			reasonCode = "ETC";
		} else {
			etcReason = null;
		}
		
		cancelMapper.insertCancelReason(deliveryNo, reasonCode, etcReason);
	}

}
