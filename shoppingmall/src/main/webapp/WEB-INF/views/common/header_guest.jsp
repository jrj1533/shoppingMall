<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!-- header.html: 세련된 통합 헤더 -->
<div class="header-container">
  <!-- 상단 auth 영역 -->
  <div class="auth-bar">
    <a href="#">회원가입</a>
    <span>|</span>
    <a href="login">로그인</a>
    <span>|</span>
    <a href="#">고객센터</a>
    <span class="arrow">▼</span>
  </div>

  <!-- 메인 헤더 -->
  <div class="header-main">
    <div class="logo">Kurly</div>
    <nav class="primary-nav">
      <ul>
        <li><a href="#">마켓컬리</a></li>
        <li><span class="divider">|</span></li>
        <li><a href="#">뷰티컬리</a></li>
      </ul>
    </nav>
    <div class="search">
      <input type="text" placeholder="검색어를 입력해주세요">
      <span class="search-icon">🔍</span>
    </div>
    <div class="icons">
      <span class="icon">📍</span>
      <span class="icon">❤️</span>
      <span class="icon cart">🛒</span>
    </div>
  </div>

  <!-- 서브 네비게이션 -->
  <div class="sub-nav">
    <button class="btn-category">
      <span class="menu-icon">☰</span>
      카테고리
    </button>
    <nav class="secondary-nav">
      <ul>
        <li><a href="#" data-filter="new" id="filter-new" class="active">신상품</a></li>
        <li><a href="#">베스트</a></li>
        <li><a href="#">알뜰쇼핑</a></li>
        <li><a href="#">특가/혜택</a></li>
      </ul>
    </nav>
    <button class="delivery-info">샛별·하루 배송안내</button>
  </div>
</div>

<style>
/* ---------------------- */
/* 파일: header.css          */
/* ---------------------- */
.header-container {
  max-width: 1200px;
  margin: 0 auto;
  font-family: 'Arial', sans-serif;
}
/* auth-bar */
.auth-bar {
  text-align: right;
  font-size: 0.9rem;
  padding: 8px 0;
  color: #555;
}
.auth-bar a {
  margin: 0 8px;
  color: #555;
  text-decoration: none;
}
.auth-bar .arrow {
  font-size: 0.8rem;
}

/* header-main */
.header-main {
  display: flex;
  align-items: center;
  padding: 16px 0;
}
.logo {
  font-size: 1.8rem;
  font-weight: bold;
  color: #7f00ff;
  margin-right: 32px;
}
.primary-nav ul {
  display: flex;
  align-items: center;
  list-style: none;
  gap: 16px;
}
.primary-nav a {
  color: #333;
  font-weight: 500;
  text-decoration: none;
}
.primary-nav .divider {
  color: #ccc;
}
.search {
  flex: 1;
  display: flex;
  justify-content: center;
  position: relative;
}
.search input {
  width: 100%;
  max-width: 480px;
  height: 40px;
  padding: 0 16px;
  border: 1px solid #7f00ff;
  border-radius: 20px;
  outline: none;
}
.search input::placeholder {
  color: #aaa;
}
.search-icon {
  position: absolute;
  right: calc(50% - 240px + 16px);
  top: 50%;
  transform: translateY(-50%);
  font-size: 1.2rem;
  color: #7f00ff;
}
.icons {
  display: flex;
  gap: 24px;
  margin-left: 32px;
  font-size: 1.4rem;
}
.icons .icon {
  position: relative;
  cursor: pointer;
}
.icons .cart em {
  position: absolute;
  top: -6px;
  right: -10px;
  background: #7f00ff;
  color: #fff;
  font-size: 0.7rem;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* sub-nav */
.sub-nav {
  display: flex;
  align-items: center;
  padding: 12px 0;
  border-top: 1px solid #eee;
}
.btn-category {
  background: none;
  border: none;
  display: flex;
  align-items: center;
  font-size: 1rem;
  color: #333;
  cursor: pointer;
  margin-right: 32px;
}
.btn-category .menu-icon {
  font-size: 1.2rem;
  margin-right: 8px;
}
.secondary-nav {
  flex: 1;
  display: flex;
  justify-content: center;
}
.secondary-nav ul {
  display: flex;
  gap: 48px;
  list-style: none;
}
.secondary-nav a {
  color: #333;
  font-size: 1rem;
  font-weight: 500;
  text-decoration: none;
  padding: 4px 0;
}
.secondary-nav a.active {
  color: #7f00ff;
  border-bottom: 2px solid #7f00ff;
}
.delivery-info {
  background: none;
  border: 1px solid #7f00ff;
  border-radius: 20px;
  padding: 6px 14px;
  color: #7f00ff;
  font-size: 0.9rem;
  cursor: pointer;
}
</style>