package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class Page {
	private int rowPerPage = 10;
	private int currentPage = 1;
	private int beginRow;
	private int totalCount;
	private String searchWord; // 검색어
	private String searchType; // 검색타입  
	private String searchName;
	
	private int lastPage;
	private int pageCount = 10; // 한 화면에 보여줄 페이지 번호 개수
	private int startPage;
	private int endPage;
	
	//[장정수] 주문리스트 필터링
	private String buyer;
	private String deliveryStatus;
	private String ordersStatus;
	private String username;
	
	//[장정수] 관리자 배송리스트
	private String seller;
	
	//[장지영] 쿠폰 리스트(관리자)
	private String couponTitle;
	private String couponContent;
	private String couponType;
	private int couponAmount;
	private int couponPercentage;
	
	// 검색, 페이징 공통 (기본생성자를 명시해줘서 다른 클래스에서 사용 가능
	public Page() {
	
	}
	
	//[장정수] 필터링 추가 페이징
	public Page(int rowPerPage, int currentPage, String buyer, String deliveryStatus, String ordersStatus, String username) {
		this.rowPerPage = rowPerPage;
		this.currentPage = currentPage;
		this.beginRow = (currentPage - 1) * rowPerPage;
		this.buyer = buyer;
		this.deliveryStatus = deliveryStatus;
		this.ordersStatus = ordersStatus;
		this.username = username;
	}

	//[장정수] 관리자 배송조회
	public Page(int size, int page, String seller, String buyer) {
		this.rowPerPage = rowPerPage;
		this.currentPage = currentPage;
		this.beginRow = (currentPage - 1) * rowPerPage;
		this.buyer = seller;
		this.buyer = buyer;
	}
	
	//[유빈] 승인전 상품 조회
	public Page(int rowPerPage, int currentPage) {
		this.rowPerPage = rowPerPage;
		this.currentPage = currentPage;
		this.beginRow = (currentPage-1)*rowPerPage;
	}
	
	//[장지영] page 계산
	public void setBeginRow() {
		this.beginRow = (currentPage - 1) * rowPerPage;
	}
	


	
}
