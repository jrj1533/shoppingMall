<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>주문리스트</h1>
	
	<form action="/seller/orderList" method="get">
		<input type="hidden" name="page" value="1">
		<label>주문자:
			<input type="text" name="buyer" value="${buyer != null ? buyer : ''}" />
		</label>
		<label>배송현황:
			<select name="deliveryStatus">
				<option value="">전체</option>
				<option value="BEFORE" ${deliveryStatus == 'BEFORE' ? 'selected' : ''}>배송준비중</option>
				<option value="CURRENT" ${deliveryStatus == 'CURRENT' ? 'selected' : ''}>배송중</option>
				<option value="FINISH" ${deliveryStatus == 'FINISH' ? 'selected' : ''}>배송완료</option>
				<option value="CANCEL" ${deliveryStatus == 'CANCEL' ? 'selected' : ''}>주문취소</option>
			</select>
		</label>
		<label>결제상태:
			<select name="ordersStatus">
				<option value="">전체</option>
				<option value="PAYED" ${ordersStatus == 'PAYED' ? 'selected' : ''}>결제완료</option>
				<option value="CANCEL" ${ordersStatus == 'CANCEL' ? 'selected' : ''}>결제취소</option>
			</select>
		</label>
		<button type="submit">검색</button>
	</form>
	
	<table border="1">
		<tr>
			<th>주문번호</th>
			<th>상품</th>
			<th>옵션</th>
			<th>가격</th>
			<th>주문자</th>
			<th>배송주소</th>
			<th>배송현황</th>
			<th>결제상태</th>
			<th>주문일</th>
		</tr>
		<c:forEach var="list" items="${orderList}">
			<tr>
				<td>${list.itemNo}</td>
				<td>${list.itemTitle}</td>
				<td>${list.optionNo}</td>
				<td>${list.totalPrice}원</td>
				<td>${list.buyer}</td>
				<td>${list.address} ${list.address2} (${list.postCode})</td>
				<td>${list.deliveryStatus}</td>
				<td>${list.ordersStatus}</td>
				<td>${list.orderDate}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
