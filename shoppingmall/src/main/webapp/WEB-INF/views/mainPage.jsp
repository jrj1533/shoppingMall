<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <title>Kurly mainPage</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
    }

    /* 1) 전체 레이아웃: 좌우 분할 */
    .search-results {
      display: flex;
      align-items: flex-start;
      gap: 24px;
      max-width: 1200px;
      margin: 32px auto;
      padding: 0 24px;
      box-sizing: border-box;
    }

    /* 2) 필터 패널 */
    .filter-panel {
      flex: 0 0 240px;
      border-right: 1px solid #eee;
      padding-right: 16px;
    }
    .filter-panel h4 {
      margin-top: 0;
    }
    .filter-panel ul {
      list-style: none;
      padding: 0;
      margin: 0;
    }
    .filter-panel li {
      margin: 8px 0;
      cursor: pointer;
    }

    /* 3) 상품 목록 영역 */
    .product-list {
      flex: 1;
    }
    .product-list h2 {
      margin-top: 0;
      font-size: 1.5rem;
      color: #333;
    }
    .product-list .products {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 24px;
    }

    /* 4) 상품 카드 */
    .product-card {
      background: #fff;
      border: 1px solid #eee;
      border-radius: 8px;
      overflow: hidden;
      display: flex;
      flex-direction: column;
    }
    .product-card .thumb {
      position: relative;
      width: 100%;
      padding-top: 100%;
      background: #f9f9f9;
    }
    .product-card .thumb img {
      position: absolute;
      top: 0; left: 0;
      width: 100%; height: 100%;
      object-fit: cover;
    }
    .product-card .info {
      padding: 12px;
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .product-card .name {
      font-size: 1rem;
      color: #333;
      margin: 0 0 8px;
      line-height: 1.3;
      height: 2.6em;
      overflow: hidden;
    }
    .product-card .price {
      font-size: 1.1rem;
      font-weight: bold;
      color: #333;
      margin-bottom: 12px;
    }
    .product-card .btn-cart {
      background: #7f00ff;
      color: #fff;
      border: none;
      border-radius: 20px;
      padding: 8px 0;
      text-align: center;
      font-size: .95rem;
      cursor: pointer;
    }
  </style>
</head>
<body>
  <%-- 공통 헤더(include) --%>
  
  <c:if test="${empty sessionScope.roleNo } ">
  <jsp:include page="/WEB-INF/views/common/header_guest.jsp" flush="true"/>
  </c:if>
  
  <jsp:include page="/WEB-INF/views/common/header_member.jsp" flush="true"/>
 
  

  <div class="search-results">
    <%-- 1) 왼쪽: 필터 패널 --%>
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
        <!-- … 나머지 필터 … -->
      </ul>
    </aside>

    <%-- 2) 오른쪽: 상품 목록 --%>
    <section class="product-list">
      
      <div class="products">
        <%-- 상품 카드 반복 예시 --%>
        <div class="product-card">
          <div class="thumb">
            <img src="https://via.placeholder.com/300?text=상품+1" alt="상품 1">
          </div>
          <div class="info">
            <p class="name">예시 상품명 1 (길어도 두 줄로 잘립니다)</p>
            <p class="price">9,900원</p>
            <button class="btn-cart">담기</button>
          </div>
        </div>

        <div class="product-card">
          <div class="thumb">
            <img src="https://via.placeholder.com/300?text=상품+2" alt="상품 2">
          </div>
          <div class="info">
            <p class="name">예시 상품명 2</p>
            <p class="price">12,500원</p>
            <button class="btn-cart">담기</button>
          </div>
        </div>

        <div class="product-card">
          <div class="thumb">
            <img src="https://via.placeholder.com/300?text=상품+3" alt="상품 3">
          </div>
          <div class="info">
            <p class="name">예시 상품명 3</p>
            <p class="price">7,300원</p>
            <button class="btn-cart">담기</button>
          </div>
        </div>
        <%-- … 추가 카드 … --%>
      </div>
    </section>
  </div>
</body>
</html>
