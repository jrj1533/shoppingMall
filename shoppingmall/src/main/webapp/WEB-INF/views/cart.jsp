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

    /* Header */
    .header { display: flex; justify-content: space-between; align-items: center;
              padding: 10px 20px; background: #fff; border-bottom: 1px solid #ddd; }
    .header .logo img { height: 40px; }
    .header .search { flex: 1; margin: 0 20px; display: flex; }
    .header .search input { flex: 1; padding: 8px; border: 1px solid #ccc;
                            border-radius: 4px 0 0 4px; outline: none; }
    .header .search button { padding: 8px 12px; border: 1px solid #ccc;
                             border-left: none; background: #eee; cursor: pointer;
                             border-radius: 0 4px 4px 0; }
    .header .user-menu a { margin-left: 15px; color: #333; text-decoration: none; }
    .header .user-menu .badge { background: #5f0080; color: #fff;
                                 border-radius: 50%; padding: 2px 6px; font-size: 12px; }

    /* Layout */
    .cart-container { display: flex;
                      max-width: 1200px; margin: 20px auto; gap: 20px; }

    /* Cart List */
    .cart-list { flex: 2; background: #fff; padding: 20px;
                 border: 1px solid #ddd; border-radius: 8px; }
    .cart-list h1 { font-size: 24px; margin-bottom: 20px; }
    .select-all { display: flex; align-items: center; margin-bottom: 16px; }
    .select-all input { margin-right: 8px; }
    .select-all label { font-weight: bold; }
    .select-all .btn-delete { margin-left: auto; padding: 6px 12px;
                              background: #f5f5f5; border: none; border-radius: 4px;
                              cursor: pointer; }

    .cart-group h2 { display: flex; align-items: center; font-size: 18px; margin-bottom: 12px; }
    .cart-group h2 input { margin-right: 8px; }

    .cart-item { display: flex; align-items: flex-start;
                 padding: 12px 0; border-top: 1px solid #eee; }
    .cart-item:first-child { border-top: none; }
    .cart-item input[type="checkbox"] { margin-right: 12px; }
    .cart-item img { width: 80px; height: 80px; object-fit: cover;
                     margin-right: 16px; border: 1px solid #eee; }

    .details { flex: 1; }
    .details .title { font-size: 16px; margin-bottom: 4px; }
    .details .price { font-size: 14px; margin-bottom: 8px; }
    .details .price del { color: #999; margin-left: 8px; }

    .quantity { display: flex; align-items: center; margin-bottom: 8px; }
    .quantity button { width: 28px; height: 28px; border: 1px solid #ccc;
                       background: #fff; border-radius: 4px; cursor: pointer; }
    .quantity .qty-value { width: 32px; text-align: center; }

    .option-note { font-size: 12px; color: #5f0080; }

    .remove { background: none; border: none; font-size: 18px;
               cursor: pointer; margin-left: 12px; }

    .subtotal { display: flex; justify-content: space-between;
                padding: 16px 0; border-top: 1px solid #ddd; font-size: 14px; }
    .subtotal strong { font-size: 16px; }

    /* Summary */
    .cart-summary { flex: 1; background: #fff; padding: 20px;
                    border: 1px solid #ddd; border-radius: 8px; height: fit-content; }
    .cart-summary .address, .cart-summary .payment { margin-bottom: 20px; }
    .cart-summary h3 { font-size: 18px; margin-bottom: 12px; }
    .cart-summary p { display: flex; justify-content: space-between; font-size: 14px; }
    .cart-summary .discount { color: #e74c3c; }
    .cart-summary hr { margin: 12px 0; border: none; border-top: 1px solid #eee; }
    .cart-summary .total strong { font-size: 20px; }
    .cart-summary .order-btn { width: 100%; padding: 12px 0;
                                background: #5f0080; color: #fff; border: none;
                                border-radius: 4px; cursor: pointer;
                                font-size: 16px; }
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

  <!-- Main -->
  <main class="cart-container">
    <!-- Left: Cart List -->
    <section class="cart-list">
      <h1>장바구니</h1>
      <div class="select-all">
        <input type="checkbox" id="selectAll" />
        <label for="selectAll">전체선택 <span class="total-count">2/2</span></label>
        <button class="btn-delete">선택삭제</button>
      </div>

      <div class="cart-group">
        <ul>
          <li class="cart-item">
            <input type="checkbox" />
            <img src="/upload/item1.jpg" alt="상품 이미지" />
            <div class="details">
              <p class="title">[차라네] 햄 가득 송탄식 부대찌개</p>
              <p class="price">11,900원 <del>15,900원</del></p>
              <div class="quantity"><button class="decrease">-</button><span class="qty-value">1</span>
              <button class="increase">+</button></div>
            </div>
            <button class="remove">×</button>
          </li>
          <li class="cart-item">
            <input type="checkbox" />
            <img src="/upload/item2.jpg" alt="상품 이미지" />
            <div class="details">
              <p class="title">[신의주 찹쌀순대] 매콤양념 졸순대볶음 905g</p>
              <p class="price">12,665원 <del>14,900원</del></p>
              <div class="quantity"><button class="decrease">-</button><span class="qty-value">1</span><button class="increase">+</button></div>
            </div>
            <button class="remove">×</button>
          </li>
        </ul>
     
      </div>
    </section>

    <!-- Right: Summary -->
    <aside class="cart-summary">
      <div class="address">
        <h3>배송지</h3>
        <p>경기 안양시 만안구 문예로6번길 33-16 201호</p>
        <button class="btn-change">변경</button>
      </div>
      <div class="payment">
        <h3>결제금액</h3>
        <p>상품금액 <span>30,800원</span></p>
        <hr />
        <p class="total">결제예정금액 <strong>30,800원</strong></p>
        <button class="order-btn">27,565원 주문하기</button>
      </div>
    </aside>
  </main>

  <!-- Scripts -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/cart.js"></script>
</body>
</html>
