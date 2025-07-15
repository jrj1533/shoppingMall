<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>상품 등록</title>
  <style>
    table { border-collapse: collapse; width: 600px; margin-bottom: 16px; }
    th, td { padding: 8px; border: 1px solid #ddd; }
    .option { margin-bottom: 8px; }
    .option label { margin-right: 12px; }
    .btn { padding: 6px 12px; cursor: pointer; }
  </style>
</head>
<body>
  <h2>상품 등록 폼</h2>
  
  <form action="/item/register" method="post" enctype="multipart/form-data">
    <!-- (서버에서 세션으로 seller username 처리) -->

    <table>
      <tr>
        <th>상품명</th>
        <td><input type="text" name="itemTitle" required /></td>
      </tr>
      <tr>
        <th>내용</th>
        <td>
          <textarea name="itemContent" rows="5" style="width:100%" required></textarea>
        </td>
      </tr>
      <tr>
        <th>가격</th>
        <td><input type="number" name="itemAmount" min="0" required /> 원</td>
      </tr>
      <tr>
        <th>이미지 (선택)</th>
        <td><input type="file" name="item_file" accept="image/*" />  </td>
      </tr>
    </table>

    <h3>옵션</h3>
    <div id="option-list">
      <div class="option">
        <label>옵션명: <input type="text" name="optionName" /></label>
        <label>옵션값: <input type="text" name="optionValue" /></label>
        <label>재고: <input type="number" name="stock" min="0" /></label>
        <button type="button" class="remove-option btn">삭제</button>
      </div>
    </div>
    <button type="button" id="add-option" class="btn">옵션 추가</button>
    <hr style="margin:16px 0" />
    <button type="submit" class="btn">등록하기</button>
  </form>

  <script>
    // 옵션 추가
    document.getElementById('add-option').addEventListener('click', () => {
      const tpl = document.querySelector('#option-list .option').cloneNode(true);
      document.getElementById('option-list').appendChild(tpl);
    });
    // 옵션 삭제
    document.getElementById('option-list').addEventListener('click', e => {
      if (e.target.classList.contains('remove-option')) {
        const opts = document.querySelectorAll('#option-list .option');
        // 최소 한 개는 남기기
        if (opts.length > 1) {
          e.target.closest('.option').remove();
        }
      }
    });
  </script>
</body>
</html>
