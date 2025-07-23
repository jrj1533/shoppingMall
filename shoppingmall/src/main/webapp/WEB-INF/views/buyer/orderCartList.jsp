<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h1>주문내역</h1>
		 <form action="/buyer/orderCartList" method="get" class="search-form">
	    <input type="hidden" name="currentPage" value="1">
	   
	    
	    <label>
	      <select name="couponType">
	        <option value="">전체</option>
	        <option value="PERCENT" ${page.couponType == 'PERCENT' ? 'selected' : ''}>결제상태</option>
	        <option value="AMOUNT" ${page.couponType == 'AMOUNT' ? 'selected' : ''}>배송상태</option>
	      </select>
	    </label>
	    
	    <label>검색어:
	      <input type="text" name="title" value="${search.title}" placeholder="상품을 입력하세요.">
	    </label>
	    
	    <button type="submit">검색</button>
  </form>
		
		<table border="1">
			<tr>
				<th>상품이름</th>
				<th>수량</th>
				<th>가격</th>
				<th>결제상태</th>
				<th>배송상태</th>
				<th>주문날짜</th>
			</tr>	
			<c:if test="${empty orderCartList}">
    			<tr><td colspan="6">주문 내역이 없습니다.</td></tr>
			</c:if>
			<c:forEach var="o" items="${orderCartList}">
				<tr>
					<td>${o.title }</td>
					<td>${o.count }</td>
					<td>
					 <!-- 숫자에 천단위로 , 표시 -->
                      <fmt:formatNumber value="${o.price }" type="number" groupingUsed="true" />원
					</td>
					<td>${o.orderStatus }</td>
					<td>${o.deliveryStatus }</td>
					<td>${o.orderDate }</td>
				</tr>
			</c:forEach>
		</table>
</body>
</html>