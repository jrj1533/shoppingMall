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
  
  <form action="/item/register" method="post" enctype="multipart/form-data" > 
    
    <input type="hidden" name="username" value="${sessionScope.username}">
    

    <table>
      <tr>
      	<th>카테고리</th>
      	<td><select name="category">
      		<option value="PC">컴퓨터	</option>
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
        	<input type="file" name="itemFile[0]" accept="image/*" /> 
        		<button type="button" class="add-file">추가</button>
        	</div>
       	 </td>
      </tr>
    </table>
	
    <h3>옵션</h3>
<div id="option-list">
  <div class="option">
    <input type="hidden" name="itemOption[0].optionNo" value="1" />
    <label>옵션명:   <input  name="itemOption[0].optionName" /></label>
    <label>옵션값:   <input name="itemOption[0].optionValue" /></label>
    <label>재고:     <input type="number" name="itemOption[0].stock"    /></label>
    <button class="remove-option">삭제</button>
  </div>
</div>
<button id="add-option">옵션 추가</button>


    <hr style="margin:16px 0" />
    <button type="submit" class="btn">등록하기</button>
  </form>

  <script>
  
  function addFileInput(event) {
	    // 현재 클릭된 버튼의 상위 .file-input-group 요소
	    const group = event.target.closest('.file-input-group');
	    // file-list 컨테이너
	    const container = document.getElementById('file-list');
	    const num = 0 + 1;
	    
	    // 새로운 그룹(div)을 만들어서 input+버튼 복제
	    const newGroup = document.createElement('div');
	    newGroup.className = 'file-input-group';
	    
	    const newInput = document.createElement('input');
	    newInput.type = 'file';
	    newInput.name = 'itemFile['+num+ ']';
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
  const list = document.getElementById('option-list');
  const opts = list.querySelectorAll('.option');
  const idx  = opts.length;          // 0-based

  // 1) 템플릿 복제
  const newOpt = opts[0].cloneNode(true);

  // 2) name 속성 전체 교체
  newOpt.querySelectorAll('input').forEach(inp => {
    const parts = inp.name.split(']');
    if (parts.length === 2) {
      const suffix = parts[1];      // ".optionName" 등
      inp.name = 'itemOption[' + idx + ']' + suffix;
      inp.value = inp.type === 'hidden' ? idx + 1 : inp.type === 'number'? 0 :'';
    }
  });

  // 3) 추가
  list.appendChild(newOpt);
});


  // 옵션 삭제 (이벤트 위임)
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
