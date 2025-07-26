<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>장바구니</title>
  <!-- 스타일 (css/cart.css로 분리 가능) -->
  <style>
    /* Reset */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: Arial, sans-serif; background: #f9f9f9; color: #333; }

    /* Layout */
    .cart-container { display: flex; max-width: 1200px; margin: 20px auto; gap: 20px; }

    /* Cart List */
    .cart-list { flex: 2; background: #fff; padding: 20px; border: 1px solid #ddd; border-radius: 8px; }
    .cart-list h1 { font-size: 24px; margin-bottom: 20px; }
    .select-all { display: flex; align-items: center; margin-bottom: 16px; }
    .select-all input { margin-right: 8px; }
    .select-all label { font-weight: bold; }
    .select-all .btn-delete { margin-left: auto; padding: 6px 12px; background: #f5f5f5; border: none; border-radius: 4px; cursor: pointer; }

    .cart-group h2 { display: flex; align-items: center; font-size: 18px; margin-bottom: 12px; }
    .cart-group h2 input { margin-right: 8px; }

    .cart-item { display: flex; align-items: flex-start; padding: 12px 0; border-top: 1px solid #eee; }
    .cart-item:first-child { border-top: none; }
    .cart-item input[type="checkbox"] { margin-right: 12px; }
    .cart-item img { width: 80px; height: 80px; object-fit: cover; margin-right: 16px; border: 1px solid #eee; }
    .details { flex: 1; }
    .details .title { font-size: 16px; margin-bottom: 4px; }
    .details .price { font-size: 14px; margin-bottom: 8px; }
    .quantity { display: flex; align-items: center; margin-bottom: 8px; }
    .quantity button { width: 28px; height: 28px; border: 1px solid #ccc; background: #fff; border-radius: 4px; cursor: pointer; }
    .quantity .qty-value { width: 32px; text-align: center; }
    .remove { background: none; border: none; font-size: 18px; cursor: pointer; margin-left: 12px; }

    .subtotal { display: flex; justify-content: space-between; padding: 16px 0; border-top: 1px solid #ddd; font-size: 14px; }
    .subtotal strong { font-size: 16px; }

    /* Summary */
    .cart-summary { flex: 1; background: #fff; padding: 20px; border: 1px solid #ddd; border-radius: 8px; height: fit-content; }
    .cart-summary .address, .cart-summary .payment { margin-bottom: 20px; }
    .cart-summary h3 { font-size: 18px; margin-bottom: 12px; }
    .cart-summary p { display: flex; justify-content: space-between; font-size: 14px; }
    .cart-summary .discount { color: #e74c3c; }
    .cart-summary hr { margin: 12px 0; border: none; border-top: 1px solid #eee; }
    .cart-summary .total strong { font-size: 20px; }
    .cart-summary .order-btn { width: 100%; padding: 12px 0; background: #5f0080; color: #fff; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
  </style>
</head>
<body>

  <c:choose>
    <c:when test="${sessionScope.roleNo == null || sessionScope.roleNo == 0}">
      <jsp:include page="/WEB-INF/views/common/header_guest.jsp" flush="true" />
    </c:when>
    <c:otherwise>
      <jsp:include page="/WEB-INF/views/common/header_member.jsp" flush="true" />
    </c:otherwise>
  </c:choose>

  <!-- Scripts -->
  
 <script>
  var ctx = '${pageContext.request.contextPath}';
  var apiUrl = ctx + '/api/cart';
</script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/cart.js"></script>

  <!-- Main -->
  <main class="cart-container">
    <!-- Left: Cart List -->
    <section class="cart-list">
      <h1>장바구니</h1>
      <div class="select-all">
        <input type="checkbox" id="selectAll" />
        <label for="selectAll">전체선택 <span class="total-count"></span></label>
        <button class="btn-delete">선택삭제</button>
      </div>

      <div class="cart-group">
        <h2><span class="group-name"></span></h2>
        <ul id="cartItems"><!-- AJAX 로 채워질 아이템 리스트 --></ul>
        <div class="subtotal">
          <span>상품 <span id="subtotalItemsPrice"></span> + </span>
          <strong id="subtotalTotal"></strong>
        </div>
      </div>
    </section>

    <!-- Right: Summary -->
    <aside class="cart-summary">
      <div class="address">
        <h3>배송지</h3>
        <p id="userAddress"></p>
        <button class="btn-change">변경</button>
      </div>
      <div class="payment">
        <h3>결제금액</h3>
        <p>상품금액 <span id="summaryProductTotal"></span></p>
        <hr />
        <p class="total">결제예정금액 <strong id="summaryTotal"></strong></p>
        <button class="order-btn" id="orderButton"></button>
      </div>
    </aside>
  </main>


</body>
</html>
