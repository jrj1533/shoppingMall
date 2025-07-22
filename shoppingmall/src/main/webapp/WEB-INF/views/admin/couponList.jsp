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
		<select name="searchType">
		  <option value="all" ${page.searchType == 'all' ? 'selected' : ''}>전체</option>
		  <option value="title" ${page.searchType == 'title' ? 'selected' : ''}>제목</option>
		  <option value="content" ${page.searchType == 'content' ? 'selected' : ''}>내용</option>
		  <option value="type" ${page.searchType == 'type' ? 'selected' : ''}>할인가</option>
		</select>
	
	<input type="text" name="searchWord" value="${page.searchWord}" placeholder="검색어 입력" />

  <select name="couponDate">
    <option value="0">전체</option>
    <option value="5" ${page.couponPercentage == 5 ? 'selected' : ''}>5%</option>
    <option value="10" ${page.couponPercentage == 10 ? 'selected' : ''}>10%</option>
  </select>

  <button type="submit">검색</button>
	
		<table border="1">
			<tr>
				<th>번호</th>
				<th>쿠폰이름</th>
				<th>쿠폰내용</th>
				<th>쿠폰할인</th>
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
		<div class="pagination">
	  <c:forEach var="i" begin="1" end="${page.lastPage}">
		    <a href="?currentPage=${i}
		             &searchWord=${page.searchWord}
		             &couponTitle=${page.couponTitle}
		             &couponContent=${page.couponContent}
		             &couponType=${page.couponType}
		             &couponPercentage=${page.couponPercentage}"
		       style="${i == page.currentPage ? 'font-weight:bold;' : ''}">
		      ${i}
		    </a>
  		</c:forEach>
	</div>
</body>
</html>