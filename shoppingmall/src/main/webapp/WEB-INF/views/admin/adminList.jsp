<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 리스트</title>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- 기본 스타일 -->
<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background: #f4f4f4;
    margin: 0;
    padding: 40px;
  }

  h3 {
    margin-top: 0;
  }

  button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 10px 20px;
    margin: 5px 0;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
  }

  button:hover {
    background-color: #45a049;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    margin-top: 20px;
    box-shadow: 0 0 5px rgba(0,0,0,0.1);
  }

  th, td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
  }

  th {
    background-color: #f8f8f8;
  }

  /* 모달 스타일 */
  #adminModal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0; top: 0;
    width: 100%; height: 100%;
    background-color: rgba(0,0,0,0.4);
  }

  .modal-content {
    background-color: white;
    margin: 10% auto;
    padding: 20px;
    width: 320px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
  }

  .modal-content input, .modal-content select {
    width: 100%;
    padding: 8px;
    margin-top: 10px;
    margin-bottom: 15px;
    border-radius: 5px;
    border: 1px solid #ccc;
  }

  .modal-footer {
    text-align: right;
  }
  
  .delete-btn {
		display: inline-block;
		margin: 0 -50px;
		padding: 5px 10px;
		font-size: 14px;
		color: #333;
		border: 1px solid #ccc;
		border-radius: 4px;
		background-color: #fff;
		text-decoration: none;
		cursor: pointer;
		transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
	}
	
	.delete-btn:hover,
	.delete-btn:hover {
		background-color: #eee;
		color: #000;
	}
</style>

<script>
function createAdmin() {
  var adminId = $('#adminId').val();
  var password = $('#password').val();
  var roleNo = $('#roleNo').val();

  $.ajax({
    url: '/admin/add',
    method: 'POST',
    contentType: 'application/json',
    data: JSON.stringify({
      adminId: adminId,
      password: password,
      roleNo: roleNo
    }),
    success: function (msg) {
        // 성공 메시지가 "이미 존재하는 아이디입니다."이면 모달 닫지 않음
        if (msg.includes("이미 존재")) {
          alert(msg);
          return; // 종료해서 아래 코드 실행 안 되게 함
        }

        // 성공적으로 등록된 경우
        alert(msg);
        $('#adminModal').hide();   // 모달 닫기
        location.reload();         // 새로고침
      },
      error: function () {
        alert('등록 실패!');
        // 여기선 모달 닫지 않음
      }
  });
}

$(document).on('click', '.delete-btn', function () {
	  const adminNo = $(this).data('adminno');

	  if (confirm('정말 삭제하시겠습니까?')) {
	    $.ajax({
	      url: '/admin/delete/' + adminNo, // 이 경로는 컨트롤러에서 처리 필요
	      type: 'DELETE',
	      success: function (msg) {
	        alert(msg);
	        location.reload(); // 리스트 갱신
	      },
	      error: function () {
	        alert('삭제 실패!');
	      }
	    });
	  }
	});
</script>
</head>

<body>

<!-- 등록 버튼 -->
<button onclick="$('#adminModal').show();">+ 관리자 등록</button>

<!-- 모달 -->
<div id="adminModal">
  <div class="modal-content">
    <h3>관리자 등록</h3>
    <input type="text" id="adminId" placeholder="아이디">
    <input type="password" id="password" placeholder="비밀번호">
    <input type="hidden" id="roleNo" value="1">
    <input type="text" value="관리자" readonly>
    <div class="modal-footer">
      <button onclick="createAdmin()">등록</button>
      <button onclick="$('#adminModal').hide();">닫기</button>
    </div>
  </div>
</div>

<!-- 관리자 리스트 테이블 -->
<table>
  <thead>
    <tr>
      <th>No</th>
      <th>아이디</th>
      <th>권한</th>
      <th>삭제</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${adminList}">
      <tr>
        <td>${list.adminNo}</td>
        <td>${list.adminId}</td>
        <td>
          <c:choose>
            <c:when test="${list.roleNo == 4}">통합관리자</c:when>
            <c:when test="${list.roleNo == 1}">관리자</c:when>
          </c:choose>
        </td>
          <td>
          <c:choose>
			 <c:when test="${list.roleNo == 1}">
			  <a class="delete-btn" data-adminno="${list.adminNo}">삭제</a>
			</c:when>
		</c:choose>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

</body>
</html>