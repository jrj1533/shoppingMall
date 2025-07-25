<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f9f9f9;
    padding: 30px;
  }

  h1 {
    font-size: 24px;
    text-align: center;
    margin-bottom: 20px;
  }

  .search-form {
    display: flex;
    justify-content: center;
    margin-bottom: 30px;
    gap: 10px;
  }

  .search-box {
    position: relative;
    width: 400px;
  }

  .search-box input[type="text"] {
    width: 100%;
    padding: 10px 60px 10px 15px;
    font-size: 15px;
    border-radius: 20px;
    border: 1px solid #ccc;
    box-sizing: border-box;
  }

  .search-box button,
  .search-box span {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    font-size: 18px;
    cursor: pointer;
    background: none;
    border: none;
    color: #666;
  }

  .search-box button {
    right: 10px;
  }

  .search-box span {
    right: 45px;
    color: #aaa;
    display: none;
  }

  .order-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
    align-items: center;
  }

  .order-card {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    max-width: 800px;
    width: 100%;
    padding: 20px;
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .order-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .order-body {
    display: flex;
    gap: 20px;
  }

.order-image {
  width: 120px;
  height: 120px;
  background-color: #f8f8f8; /* 이미지 없을 때도 영역이 보이도록 */
  border-radius: 8px;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}

.order-image img {
  width: 100%;
  height: 100%;
  object-fit: contain; /* 비율 유지하면서 전체 이미지 보이기 */
  display: block;
}

  .order-info {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 6px;
  }

  .order-title {
    font-weight: bold;
  }

  .order-option,
  .order-meta {
    font-size: 13px;
    color: #777;
  }

  .order-price {
    font-weight: bold;
  }

  .order-actions {
    display: flex;
    gap: 10px;
    margin-top: 10px;
  }

  .order-actions button {
    padding: 6px 12px;
    border: 1px solid #ccc;
    background: white;
    border-radius: 4px;
    cursor: pointer;
  }

  .reset-text {
    color: #007bff;
    font-size: 14px;
    cursor: pointer;
    text-decoration: underline;
  }
  
  #orderDetailModal {
  position: fixed;              /* 화면 고정 */
  top: 50%;                     /* 수직 중앙 */
  left: 50%;                    /* 수평 중앙 */
  transform: translate(-50%, -50%); /* 정확히 가운데 정렬 */
  background: #fff;             /* 배경색 */
  padding: 20px;                /* 내부 여백 */
  border-radius: 10px;          /* 모서리 둥글게 */
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); /* 그림자 */
  z-index: 1000;                /* 다른 요소보다 위에 */
  max-width: 600px;             /* 너비 제한 */
  width: 90%;                   /* 반응형 */
}

#modalBackdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.4); /* 반투명 배경 */
  z-index: 999;
}
</style>
<script>
  function toggleClearIcon() {
    const input = document.getElementById('searchInput');
    const clearIcon = document.getElementById('clearIcon');
    clearIcon.style.display = input.value.trim() !== '' ? 'inline' : 'none';
  }

  function clearInputOnly() {
    document.getElementById('searchInput').value = '';
    toggleClearIcon();
  }

  function resetAllSearch() {
    document.getElementById('searchInput').value = '';
    document.getElementById('searchForm').submit();
  }
  
  function openModal(html) {
	  $("#orderDetailContent").html(html);
	  $("#modalBackdrop").show();
	  $("#orderDetailModal").show();
	}

	function closeModal() {
	  $("#modalBackdrop").hide();
	  $("#orderDetailModal").hide();
	}
  
  $(document).ready(function () {
	    $(".btn-detail").click(function () {
	      const orderNo = $(this).data("order-no");

	      $.ajax({
	        url: "/buyer/orderCartDetail",
	        method: "GET",
	        data: { orderNo: orderNo },
	        success: function (data) {
	        	  let html = "<h3>주문 상세</h3><ul>";
	        	  data.forEach(function (item) {
	        	    html += `<li><strong>${item.itemTitle}</strong> / 옵션: ${item.optionName} / 수량: ${item.count} / 가격: ${item.price}원</li>`;
	        	  });
	        	  html += "</ul>";
	        	  openModal(html);
	        	},
	        error: function () {
	          alert("주문 상세 정보를 불러오지 못했습니다.");
	        }
	      });
	    });
	  });
</script>
</head>
<body>
  <h1>주문내역</h1>
  <form id="searchForm" action="/buyer/orderCartList" method="get" class="search-form">
    <div class="search-box">
      <input type="text" id="searchInput" name="searchWord" value="${param.searchWord}" placeholder="상품명 입력" oninput="toggleClearIcon()">
      <span id="clearIcon" onclick="clearInputOnly()"><i class="fas fa-circle-xmark"></i></span>
      <button type="submit"><i class="fas fa-magnifying-glass"></i></button>
    </div>
    <c:if test="${not empty param.searchWord}">
      <div class="reset-text" onclick="resetAllSearch()">초기화</div>
    </c:if>
  </form>

  <div class="order-list">
    <c:if test="${empty orderCartList}">
      <p>주문 내역이 없습니다.</p>
    </c:if>

    <c:forEach var="o" items="${orderCartList}">
      <div class="order-card">
        <div class="order-header">
          <div style="font-size: 20px; font-weight: bold;">
            <fmt:formatDate value="${o.orderDate}" pattern="yy.MM.dd" />
          </div>
         <a class="btn-detail" data-order-no="${o.orderNo}"
   			style="font-size: 14px; color: #555; text-decoration: underline;">주문 상세</a>
        </div>
		<!-- 배경 영역 -->
		<div id="modalBackdrop" style="display: none;"></div>
		
		<!-- 모달 본문 -->
		<div id="orderDetailModal" style="display: none;">
		  <div id="orderDetailContent"></div>
		  <button onclick="closeModal()">닫기</button>
		</div>
        <div class="order-body">
		<div class="order-image">
		  <img src="${pageContext.request.contextPath}/upload/${o.saveName}"
		       onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/default.png';"
		       alt="상품 이미지" />
		</div>
          <div class="order-info">
            <div class="order-title">${o.displayTitle}</div>
            <div class="order-option">수량: ${o.itemCount}개</div>
            <div class="order-price">
              <fmt:formatNumber value="${o.totalPrice}" type="number" groupingUsed="true" />원
            </div>
            <c:choose>
           <c:when test="${o.orderStatus == 'PAYED'}">결제완료</c:when>
		   <c:when test="${o.orderStatus == 'CANCEL'}">결제취소</c:when>
		   </c:choose>
            <div class="order-actions">
              <button>배송 조회</button>
              <button>재구매</button>
            </div>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</body>
</html>
