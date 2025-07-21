<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송 조회</title>

<style>
	body {
		font-family: 'Noto Sans KR', sans-serif;
		background-color: #f9f9f9;
		color: #333;
		padding: 20px;
	}
	
	h1 {
		text-align: center;
		margin-bottom: 30px;
		color: #2c3e50;
	}
	
	/* 검색 폼 스타일 */
	form {
		display: flex;
		gap: 10px;
		justify-content: center;
		flex-wrap: wrap;
		margin-bottom: 20px;
	}
	
	form input[type="text"] {
		padding: 6px 10px;
		border: 1px solid #ccc;
		border-radius: 4px;
	}
	
	form button {
		padding: 6px 16px;
		background-color: #4CAF50;
		color: white;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		transition: background-color 0.3s;
	}
	
	form button:hover {
		background-color: #45a049;
	}
	
	/* 테이블 스타일 */
	table {
		width: 100%;
		border-collapse: collapse;
		background-color: #fff;
		box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
		table-layout: fixed;
	}
	
	th, td {
		padding: 10px 8px;
		border: 1px solid #ddd;
		text-align: center;
		word-break: break-word;
	}
	
	th {
		background-color: #f2f2f2;
		color: #333;
	}
	
	tr:nth-child(even) {
		background-color: #f9f9f9;
	}
	
	tr:hover {
		background-color: #eef;
	}
	
	/* 배송 상태 강조 */
	td {
		font-size: 14px;
	}
	
	td button {
		padding: 4px 10px;
		border: none;
		border-radius: 4px;
		background-color: #3498db;
		color: white;
		cursor: pointer;
		transition: background-color 0.2s;
	}
	
	td button:hover {
		background-color: #2980b9;
	}
	
	/* 페이징 (이미 정의됨) 추가 마무리 */
	.paging {
		text-align: center;
		margin-top: 30px;
		font-size: 0;
		user-select: none;
	}
	
	.paging .page,
	.paging .page-btn {
		display: inline-block;
		margin: 0 4px;
		padding: 8px 14px;
		font-size: 14px;
		color: #333;
		border: 1px solid #ccc;
		border-radius: 4px;
		background-color: #fff;
		text-decoration: none;
		cursor: pointer;
		transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
	}
	
	.paging .page:hover,
	.paging .page-btn:hover {
		background-color: #eee;
		color: #000;
	}
	
	.paging .page.current {
		background-color: #4CAF50;
		color: white;
		font-weight: bold;
		cursor: default;
		border-color: #4CAF50;
	}
	
	/* 반응형 */
	@media screen and (max-width: 768px) {
		form {
			flex-direction: column;
			align-items: center;
		}
		
		table {
			font-size: 12px;
		}
		
		th, td {
			padding: 6px 4px;
		}
	}

</style>
</head>
<body>
	<h1>배송 조회</h1>
	
	<form action="/admin/deliveryList" method="get">
		<input type="hidden" name="page" value="1">
		<input type="hidden" name="size" value="10">
		판매자 : <input type="text" name="seller" value="${seller != null ? seller : ''}">
		구매자 : <input type="text" name="buyer" value="${buyer != null ? buyer : ''}">
		<button>검색</button>
	</form>
	
	<table border="1">
		<tr>
			<th>주문번호</th>
			<th>송장번호</th>
			<th>판매자</th>
			<th>상품명</th>
			<th>구매자아이디(이름)</th>
			<th>배송상태(구매확정)</th>
			<th>주문일시</th>
			<th>배송시작일</th>
			<th>배송완료일</th>
			<th>취소신청일</th>
		</tr>
		
		<c:forEach var="list" items="${deliveryList}">		
			<tr>
				<td>${list.orderNo}</td>
				<td>${list.deliveryNumber}</td>
				<td>${list.seller}</td>
				<td>${list.itemName}</td>
				<td>${list.buyer}(${list.NAME})</td>
				<td>
					<c:choose>
						<c:when test="${list.deliveryStatus == 'BREFORE'}">배송준비중</c:when>
						<c:when test="${list.deliveryStatus == 'CURRENT'}">배송중</c:when>
						<c:when test="${list.deliveryStatus == 'FINISH'}">배송완료(${list.point})</c:when>
						<c:when test="${list.deliveryStatus == 'CENCEL'}">취소</c:when>
					</c:choose>
				</td>
				<td>
					<fmt:parseDate var="parsedDate" value="${list.orderDate}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
					<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/> 
				</td>
				<td>
					<fmt:parseDate var="parsedDate" value="${list.startDate}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
					<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/> 
				</td>
				<td>
					<fmt:parseDate var="parsedDate" value="${list.endDate}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
					<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/> 
				</td>
				<td>
					<fmt:parseDate var="parsedDate" value="${list.cancelDate}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
					<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/> 
				</td>
			</tr>
		</c:forEach>
	</table>
	
	<!-- 페이징 -->
	<div class="paging">
		<c:if test="${currentPage > 1}">
			<a class="page-btn" href="?page=${currentPage - 1}&seller=${seller}&buyer=${buyer}">이전</a>
		</c:if>
	
		<c:set var="startPage" value="${(currentPage - 1) / 5 * 5 + 1}" />
		<c:set var="endPage" value="${startPage + 4}" />
		<c:if test="${endPage > totalPages}">
			<c:set var="endPage" value="${totalPages}" />
		</c:if>
	
		<c:forEach begin="${startPage}" end="${endPage}" var="i">
			<c:choose>
				<c:when test="${i == currentPage}">
					<span class="page current">${i}</span>
				</c:when>
				<c:otherwise>
					<a class="page" href="?page=${i}&seller=${seller}&buyer=${buyer}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<c:if test="${currentPage < totalPages}">
			<a class="page-btn" href="?page=${currentPage + 1}&seller=${seller}&buyer=${buyer}">다음</a>
		</c:if>
	</div>
	
</body>
</html>