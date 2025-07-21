<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header_member.jsp: 로그인(회원) 전용 헤더 -->
<head>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function(){
	const menus = document.querySelectorAll('.member-menu');
	
	menus.forEach(menu => {
	    menu.addEventListener('click', e => { // 순환하면서 클릭이벤트 등록 
	      e.stopPropagation();  //클릭이벤트가 부모요소로 전파 x 
	
	
	      menus.forEach(m => {
	        if (m !== menu) m.classList.remove('open');
	      });
	
	      menu.classList.toggle('open');
	    })
	})
	
	document.addEventListener('click', ()=>{
	  menus.forEach(m => m.classList.remove('open'));
	});
});
</script>

</head>

<div class="header-container">
  <div class="auth-bar">
    <div class="member-menu">
	  <c:choose>
	    <c:when test="${sessionScope.roleNo eq 4}">
	    	<span>통합관리자</span>
	    </c:when>
	    <c:when test="${sessionScope.roleNo eq 1}">
	    	<span>관리자</span>
	    </c:when>
	    <c:otherwise>
	      <span>${sessionScope.name} 님</span>
	    </c:otherwise>
	  </c:choose>
	  
	   <c:choose>
	 	<%--통합관리자 --%>
       <c:when test="${sessionScope.roleNo eq 4 }" >
      <span class="arrow">▼</span>
       
      
       <ul class="dropdown-menu">
      	
      	<li><a href="/admin/product">상품리스트</a></li>
      	<li><a href="/admin/deliveryList">배송조회</a></li>
        <li><a href="/admin/adminList">관리자리스트</a></li>
        <li><a href="/userList">회원리스트</a></li>
        <li><a href="/admin/couponList">쿠폰리스트</a></li>
        <li><a href="/logOut">로그아웃</a></li>
      
      </ul>
      </c:when>
      <%--관리자 --%>
       <c:when test="${sessionScope.roleNo eq 1 }" >
      <span class="arrow">▼</span>
       
      
       <ul class="dropdown-menu">
      	
      	<li><a href="/admin/product">상품리스트</a></li>
      	<li><a href="/admin/deliveryList">배송조회</a></li>
        <li><a href="/userList">회원리스트</a></li>
        <li><a href="/admin/couponList">쿠폰리스트</a></li>
        <li><a href="/logOut">로그아웃</a></li>
      
      </ul>
      </c:when>
       <c:when test="${sessionScope.roleNo eq 2 }">
        <span class="arrow">▼</span>
        
        <ul class="dropdown-menu">
        
        <li><a href="/item/register">상품등록</a></li>
        <li><a href="/seller/orderList">주문 내역</a></li>
        <li><a href="/logOut">로그아웃</a></li>
       </ul>
       </c:when>
       
        <c:when test="${sessionScope.roleNo eq 3 }">
        <span class="arrow">▼</span>
        
        <ul class="dropdown-menu">
        
          <li><a href="/profile"></a></li>
        <li><a href="/orders">주문 내역</a></li>
        <li><a href="/logOut">로그아웃</a></li>
       </ul>
       </c:when>
      </c:choose>
      
    </div>
    <span>|</span>
    <div class="member-menu">
      <a href="#">고객센터</a>
      <span class="arrow">▼</span>
       <ul class="dropdown-menu">
        <li><a href="/profile">내 정보</a></li>
        <li><a href="/orders">주문 내역</a></li>
        <li><a href="/logOut">로그아웃</a></li>
      </ul>
    </div>
  </div>

  <div class="header-main">
    <div class="logo">Kurly</div>
    <nav class="primary-nav">
      <ul>
        <li><a href="/">마켓컬리</a></li>
        <li><span class="divider">|</span></li>
        <li><a href="/beauty">뷰티컬리</a></li>
      </ul>
    </nav>
    <div class="search">
      <input type="text" placeholder="검색어를 입력해주세요">
      <span class="search-icon">🔍</span>
    </div>
    <div class="icons">
      <a href="/stores"><span class="icon">📍</span></a>
      <a href="/favorites"><span class="icon">❤️</span></a>
      <a href="/cart" class="icon cart">🛒</a>
      
      
      <c:if test="${not empty sessionScpoe.cartCount and sessionScope.carCount>0}">
     	 <a href="/cart" class="icon cart">🛒<em>${sessionScope.cartCount}</em></a>
      </c:if> 
      	
      	 
      	
      
    </div>
  </div>

  <div class="sub-nav">
    <button class="btn-category">
      <span class="menu-icon">☰</span>카테고리
    </button>
    <nav class="secondary-nav">
      <ul>
        <li><a href="/new" class="active">신상품</a></li>
        <li><a href="/best">베스트</a></li>
        <li><a href="/sale">알뜰쇼핑</a></li>
        <li><a href="/deal">특가/혜택</a></li>
      </ul>
    </nav>
    <button class="delivery-info">샛별·하루 배송안내</button>
  </div>
</div>

<style>
  .header-container { max-width: 1200px; margin: 0 auto; font-family: 'Arial', sans-serif; }
  /* auth-bar */
  .auth-bar { text-align: right; font-size: 0.9rem; padding: 8px 0; color: #555; }
  .auth-bar .member-menu { display: inline-block; cursor: pointer; margin: 0 4px; }
  .auth-bar .member-menu .arrow { font-size: 0.8rem; margin-left: 2px; }
  /* header-main */
  .header-main { display: flex; align-items: center; padding: 16px 0; }
  .logo { font-size: 1.8rem; font-weight: bold; color: #7f00ff; margin-right: 32px; }
  .primary-nav ul { display: flex; align-items: center; list-style: none; gap: 16px; }
  .primary-nav a { color: #333; font-weight: 500; text-decoration: none; }
  .primary-nav .divider { color: #ccc; }
  .search { flex: 1; display: flex; justify-content: center; position: relative; }
  .search input { width: 100%; max-width: 480px; height: 40px; padding: 0 16px; border: 1px solid #7f00ff; border-radius: 20px; outline: none; }
  .search input::placeholder { color: #aaa; }
  .search-icon { position: absolute; right: calc(50% - 240px + 16px); top: 50%; transform: translateY(-50%); font-size: 1.2rem; color: #7f00ff; }
  .icons { display: flex; gap: 24px; margin-left: 32px; font-size: 1.4rem; }
  .icons .icon { position: relative; color: inherit; }
  .icons .cart em { position: absolute; top: -6px; right: -10px; background: #7f00ff; color: #fff; font-size: 0.7rem; width: 16px; height: 16px; border-radius: 50%; display: flex; align-items: center; justify-content: center; }
  /* sub-nav */
  .sub-nav { display: flex; align-items: center; padding: 12px 0; border-top: 1px solid #eee; }
  .btn-category { background: none; border: none; display: flex; align-items: center; font-size: 1rem; color: #333; cursor: pointer; margin-right: 32px; }
  .btn-category .menu-icon { font-size: 1.2rem; margin-right: 8px; }
  .secondary-nav { flex: 1; display: flex; justify-content: center; }
  .secondary-nav ul { display: flex; gap: 48px; list-style: none; }
  .secondary-nav a { color: #333; font-size: 1rem; font-weight: 500; text-decoration: none; padding: 4px 0; }
  .secondary-nav a.active { color: #7f00ff; border-bottom: 2px solid #7f00ff; }
  .delivery-info { background: none; border: 1px solid #7f00ff; border-radius: 20px; padding: 6px 14px; color: #7f00ff; font-size: 0.9rem; cursor: pointer; }

  /* === 추가된 부분: 링크 밑줄 제거 === */
  .auth-bar .member-menu a,
  .icons a {
    text-decoration: none;
  }
  .auth-bar .member-menu a:hover,
  .icons a:hover {
    text-decoration: none;
  }
    /* 드롭다운 공통 */
  .member-menu {
    position: relative;
  }
  .member-menu .dropdown-menu {
    display: none;
    position: absolute;
    top: 100%;
    right: 0;
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.15);
    list-style: none;
    margin: 4px 0 0;
    padding: 0;
    min-width: 140px;
    z-index: 100;
  }
  .member-menu .dropdown-menu li {
    padding: 8px 12px;
  }
  .member-menu .dropdown-menu li + li {
    border-top: 1px solid #eee;
  }
  .member-menu .dropdown-menu a {
    display: block;
    color: #333;
    text-decoration: none;
  }
	/* 추가: 자식 요소(<a>)가 포커스를 가질 때도 유지 */
  .dropdown-menu {
	  display: block;
	}
  /* hover 시 보이기 */
  .member-menu.open .dropdown-menu {
    display: block;
  }
</style>
