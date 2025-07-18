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
    .file-input-group { margin-bottom: 8px; }
    .file-input-group input { margin-right: 8px; }
    .option { margin-bottom: 8px; }
    .option label { margin-right: 12px; }
    .btn { padding: 6px 12px; cursor: pointer; }
  </style>
</head>
<body>
  <h2>상품 등록 폼</h2>

  <form action="/item/register" method="post" enctype="multipart/form-data" >
    <input type="hidden" name="username" value="${sessionScope.username}" />

    <table>
      <tr>
        <th>카테고리</th>
        <td>
          <select name="category">
            <option value="PC">컴퓨터</option>
            <option value="notebook">노트북</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>상품명</th>
        <td><input type="text" name="itemTitle" required /></td>
      </tr>
      <tr>
        <th>내용</th>
        <td><textarea name="itemContent" rows="5" style="width:100%" required></textarea></td>
      </tr>
      <tr>
        <th>가격</th>
        <td><input type="number" name="itemAmount" min="100" required /> 원</td>
      </tr>
      <tr>
        <th>이미지</th>
        <td id="file-list">
          <div class="file-input-group">
            <input type="file" name="itemFile" accept="image/*" />
            <button type="button" class="add-file btn">추가</button>
          </div>
        </td>
      </tr>
    </table>

    <h3>옵션</h3>
    <div id="option-list">
      <div class="option">
        <input type="hidden" name="itemOption[0].optionNo" value="1" />
        <label>옵션명: <input name="itemOption[0].optionName" /></label>
        <label>옵션값: <input name="itemOption[0].optionValue" /></label>
        <label>재고: <input type="number" name="itemOption[0].stock" /></label>
        <button type="button" class="remove-option btn">삭제</button>
      </div>
    </div>
    <button type="button" id="add-option" class="btn">옵션 추가</button>

    <hr style="margin:16px 0" />
    <button type="submit" class="btn">등록하기</button>
  </form>

  <script>
    // 파일 input 동적 추가/삭제
    document.getElementById('file-list').addEventListener('click', function(e) {
      if (e.target.classList.contains('add-file')) {
        const container = document.getElementById('file-list');
        const group = document.createElement('div');
        group.className = 'file-input-group';

        const input = document.createElement('input');
        input.type = 'file';
        input.name = 'itemFile';
        input.accept = 'image/*';

        const addBtn = document.createElement('button');
        addBtn.type = 'button';
        addBtn.textContent = '추가';
        addBtn.className = 'add-file btn';

        const removeBtn = document.createElement('button');
        removeBtn.type = 'button';
        removeBtn.textContent = '삭제';
        removeBtn.className = 'btn';
        removeBtn.addEventListener('click', () => {
          if (container.querySelectorAll('.file-input-group').length > 1) {
            group.remove();
          }
        });

        group.append(input, addBtn, removeBtn);
        container.appendChild(group);
      }
    });

    // 옵션 추가
    document.getElementById('add-option').addEventListener('click', () => {
      const list = document.getElementById('option-list');
      const opts = list.querySelectorAll('.option');
      const idx  = opts.length;

      const newOpt = opts[0].cloneNode(true);
      newOpt.querySelectorAll('input').forEach(inp => {
        const name = inp.getAttribute('name');
        const suffix = name.substring(name.indexOf(']') + 1);
        inp.name = 'itemOption[' + idx + ']' + suffix;
        // 옵션 번호도 업데이트
        if (inp.type === 'hidden') {
          inp.value = idx + 1;
        } else {
          inp.value = '';
        }
      });

      list.appendChild(newOpt);
    });

    // 옵션 삭제
    document.getElementById('option-list').addEventListener('click', e => {
      if (e.target.classList.contains('remove-option')) {
        const groups = document.querySelectorAll('#option-list .option');
        if (groups.length > 1) {
          e.target.closest('.option').remove();
        }
      }
    });
  </script>
  
</body>
</html>
