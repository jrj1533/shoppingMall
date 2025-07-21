<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰리스트</title>
</head>
<body>
	<h1>쿠폰리스트</h1>
	<form action="/admin/couponList" method="get">
		<table border="1">
			<tr>
				<th>번호</th>
				<th>쿠폰이름</th>
				<th>쿠폰내용</th>
				<th>쿠폰혜택</th>
				<th>쿠폰시작일</th>
				<th>쿠폰만료일</th>
				<th>쿠폰생성일</th>
			</tr>
			
			<c:forEach var="list" items="${couponList }">
				<tr>
					<td>${list.couponNo}</td>
					<td>${list.title}</td>
					<td>${list.content}</td>
					<td>
					  <c:choose>
					    <c:when test="${list.type == '%'}">
					      ${list.percentage}%
					    </c:when>
					    <c:otherwise>
					      ${list.amount}원
					    </c:otherwise>
					  </c:choose>
					</td>
					<td>${list.startDate}</td>
					<td>${list.endDate}</td>
					<td>${list.createDate}</td>
				</tr>
			</c:forEach>
		</table>
	
	</form>
</body>
</html>