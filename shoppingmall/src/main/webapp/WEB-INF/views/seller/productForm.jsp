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
  
  <form action="/item/register" method="post">
  <!-- enctype="multipart/form-data" -->
    
    <input type="hidden" name="username" value="${sessionScope.username}">
    

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
        <td><input type="number" name="itemAmount" min="100" required /> 원</td>
      </tr>
      <tr>
        <th>이미지</th>
        <td id="file-list">
        	<div class="file-input-group">
        	<input type="file" name="item_file" accept="image/*" /> 
        		<button type="button" class="add-file">추가</button>
        	</div>
       	 </td>
      </tr>
    </table>
	
    <h3>옵션</h3>
    <div id="option-list">
      <div class="option">
      	<input type="hidden" name="optionNo" value="1">
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
  
  function addFileInput(event) {
	    // 현재 클릭된 버튼의 상위 .file-input-group 요소
	    const group = event.target.closest('.file-input-group');
	    // file-list 컨테이너
	    const container = document.getElementById('file-list');
	    
	    // 새로운 그룹(div)을 만들어서 input+버튼 복제
	    const newGroup = document.createElement('div');
	    newGroup.className = 'file-input-group';
	    
	    const newInput = document.createElement('input');
	    newInput.type = 'file';
	    newInput.name = 'item_file';
	    newInput.accept = 'image/*';
	    
	    const newBtn = document.createElement('button');
	    newBtn.type = 'button';
	    newBtn.textContent = '추가';
	    newBtn.className = 'add-file';
	    // 새 버튼에도 동일한 클릭 핸들러 달기
	    newBtn.addEventListener('click', addFileInput);
	    
	    // 삭제 기능이 필요하면 버튼을 하나 더 만들어 주세요
	    const removeBtn = document.createElement('button');
	    removeBtn.type = 'button';
	    removeBtn.textContent = '삭제';
	    removeBtn.addEventListener('click', () => {
	      // 최소 한 개 남기고 삭제
	      if (container.querySelectorAll('.file-input-group').length > 1) {
	        newGroup.remove();
	      }
	    });
	    
	    newGroup.append(newInput, newBtn, removeBtn);
	    container.appendChild(newGroup);
	  }
  	
 	document.querySelectorAll('.add-file')
  .forEach(btn => btn.addEventListener('click', addFileInput));
    // 옵션 추가
  document.getElementById('add-option').addEventListener('click', () => {
    const list   = document.getElementById('option-list');
    const opts   = list.querySelectorAll('.option');
    const nextNo = opts.length + 1;               // 다음 옵션 번호

    // 1) 첫 번째 옵션 블록(cloneNode) 복제
    const newOpt = opts[0].cloneNode(true);

    // 2) 히든 필드(optionNo) 값 갱신
    newOpt.querySelector('input[name="optionNo"]').value = nextNo;

    // 3) 나머지 입력 필드는 빈 값으로 초기화
    newOpt.querySelector('input[name="optionName"]').value  = '';
    newOpt.querySelector('input[name="optionValue"]').value = '';
    newOpt.querySelector('input[name="stock"]').value       = '';

    // 4) 삭제 버튼이 제대로 동작하도록(이벤트 위임 대신 개별 바인딩할 때만)
    //    remove-option 이벤트 바인딩이 이미 위임으로 걸려 있다면 생략해도 OK
    // newOpt.querySelector('.remove-option')
    //       .addEventListener('click', removeHandler);

    // 5) 리스트에 추가
    list.appendChild(newOpt);
  });

  // 기존에 있던 삭제 버튼 위임 이벤트
  document.getElementById('option-list').addEventListener('click', e => {
    if (e.target.classList.contains('remove-option')) {
      const groups = document.querySelectorAll('#option-list .option');
      if (groups.length > 1) {
        e.target.closest('.option').remove();
        // (선택) 삭제 후 번호 재정렬 로직을 넣고 싶다면 여기서 다시 순번 매겨도 됩니다.
      }
    }
  });
  </script>
</body>
</html>
