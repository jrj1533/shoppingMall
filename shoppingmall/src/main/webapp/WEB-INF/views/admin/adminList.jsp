<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	
	 .header-container { max-width: 1200px; margin: 0 auto; font-family: 'Arial', sans-serif; }
  /* auth-bar */
  .auth-bar { text-align: right; font-size: 0.9rem; padding: 8px 0; color: #555; }
  .auth-bar .member-menu { display: inline-block; cursor: pointer; margin: 0 4px; }
  .auth-bar .member-menu .arrow { font-size: 0.8rem; margin-left: 2px; }
	
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

<script type="text/javascript">
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
        <li><a href="/admin/adminList">관리자리스트</a></li>
        <li><a href="/userList">회원리스트</a></li>
        <li><a href="/logOut">로그아웃</a></li>
      
      </ul>
      </c:when>
      </c:choose>
     </div>
    </div>
   </div>
<body>
<!-- 등록 버튼 -->
<button onclick="location.href='/mainPage'">홈</button>
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