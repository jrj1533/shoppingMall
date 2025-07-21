<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <title>간단 상품관리</title>
  <style>
    body { margin:0; font-family:Arial,sans-serif; background:#f5f5f5; }
    header {
      display:flex; align-items:center; justify-content:space-between;
      padding:12px 24px; background:#fff;
      box-shadow:0 1px 4px rgba(0,0,0,0.1);
    }
    .logo { font-size:1.5rem; font-weight:bold; color:#7b1fa2; }
    nav { display:flex; align-items:center; }
    nav button {
      background:none; border:none; padding:8px 16px; font-size:1rem;
      cursor:pointer; color:#555;
    }
    nav button.active { color:#7b1fa2; border-bottom:2px solid #7b1fa2; }
    #back-btn { margin-left:16px; background:#ccc; color:#333; border-radius:4px; }
    main { padding:24px; }
    .hidden { display:none; }
    .product-grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(180px,1fr)); gap:16px; }
    .card { background:#fff; border-radius:8px; box-shadow:0 1px 3px rgba(0,0,0,0.1);
      display:flex; flex-direction:column; overflow:hidden; }
    .card img { width:100%; aspect-ratio:1; object-fit:cover; }
    .card .info { padding:12px; flex:1; }
    .card .actions { text-align:center; padding:12px; }
    .card button { background:#7b1fa2;color:#fff;border:none;padding:6px 12px;border-radius:16px; cursor:pointer; }
    table { width:100%; border-collapse:collapse; margin-top:16px; }
    th,td { border:1px solid #ddd; padding:8px; text-align:left; }
    th { background:#fafafa; }
    .pagination a { margin:0 4px; text-decoration:none; }
    .pagination a.active { font-weight:bold; color:#7b1fa2; }
  </style>
</head>
<body>

  <header>
    <div class="logo">Admin Panel</div>
    <nav>
      <button data-view="list" class="active">상품 리스트</button>
      <button data-view="requests">등록 요청</button>
      <button data-view="logs">로그</button>
      <button id="back-btn">메인페이지로</button>
    </nav>
  </header>

  <main>
    <!-- 상품 리스트 -->
    <section id="view-list">
      <div class="product-grid">
        <div class="card">
          <img src="https://via.placeholder.com/200?text=상품+1" alt="상품1"/>
          <div class="info">
            <p>예시 상품 1</p>
            <strong>9,900원</strong>
          </div>
          <div class="actions"><button>수정</button></div>
        </div>
      </div>
    </section>

    <!-- 등록 요청 -->
    <section id="view-requests" class="hidden">
      <table>
        <thead>
          <tr><th>요청 ID</th><th>판매자</th><th>카테고리</th><th>상품명</th><th>요청일</th><th>액션</th></tr>
        </thead>
        <tbody>
          <c:forEach var="item" items="${requestingItem}">
          <tr>
            <td>${item.itemNo}</td>
            <td>${item.username}</td>
            <td>${item.category}</td>
            <td>${item.itemTitle}</td>
            <td>${item.createDate}</td>
            <td><button type="button"
                class="approve-btn"
                data-item-no="${item.itemNo}">
		          승인
		        </button>
		        <button type="button"
		                class="reject-btn"
		                data-item-no="${item.itemNo}">
		         거절
		        </button>
         </td>
          </tr>
          </c:forEach>
        </tbody>
      </table>

      <div class="pagination">
        <c:if test="${startPage > 1}">
          <a href="?page=${startPage-1}&amp;view=requests">이전 10페이지</a>
        </c:if>
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
          <a href="?page=${i}&amp;view=requests"
             class="${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>
        <c:if test="${endPage < lastPage}">
          <a href="?page=${endPage+1}&amp;view=requests">다음 10페이지</a>
        </c:if>
      </div>
    </section>

    <!-- 로그 -->
    <section id="view-logs" class="hidden">
      <table>
        <thead>
          <tr><th>로그 ID</th><th>판매자</th><th>상품</th><th>시간</th><th>내용</th></tr>
        </thead>
        <tbody>
          <tr>
            <td>LOG-1001</td><td>홍길동</td><td>신상품 A</td><td>2025-07-17 10:30</td><td>가격 변경</td>
          </tr>
        </tbody>
      </table>
    </section>
  </main>

  <script>
  // 초기 뷰 설정: 서버 사이드에서 전달한 model의 view 속성 읽기
  document.addEventListener('DOMContentLoaded', function() {
    // JSP 표현식으로 view 값 주입
    var view = '${view}';  // 서버에서 model.addAttribute("view", view) 해주셔야 합니다.
    if (!view) {
      view = 'list';
    }
    // 문자열 연결 방식으로 셀렉터 생성
    var selector = 'nav button[data-view="' + view + '"]';
    var btn = document.querySelector(selector);
    if (btn) {
      btn.click();
    }
  });

  const buttons = document.querySelectorAll('nav button[data-view]');
  const backBtn = document.getElementById('back-btn');
  let prevView = 'list';

  buttons.forEach(function(btn) {
    btn.addEventListener('click', function() {
      buttons.forEach(function(b) { b.classList.remove('active'); });
      btn.classList.add('active');
      document.querySelectorAll('main section').forEach(function(sec) { sec.classList.add('hidden'); });
      document.getElementById('view-' + btn.dataset.view).classList.remove('hidden');
    });
  });


  
  backBtn.addEventListener('click', function() {
    window.location.href = '/mainPage';
  });
</script>

<script type="text/javascript">
$(document).on('click', '.approve-btn', function() {
    const itemNo = $(this).data('item-no');
    const view = $('nav button.active').data('view');
    $.ajax({
      url: '/items/approve',
      type: 'POST',
      data: { itemNo: itemNo,
    	  	  view : view },
      success: function(res) {
        alert('승인 완료');
        // 원하는 동작: 해당 행 제거 또는 전체 리로드
        window.location.href= window.location.pathname + '?view=' +res;
      },
      error: function(xhr, status, err) {
        console.error(xhr.responseText);
        alert('승인 실패');
      }
    });
  });


$(document).on('click', '.reject-btn', function() {
	const itemNo = $(this).data('item-no');
	const view = $('nav button.active').data('view');
	  $.ajax({
		    url: '/items/notapprove',
		    type: 'POST',
		    data: { itemNo: itemNo, view: view },
		    success: function(res){
		      alert('상품 미승인 완료');
		      window.location.href = window.location.pathname + '?view=' + res;
		    },
		    error: function(xhr, status, errorThrown){
		      const msg = xhr.responseJSON?.message || errorThrown;
		      alert('상품 미승인 실패: ' + msg);
		    }
		  });
		});

</script>
</body>
</html>
