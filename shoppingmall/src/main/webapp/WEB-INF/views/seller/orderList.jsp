<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 리스트</title>

<style>
	/* 전체 폰트 및 박스 스타일 */
	body {
		font-family: 'Noto Sans KR', sans-serif;
		background-color: #f9f9f9;
		padding: 20px;
		color: #333;
	}

	h1 {
		text-align: center;
		margin-bottom: 30px;
		color: #222;
	}

	form {
		margin-bottom: 20px;
		display: flex;
		gap: 10px;
		flex-wrap: wrap;
		align-items: center;
		justify-content: center;
	}

	form label {
		display: flex;
		align-items: center;
		gap: 5px;
		background-color: #fff;
		padding: 8px 12px;
		border: 1px solid #ccc;
		border-radius: 4px;
	}

	form input[type="text"],
	form select {
		padding: 5px 8px;
		border: 1px solid #ccc;
		border-radius: 4px;
	}

	form button {
		padding: 8px 16px;
		background-color: #4CAF50;
		color: white;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		transition: background-color 0.2s ease-in-out;
	}

	form button:hover {
		background-color: #45a049;
	}

	/* 테이블 스타일 */
	table {
		table-layout: fixed; /* 컬럼 너비 고정 */
		width: 100%;
		border-collapse: collapse;
		background-color: #fff;
		box-shadow: 0 0 10px rgba(0,0,0,0.05);
		min-height: 150px; /* 빈 결과 최소 높이 확보 */
	}

	th {
		background-color: #f2f2f2;
		border-bottom: 2px solid #999;
		text-align: center;
		height: 50px;
	}
	
	td {
		border-bottom: 1px solid #ddd;
		text-align: center;
		height: 50px;
		min-height: 50px;
	}

	tr:nth-child(even) {
		background-color: #f9f9f9;
	}

	tr:hover {
		background-color: #eef;
	}

	@media screen and (max-width: 768px) {
		form {
			flex-direction: column;
			align-items: stretch;
		}
	}
	
	/* 빈 결과 메시지 셀 스타일 */
	.empty-result {
		background-color: #ddd; /* 밝은 노란색 배경 등 */
		color: #666;
		text-align: center;
		padding: 2px 0;
		border-top: 1px solid #ddd; /* 헤더와 구분되는 선 */
		font-size: 1.1em;
		font-weight: 600;
	}
	
	.paging {
		text-align: center;
		margin-top: 20px;
		user-select: none;
	}
	
	.paging .page,
	.paging .page-btn {
		display: inline-block;
		margin: 0 5px;
		padding: 6px 12px;
		color: #333;
		border: 1px solid #ccc;
		border-radius: 4px;
		text-decoration: none;
		cursor: pointer;
	}
	
	.paging .page.current {
		background-color: #4CAF50;
		color: white;
		font-weight: bold;
		cursor: default;
		border-color: #4CAF50;
	}

</style>
</head>
<body>
	<h1>주문리스트</h1>
	
	<!-- 필터링 + 검색 -->
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
			<th>옵션세부선택</th>
			<th>수량</th>
			<th>결제금액</th>
			<th>주문자</th>
			<th>배송주소</th>
			<th>배송현황(구매확정)</th>
			<th>결제상태</th>
			<th>주문일</th>
		</tr>
		
		<!-- 데이터 값에 따라 출력 -->
		<c:choose>
		    <c:when test="${not empty orderList}">
		        <c:forEach var="list" items="${orderList}">
		            <tr>
		                <td>${list.itemNo}</td>
		                <td>${list.itemTitle}</td>
		                <td>${list.optionName}</td>
		                <td>${list.optionValue}</td>
		                <td>${list.count}</td>
		                <td><fmt:formatNumber value="${list.totalPrice}" type="number" groupingUsed="true"/>원</td>
		                <td>${list.buyerName}</td>
		                <td>${list.address} ${list.address2} (${list.postCode})</td>
		                <td>
		                    <c:choose>
		                        <c:when test="${list.deliveryStatus == 'BEFORE'}"><button type="button" onclick="startDelivery('${list.deliveryNo}', '${list.orderNo}')">배송하기</button></c:when>
		                        <c:when test="${list.deliveryStatus == 'CURRENT'}">배송중</c:when>
		                        <c:when test="${list.deliveryStatus == 'FINISH'}">배송완료(${list.point})</c:when>
		                        <c:when test="${list.deliveryStatus == 'CANCEL'}">취소 <button>내역확인</button></c:when>
		                        <c:otherwise>알수없음</c:otherwise>
		                    </c:choose>
		                </td>
		                <td>
		                    <c:choose>
		                        <c:when test="${list.ordersStatus == 'PAYED'}">결제완료</c:when>
		                        <c:when test="${list.ordersStatus == 'CANCEL'}">결제취소</c:when>
		                        <c:when test="${list.ordersStatus == 'COMFIRM'}">구매확정</c:when>
		                        <c:otherwise>알수없음</c:otherwise>
		                    </c:choose>
		                </td>
		                <td>
							<fmt:parseDate var="parsedDate" value="${list.orderDate}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
							<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/> 
						</td>
		            </tr>
		        </c:forEach>
		    </c:when>
		    <c:otherwise>
		        <tr>
		            <td colspan="11" class="empty-result">
		                검색 결과가 없습니다.
		            </td>
		        </tr>
		    </c:otherwise>
		</c:choose>
	</table>
	
	<!-- 배송상태 변경 용 -->
	<form id="deliveryForm" method="post" action="/seller/startDelivery">
	    <input type="hidden" name="deliveryNo" id="deliveryNoInput">
	    <input type="hidden" name="orderNo" id="orderNoInput">
	</form>
	
	<!-- 페이징 -->
	<div class="paging">
		<c:if test="${currentPage > 1}">
			<a class="page-btn" href="?page=${currentPage - 1}&buyer=${buyer}&deliveryStatus=${deliveryStatus}&ordersStatus=${ordersStatus}">이전</a>
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
					<a class="page" href="?page=${i}&buyer=${buyer}&deliveryStatus=${deliveryStatus}&ordersStatus=${ordersStatus}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<c:if test="${currentPage < totalPages}">
			<a class="page-btn" href="?page=${currentPage + 1}&buyer=${buyer}&deliveryStatus=${deliveryStatus}&ordersStatus=${ordersStatus}">다음</a>
		</c:if>
	</div>

</body>

<script>
	function startDelivery(deliveryNo, orderNo) {
	const message = confirm("상품을 발송하시겠습니까?")
	
		if(message) {
			document.getElementById("deliveryNoInput").value = deliveryNo;
			document.getElementById("orderNoInput").value = orderNo;
			document.getElementById("deliveryForm").submit();
		} else {
			alert("배송이 취소되었습니다.");
		}
	}
</script>
</html>
