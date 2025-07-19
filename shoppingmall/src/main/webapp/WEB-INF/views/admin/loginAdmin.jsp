<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Kurly Login Page</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: white;
    }

    header {
      background-color: #6B21A8;
      color: white;
      padding: 10px 16px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      font-size: 20px;
      font-weight: bold;
    }

    .form-container {
      max-width: 400px;
      margin: 60px auto 0;
      padding: 24px;
      text-align: center;
    }

    .form-container h2 {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 24px;
    }

    .form-input {
      display: block;
      width: 100%;
      padding: 12px;
      margin-bottom: 16px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
      box-sizing: border-box;
    }

    .form-button {
      display: block;
      width: 100%;
      padding: 12px;
      background-color: #6B21A8;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 14px;
      cursor: pointer;
      transition: background-color 0.2s;
      box-sizing: border-box;
    }

    .form-button:hover {
      background-color: #581C87;
    }

    footer {
      text-align: center;
      font-size: 12px;
      color: #6B7280;
      padding: 24px 0;
    }
    
    /* 모달 스타일 */
    .modal {
      display: none; /* 기본은 숨김 */
      position: fixed;
      z-index: 999;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0,0,0,0.4);
    }

    .modal-content {
      background-color: #fff;
      margin: 15% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 300px;
      border-radius: 8px;
      text-align: center;
    }

    .close-btn {
      background-color: #6B21A8;
      color: white;
      border: none;
      padding: 8px 16px;
      border-radius: 4px;
      cursor: pointer;
      margin-top: 10px;
    }
    
  </style>
</head>
<body>

  <!-- 헤더 -->
  <header>
    <div>Kurly</div>
  </header>

  <!-- 로그인 폼 -->
  <form action="/admin/loginAdmin" method="post">
    <div class="form-container">
      <h2>관리자 로그인</h2>

      <input type="text" name="adminId" placeholder="아이디를 입력해주세요" class="form-input" required>
      <input type="password" name="password" placeholder="비밀번호를 입력해주세요" class="form-input" required>
      <button type="submit" class="form-button">로그인</button>
    </div>
  </form>
  <!-- 모달 영역 -->
  <c:if test="${not empty errorMessage}">
    <div id="errorModal" class="modal">
      <div class="modal-content">
        <p>${errorMessage}</p>
        <button class="close-btn" onclick="closeModal()">닫기</button>
      </div>
    </div>
  </c:if>
  <!-- 푸터 -->
  <footer>
    고객센터 1644-1107 | 월-토 오전 7시~오후 6시<br>
    © Kurly Corp. All Rights Reserved.
  </footer>
  <!-- 모달 제어 스크립트 -->
  <script>
    function closeModal() {
      document.getElementById("errorModal").style.display = "none";
    }

    // 페이지 로드 후 모달 자동 열기
    window.onload = function() {
      const modal = document.getElementById("errorModal");
      if(modal) modal.style.display = "block";
    }
  </script>
</body>
</html>