package com.example.shoppingmall.dto;

import lombok.Data;

@Data
public class Paging {
	private int currentPage = 1;	// 현재페이지
	private int rowPerPage = 10;	// 한 페이지에 데이터를 몇개 보여주는 지
	private int beginRow;			// 몇번째 행부터 가져올지
	private int totalCount;			// 전체 데이터 개수
	private int lastPage;			// 총 페이지 수
	private int startPage;			// 시작 페이지
	private int endPage;			// 끝 페이지
	private int pageCount = 10;		// 보여지는 페이지 개수
	
	public void beginRow() {
		// 현재 페이지 기준으로 몇개의 행을 보여주는지 계산
		this.beginRow = (currentPage - 1) * rowPerPage;
	}
	
	public void totalPage() {
		// 전체페이지 개수 (총 데이터 / 한 페이지당 행 수)
		this.lastPage = (int) Math.ceil((double) totalCount / rowPerPage);
		// 현재 페이지가 몇 번째 페이지 그룹에 속하는지 계산
		int pageSize = (currentPage -1) / pageCount;
		// 그 페이지그룹에서 시작 페이지 번호 계산
		this.startPage = pageSize * pageCount + 1;
		// 마지막 페이지 계산에서 전체 페이지 수를 넘지 않게 막는 처리
		this.endPage = Math.min(startPage + pageCount - 1, lastPage);
	}
}
