<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Kurly Main Page</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script>
	const ctx = '${pageContext.request.contextPath}';
	</script>
	
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/mainpage.js"></script>
  <style>
    body { margin-top: 100px; margin:0; padding:0; font-family:Arial,sans-serif; }
    main { max-width:1200px; margin:32px auto; padding:0 24px; }
    .search-results { display:flex; gap:24px; }
    .filter-panel { width:240px; border-right:1px solid #eee; padding-right:16px; }
    .filter-panel h4 { margin-top:0; }
    .filter-panel ul { list-style:none; padding:0; margin:0; }
    .filter-panel li { margin:8px 0; cursor:pointer; }
    .filter-panel li.active { font-weight:bold; color:#7f00ff; }
    .product-list { flex:1; }
    .products { display:grid; grid-template-columns:repeat(auto-fill,minmax(250px,1fr)); gap:24px; }
    .pagination { text-align:center; margin:16px 0; }
    .pagination a { margin:0 4px; text-decoration:none; color:#333; }
    .pagination a.active { font-weight:bold; color:#7f00ff; }
    .product-card { background:#fff; border:1px solid #eee; border-radius:8px;
                    overflow:hidden; display:flex; flex-direction:column;  max-height: 400px; height: auto; }
    .product-card .thumb { position:relative; width:100%;  padding-top:80%; background:#f9f9f9; }
    .product-card .thumb img { position:absolute; top:0; left:0;
      width:100%; height:100%; object-fit:contain; }
    .product-card .info { padding:8px; flex:1;
      display:flex; flex-direction:column; justify-content:space-between; gap: 4px;}
    .product-card .name { font-size:1rem; color:#333; margin:12px 0 0;
      line-height:1.3; height:2.6em; overflow:hidden; }
    .product-card .price { font-size:1.1rem; font-weight:bold; color:#333;
      margin: -20px 0 8px; }
    .product-card .btn-cart { background:#7f00ff; color:#fff; border:none;
      border-radius:20px; padding:8px 0; text-align:center; font-size:.95rem;
      cursor:pointer; }
    /* 공통: 숨기기 */
.hidden { display: none; }

/* 오버레이 (반투명 검정) */
#overlay {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,0.4);
  z-index: 1000;
}

/* 모달 창 */
.modal {
  position: fixed;
  top: 50%; left: 50%;
  transform: translate(-50%, -50%);
  z-index: 1001;
  width: 90%;
  max-width: 400px;
}
.modal-content {
  background: #fff;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}
.modal-title {
  margin: 0 0 8px;
  font-size: 1.2rem;
}
.modal-desc {
  margin: 0 0 16px;
  color: #555;
}
.modal-price-qty {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}
.modal-price {
  font-size: 1.1rem;
  font-weight: bold;
}
.quantity-control {
  display: flex;
  align-items: center;
  gap: 8px;
}
.quantity-control button {
  width: 32px; height: 32px;
  border: 1px solid #ccc;
  background: #fff;
  cursor: pointer;
  border-radius: 4px;
}
.quantity-control .qty-value {
  min-width: 24px;
  text-align: center;
}
.modal-actions {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}
.modal-actions button {
  padding: 8px 16px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
#modalCancel {
  background: #eee;
  color: #333;
}
#modalAddCart {
  background: #7f00ff;
  color: #fff;
}

.modal-thumb {
  text-align: center;
  margin-bottom: 16px;
}
.modal-thumb img {
  max-width: 100%;
  height: auto;
  border-radius: 4px;
}

.modal-options {
  list-style: none;
  padding: 0;
  margin: 16px 0;
  max-height: 200px;
  overflow-y: auto;
  border-top: 1px solid #eee;
  border-bottom: 1px solid #eee;
}
.modal-options li {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 0;
  border-bottom: 1px solid #f1f1f1;
}
.modal-options li:last-child {
  border-bottom: none;
}
.modal-options .option-name {
  flex: 1;
}
.quantity-control {
  display: flex;
  align-items: center;
  gap: 4px;
}
.modal-total {
  text-align: right;
  font-weight: bold;
  margin: 12px 0;
}
    
    
  </style>
</head>
<body>

  <!-- 헤더: 로그인/비회원에 따라 분기 -->
  <c:choose>
    <c:when test="${sessionScope.roleNo == null || sessionScope.roleNo == 0}">
      <jsp:include page="/WEB-INF/views/common/header_guest.jsp" flush="true" />
    </c:when>
    <c:otherwise>
      <jsp:include page="/WEB-INF/views/common/header_member.jsp" flush="true" />
    </c:otherwise>
  </c:choose>

  <main>
    <div class="search-results">
      <!-- 필터 패널 -->
      <aside class="filter-panel">
        <h4>필터</h4>
        <ul>
          <li>새로 나온</li>
          <li>Kurly Only</li>
        </ul>
        <h4>카테고리</h4>
        <ul>
          <li>과자·간식 (413)</li>
          <li>쿠키·비스킷·크래커 (194)</li>
          <li>초콜릿·젤리·캔디 (77)</li>
          <li>디저트 (76)</li>
        </ul>
      </aside>

      <!-- 상품 목록 -->
      <section class="product-list">
        <div id="products" class="products"></div>
        <div id="pagination" class="pagination"></div>
      </section>
    </div>
  </main>
	  
	<!-- 모달 오버레이 + 창 (초기엔 .hidden 처리) -->
<!-- 오버레이 + 모달 -->

<form id="modalForm" action="${ctx}/api/insertCart" method="post" >
<div id==overlay" class="hidden"></div>
<div id="detailModal" class="modal hidden">
  <div class="modal-content">
    <!-- 1) 대표 이미지 -->
    <div class="modal-thumb">
      <input type="hidden" name="username" value="${sessionScope.username}">
      <input type="hidden"  name ="itemNo" class ="modal-itemNo" value="">
      <img id="modalImg" src="" alt="상품 이미지" />
      <!-- 이미지 URL 히든 필드 -->
      
    </div>

    <!-- 2) 제목/설명 -->
    <h3 class="modal-title"></h3>
    
    <p class="modal-desc"></p>
    

    <!-- 3) 옵션 목록 -->
    <ul id="modalOptionsList" class="modal-options">
     
      <li>
        <!-- 옵션 라벨 -->
        <span class="option-name">옵션명 옵션값</span>

        <!-- 옵션 데이터 히든 필드 -->
        

        <!-- 수량 컨트롤 -->
        <div class="quantity-control">
          <button type="button" class="qty-decrease">-</button>
          <input type="number" class="qty-value"
                 name="count"
                 value="0"
                 readonly />
          <button type="button" class="qty-increase">+</button>
        </div>
      </li>
      <!-- …index 1, 2, … 계속 반복… -->
    </ul>

    <!-- 4) 전체 합계 -->
    <div class="modal-total">
      합계: <span id="modalTotalPrice">0원</span>
    </div>

    <!-- 5) 액션 버튼 -->
    <div class="modal-actions">
      <button id="modalCancel" type="button">취소</button>
      <button id="modalAddCart" type="button">장바구니 담기</button>
    </div>
  </div>
</div>
</form>  

	
	





</body>
</html>